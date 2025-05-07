import 'package:fl_chart/fl_chart.dart';
import 'package:fyrebox_admin/core/app_export.dart';
import 'package:fyrebox_admin/data/models/invoice_model.dart';
import 'package:fyrebox_admin/presentation/deshboard_screen/provider/deshboard_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:syncfusion_flutter_core/theme.dart';

class DeshboardScreen extends StatelessWidget {
  const DeshboardScreen({super.key});

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DeshboardProvider(),
      child: const DeshboardScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DeshboardProvider(),
      child: Scaffold(
        body: Consumer<DeshboardProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildStatCard(
                          'Organizations',
                          '${provider.deshboardModel.dBDATA?.totalOrgs ?? 0}',
                          Colors.blue,
                          '-0.5%'),
                      _buildStatCard(
                          'Devices',
                          '${provider.deshboardModel.dBDATA?.totalDevices ?? 0}',
                          Colors.purple,
                          '+0.5%'),
                      _buildStatCard(
                          'Revenue',
                          '${provider.deshboardModel.dBDATA?.totalRevenue ?? 0}',
                          Colors.green,
                          '+15%'),
                      _buildStatCard(
                          'Due Invoices',
                          '${provider.deshboardModel.dBDATA?.totalDueInvoices ?? 0}',
                          Colors.red,
                          '0.0%'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  _buildMonthlySalesReport(provider),
                  const SizedBox(height: 16.0),
                  _buildWeeklyTopProductsChart(provider),
                  const SizedBox(height: 16.0),
                  _buildInvoiceList(context, provider),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String count, Color color, String percentage) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16.0, color: color),
            ),
            Text(
              count,
              style: TextStyle(
                  fontSize: 28.0, fontWeight: FontWeight.bold, color: color),
            ),
            Text(
              percentage,
              style: TextStyle(fontSize: 16.0, color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlySalesReport(DeshboardProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monthly Sales Report',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
                '${provider.deshboardModel.dBDATA?.thisMonthTotalSalesAmount ?? 0} August',
                style: const TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyTopProductsChart(DeshboardProvider provider) {
    final List<int> revenues =
        provider.deshboardModel.dBDATA?.thisMonthRevenue ?? [12, 78, 90, 67];
    final double totalRevenue = revenues.reduce((a, b) => a + b).toDouble();

    if (totalRevenue == 0) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekly Top Products',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('Last Week', style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 16.0),
              Text('No revenue data available for this period.',
                  style: TextStyle(fontSize: 14.0)),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Top Products',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text('Last Week', style: TextStyle(fontSize: 16.0)),
            const SizedBox(height: 16.0),
            AspectRatio(
              aspectRatio: 1.5,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue,
                      value: (revenues[0] / totalRevenue) * 100,
                      title: 'Item 1',
                      radius: 50,
                      titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    PieChartSectionData(
                      color: Colors.purple,
                      value: (revenues[1] / totalRevenue) * 100,
                      title: 'Item 2',
                      radius: 50,
                      titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    PieChartSectionData(
                      color: Colors.orange,
                      value: (revenues[2] / totalRevenue) * 100,
                      title: 'Item 3',
                      radius: 50,
                      titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: (revenues[3] / totalRevenue) * 100,
                      title: 'Item 4',
                      radius: 50,
                      titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceList(BuildContext context, DeshboardProvider provider) {
    if (provider.invoiceModel.dBDATA == null ||
        provider.invoiceModel.dBDATA!.isEmpty) {
      return const Center(child: Text("No invoices available"));
    }

    final invoiceDataSource = InvoiceDataSource(
      context: context,
      invoices: provider.invoiceModel.dBDATA!,
      onDelete: _showDeleteConfirmationDialog,
      onView: _showInvoiceDetailsBottomSheet,
    );

    return SfDataGridTheme(
      data: SfDataGridThemeData(
          headerColor: appTheme.deepOrangeA100,
          gridLineColor: appTheme.pink300),
      child: SfDataGrid(
        source: invoiceDataSource,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'id',
            label: const Center(child: Text('No.')),
          ),
          GridColumn(
            columnName: 'clientName',
            label: const Center(child: Text('Client Name')),
          ),
          GridColumn(
            columnName: 'amount',
            label: const Center(child: Text('Amount (PKR)')),
          ),
          GridColumn(
            columnName: 'generateDate',
            label: const Center(child: Text('Generate Date')),
          ),
          GridColumn(
            columnName: 'dueDate',
            label: const Center(child: Text('Due Date')),
          ),
          GridColumn(
            columnName: 'status',
            label: const Center(child: Text('Status')),
          ),
          GridColumn(
            columnName: 'actions',
            label: const Center(child: Text('Actions')),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, DBDATA invoice) {
    final provider = Provider.of<DeshboardProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Invoice'),
          content: const Text('Are you sure you want to delete this invoice?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                // Implement delete functionality
                provider.deleteInvoice(invoice.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showInvoiceDetailsBottomSheet(BuildContext context, DBDATA invoice) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Invoice Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Client:    ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      invoice.orgName ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Amount:   ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${invoice.totalAmount} PKR',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Generate Date:   ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      invoice.generationDateFormated ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Due Date:  ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      invoice.dueDateFormated ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      'Status: ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'active', // invoice.status ?? '',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class InvoiceDataSource extends DataGridSource {
  InvoiceDataSource({
    required this.context,
    required List<DBDATA> invoices,
    required this.onDelete,
    required this.onView,
  }) {
    _invoices = invoices
        .map<DataGridRow>((invoice) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'id', value: invoice.id.toString()),
              DataGridCell<Widget>(
                  columnName: 'clientName',
                  value: Row(
                    children: [
                      // CircleAvatar(
                      //   child: CustomImageView(
                      //     imagePath: invoice.orgLogo,
                      //   ),
                      // ),
                      Text(invoice.orgName ?? '')
                    ],
                  )),
              DataGridCell<int>(
                  columnName: 'amount', value: invoice.totalAmount ?? 0),
              DataGridCell<String>(
                  columnName: 'generateDate',
                  value: invoice.generationDateFormated ?? ''),
              DataGridCell<String>(
                  columnName: 'dueDate', value: invoice.dueDateFormated ?? ''),
              DataGridCell<String>(
                  columnName: 'status', value: invoice.status ?? ''),
              DataGridCell<Widget>(
                  columnName: 'actions',
                  value: PopupMenuButton<String>(
                    onSelected: (String value) {
                      if (value == 'View') {
                        onView(context, invoice);
                      } else if (value == 'Delete') {
                        onDelete(context, invoice);
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {'View', 'Delete'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  )),
            ]))
        .toList();
  }

  final BuildContext context;
  final Function(BuildContext, DBDATA) onDelete;
  final Function(BuildContext, DBDATA) onView;
  List<DataGridRow> _invoices = [];

  @override
  List<DataGridRow> get rows => _invoices;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Center(child: Text(row.getCells()[0].value.toString())),
      Center(child: row.getCells()[1].value),
      Center(child: Text(row.getCells()[2].value.toString())),
      Center(child: Text(row.getCells()[3].value.toString())),
      Center(child: Text(row.getCells()[4].value.toString())),
      Center(
          child: Text(
        row.getCells()[5].value.toString(),
        style: TextStyle(
            color: row.getCells()[5].value.toString() == 'Paid'
                ? Colors.green
                : Colors.red),
      )),
      Center(child: row.getCells()[6].value),
    ]);
  }
}
