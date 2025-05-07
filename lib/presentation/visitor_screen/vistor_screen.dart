import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:provider/provider.dart';
import '../../core/app_export.dart';
import '../../data/models/orgization_model.dart';
import 'provider/vistor_provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class OrganizationScreen extends StatefulWidget {
  const OrganizationScreen({super.key});

  @override
  _OrganizationScreenState createState() => _OrganizationScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrganizationProvider(),
      child: const OrganizationScreen(),
    );
  }
}

class _OrganizationScreenState extends State<OrganizationScreen> {
  late OrganizationDataSource _organizationDataSource;

  void _showOrganizationDetailsBottomSheet(BuildContext context, DBDATA org) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Organization Details',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 16),
                Text('Org ID: ${org.id ?? "N/A"}'),
                Text('Org Name: ${org.orgName ?? "N/A"}'),
                Text('Email: ${org.orgEmail ?? "N/A"}'),
                Text('Phone: ${org.orgPhone ?? "N/A"}'),
                Text('Registration Date: ${org.entryTimeFormated ?? "N/A"}'),
                Text('Status: ${org.status == '1' ? 'Active' : 'Inactive'}'),
                Text('Address: ${org.address ?? "N/A"}'),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, DBDATA org, OrganizationProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete ${org.orgName}?'),
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
                // provider.deleteOrganization(org); // Call provider delete method
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSendQuotationDialog(
      BuildContext context, OrganizationProvider provider, DBDATA org) {
    final TextEditingController subjectController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Quotation'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: subjectController,
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                  ),
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Send'),
              onPressed: () {
                // Add code to handle sending the quotation here.
                provider.sendQuation(org.id.toString(),
                    descriptionController.text, subjectController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrganizationProvider(),
      child: Consumer<OrganizationProvider>(
        builder: (context, provider, child) {
          if (provider.model.dBDATA == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.model.dBDATA!.isEmpty) {
            return const Center(child: Text('No organizations available'));
          }

          _organizationDataSource = OrganizationDataSource(
            provider.model.dBDATA!,
            onDelete: (org) =>
                _showDeleteConfirmationDialog(context, org, provider),
            onView: (org) => _showOrganizationDetailsBottomSheet(context, org),
            onSendQuotation: (org) =>
                _showSendQuotationDialog(context, provider, org),
          );

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                NavigatorService.pushNamed(AppRoutes.addOrganizationScreen);
              },
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              title: const Text('Organizations'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SfDataGridTheme(
                data: SfDataGridThemeData(
                    headerColor: appTheme.deepOrangeA100,
                    gridLineColor: appTheme.pink300),
                child: SfDataGrid(
                  source: _organizationDataSource,
                  columns: <GridColumn>[
                    GridColumn(
                        columnName: 'No.',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'No.',
                              overflow: TextOverflow.ellipsis,
                            ))),
                    GridColumn(
                        columnName: 'Client Name',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Client Name',
                              overflow: TextOverflow.ellipsis,
                            ))),
                    GridColumn(
                        columnName: 'Type',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Type',
                              overflow: TextOverflow.ellipsis,
                            ))),
                    GridColumn(
                        columnName: 'Reg Date',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Reg Date',
                              overflow: TextOverflow.ellipsis,
                            ))),
                    GridColumn(
                        columnName: 'Status',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Status',
                              overflow: TextOverflow.ellipsis,
                            ))),
                    GridColumn(
                        columnName: 'Actions',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Actions',
                              overflow: TextOverflow.ellipsis,
                            ))),
                  ],
                  columnWidthMode: ColumnWidthMode.fitByCellValue,
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrganizationDataSource extends DataGridSource {
  OrganizationDataSource(this.organizations,
      {required this.onDelete,
      required this.onView,
      required this.onSendQuotation}) {
    _dataGridRows = organizations
        .map<DataGridRow>((org) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: 'No.', value: organizations.indexOf(org) + 1),
              DataGridCell<String>(
                  columnName: 'Client Name', value: org.orgName ?? ''),
              DataGridCell<String>(
                  columnName: 'Type', value: org.orgTypeName ?? ''),
              DataGridCell<String>(
                  columnName: 'Reg Date', value: org.entryTimeFormated ?? ''),
              DataGridCell<String>(
                  columnName: 'Status',
                  value: org.status == '1' ? 'Active' : 'Inactive'),
              DataGridCell<Widget>(
                columnName: 'Actions',
                value: PopupMenuButton<String>(
                  onSelected: (String value) {
                    if (value == 'View') {
                      onView(org);
                    } else if (value == 'Delete') {
                      onDelete(org);
                    } else if (value == 'Assign Admin') {
                      NavigatorService.pushNamed(AppRoutes.addOrgScreen1);
                    } else if (value == 'Send Quotation') {
                      onSendQuotation(org);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'View', 'Assign Admin', 'Send Quotation', 'Delete'}
                        .map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ),
            ]))
        .toList();
  }

  List<DataGridRow> _dataGridRows = [];
  List<DBDATA> organizations;
  final Function(DBDATA) onDelete;
  final Function(DBDATA) onView;
  final Function(DBDATA) onSendQuotation;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(row.getCells()[0].value.toString()),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(row.getCells()[1].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(row.getCells()[2].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(row.getCells()[3].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(row.getCells()[4].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: row.getCells()[5].value,
      ),
    ]);
  }
}
