import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../data/models/orderdevice.dart';
import '../../theme/theme_helper.dart';
import 'provider/orderdevice_provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class OrderDeviceScreen extends StatefulWidget {
  const OrderDeviceScreen({super.key});

  @override
  OrderDeviceScreenState createState() => OrderDeviceScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderDeviceProvider(),
      child: const OrderDeviceScreen(),
    );
  }
}

class OrderDeviceScreenState extends State<OrderDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Device(s)'),
      ),
      body: Consumer<OrderDeviceProvider>(builder: (context, provider, child) {
        if (provider.data.dBDATA == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SfDataGridTheme(
          data: SfDataGridThemeData(
              headerColor: appTheme.deepOrangeA100,
              gridLineColor: appTheme.pink300),
          child: SfDataGrid(
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            source: OrderDeviceDataSource(
              provider.data.dBDATA!,
              onView: (order) => _showOrderDetails(context, order),
              onEdit: (order) => _editOrder(context, order),
              onDelete: (order) => _confirmDelete(context, order, provider),
            ),
            columns: [
              GridColumn(
                  columnName: 'ID',
                  label: const Center(
                      child: Text('Order',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              GridColumn(
                  columnName: 'Org Name',
                  label: const Center(
                      child: Text('Client Name',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              GridColumn(
                  columnName: 'Device Type',
                  label: const Center(
                      child: Text('Device Type',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              GridColumn(
                  columnName: 'Quantity',
                  label: const Center(
                      child: Text('Quantity',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              GridColumn(
                  columnName: 'Description',
                  label: const Center(
                      child: Text('Description',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              GridColumn(
                  columnName: 'Status',
                  label: const Center(
                      child: Text('Status',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              GridColumn(
                columnName: 'Actions',
                label: const Center(
                  child: Text('Actions',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showOrderDetails(BuildContext context, DBDATA order) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Text(
                'Order Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              _buildDetailRow('ID', order.id.toString()),
              _buildDetailRow('Org Name', order.orgName ?? ''),
              _buildDetailRow('Device Type', order.deviceTypeName ?? ''),
              _buildDetailRow('Quantity', order.deviceQuantity.toString()),
              _buildDetailRow('Description', order.deviceDescription ?? ''),
              _buildDetailRow(
                'Status',
                order.status == '1' ? 'Fulfilled' : 'Pending',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  void _editOrder(BuildContext context, DBDATA order) {
    // Navigate to an edit screen or show an edit dialog
    // NavigatorService.pushNamed(AppRoutes.editOrderScreen, arguments: order);
  }

  void _confirmDelete(
      BuildContext context, DBDATA order, OrderDeviceProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Order'),
        content: const Text('Are you sure you want to delete this order?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              provider.deleteOrder(order.id.toString());
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class OrderDeviceDataSource extends DataGridSource {
  final Function(DBDATA) onView;
  final Function(DBDATA) onEdit;
  final Function(DBDATA) onDelete;

  OrderDeviceDataSource(this.orders,
      {required this.onView, required this.onEdit, required this.onDelete}) {
    _dataGridRows = orders.map<DataGridRow>((order) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'ID', value: order.id),
        DataGridCell<String>(columnName: 'Org Name', value: order.orgName),
        DataGridCell<String>(
            columnName: 'Device Type', value: order.deviceTypeName),
        DataGridCell<String>(
            columnName: 'Quantity', value: '   ${order.deviceQuantity}   '),
        DataGridCell<String>(
            columnName: 'Description', value: order.deviceDescription),
        DataGridCell<String>(
            columnName: 'Status',
            value: order.status == '1' ? 'Fulfilled' : 'Pending'),
        DataGridCell<Widget>(
          columnName: 'Actions',
          value: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'View') {
                onView(order);
              } else if (value == 'Delete') {
                onDelete(order);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'View', child: Text('View Details')),
              // const PopupMenuItem(value: 'Delete', child: Text('Delete')),
            ],
          ),
        ),
      ]);
    }).toList();
  }

  List<DataGridRow> _dataGridRows = [];
  final List<DBDATA> orders;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Center(
          child: dataGridCell.value is Widget
              ? dataGridCell.value as Widget
              : Text(
                  dataGridCell.value.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
        );
      }).toList(),
    );
  }
}
