// import 'package:fyrebox_admin/data/models/recycle_bin_model.dart';
import 'package:fyrebox_admin/data/models/selectionPopupModel/selection_popup_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_drop_down.dart';
import 'provider/emergency_provider.dart';

class RecycleBinScreen extends StatefulWidget {
  const RecycleBinScreen({super.key});

  @override
  RecycleBinScreenState createState() => RecycleBinScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecycleBinProvider(),
      child: const RecycleBinScreen(),
    );
  }
}

class RecycleBinScreenState extends State<RecycleBinScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<RecycleBinProvider>(context, listen: false);
      if (provider.recycleBin.dBDATA != null) {
        _tabController = TabController(
          length: 5, // Number of tabs for each deleted entity
          vsync: this,
        );
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecycleBinProvider>(
      builder: (context, provider, child) {
        if (_tabController == null && provider.recycleBin.dBDATA != null) {
          _tabController = TabController(
            length: 5,
            vsync: this,
          );
        }

        return SafeArea(
          child: Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     NavigatorService.pushNamed(AppRoutes.addOrgScreen);
            //   },
            //   backgroundColor: Colors.red,
            //   child: const Icon(Icons.add),
            // ),
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: _tabController != null
                ? Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SizedBox(
                            //   height: 50.v,
                            //   width: 200.v,
                            //   child: CustomDropDown(
                            //     icon: Container(
                            //       margin: EdgeInsets.only(left: 16.h),
                            //       child: CustomImageRestore(
                            //         imagePath:
                            //             ImageConstant.imgArrowdropdownfilled,
                            //         height: 20.h,
                            //         width: 24.h,
                            //       ),
                            //     ),
                            //     hintText: "Filter".tr,
                            //     hintStyle: theme.textTheme.bodyLarge!,
                            //     items: [
                            //       SelectionPopupModel(id: 0, title: 'All'),
                            //       SelectionPopupModel(
                            //           id: 1, title: 'Deleted Orgs'),
                            //       SelectionPopupModel(
                            //           id: 2, title: 'Deleted Users'),
                            //       SelectionPopupModel(
                            //           id: 3, title: 'Deleted Devices'),
                            //       SelectionPopupModel(
                            //           id: 4, title: 'Deleted Alerts'),
                            //       SelectionPopupModel(
                            //           id: 5, title: 'Deleted Invoices'),
                            //     ],
                            //     contentPadding: EdgeInsets.symmetric(
                            //       horizontal: 12.h,
                            //       vertical: 18.h,
                            //     ),
                            //     onChanged: (value) {
                            //       provider.onChanged(value.title);
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.h),
                      const Divider(),
                      TabBar(
                        indicatorWeight: 2,
                        indicatorColor: Colors.blue,
                        labelColor: Colors.black,
                        controller: _tabController,
                        tabs: const [
                          Tab(text: 'Organizations'),
                          Tab(text: 'Users'),
                          Tab(text: 'Devices'),
                          Tab(text: 'Alerts'),
                          Tab(text: 'Invoices'),
                        ],
                        onTap: (index) {
                          provider.setSelectedTab(index);
                        },
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildDeletedOrgsGrid(provider),
                            _buildDeletedUsersGrid(provider),
                            _buildDeletedDevicesGrid(provider),
                            _buildDeletedAlertsGrid(provider),
                            _buildDeletedInvoicesGrid(provider),
                          ],
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildDeletedOrgsGrid(RecycleBinProvider provider) {
    if (provider.recycleBin.dBDATA?.deletedOrgs?.isEmpty ?? true) {
      return _buildEmptyGridMessage('No deleted organizations available');
    }
    return SfDataGridTheme(
      data: SfDataGridThemeData(
          headerColor: appTheme.deepOrangeA100,
          gridLineColor: appTheme.pink300),
      child: SfDataGrid(
        source: DeletedOrgsDataSource(provider),
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        columns: <GridColumn>[
          GridColumn(columnName: 'id', label: const Center(child: Text('ID'))),
          GridColumn(
              columnName: 'name', label: const Center(child: Text('Name'))),
          GridColumn(
              columnName: 'email', label: const Center(child: Text('Email'))),
          GridColumn(
              columnName: 'phone', label: const Center(child: Text('Phone'))),
          GridColumn(
              columnName: 'status', label: const Center(child: Text('Status'))),
          GridColumn(
              columnName: 'actions',
              label: const Center(child: Text('Actions'))),
        ],
      ),
    );
  }

  Widget _buildDeletedUsersGrid(RecycleBinProvider provider) {
    if (provider.recycleBin.dBDATA?.deletedUsers?.isEmpty ?? true) {
      return _buildEmptyGridMessage('No deleted users available');
    }
    return SfDataGridTheme(
      data: SfDataGridThemeData(
          headerColor: appTheme.deepOrangeA100,
          gridLineColor: appTheme.pink300),
      child: SfDataGrid(
        source: DeletedUsersDataSource(provider),
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        columns: <GridColumn>[
          GridColumn(columnName: 'id', label: const Center(child: Text('ID'))),
          GridColumn(
              columnName: 'name', label: const Center(child: Text('Name'))),
          GridColumn(
              columnName: 'email', label: const Center(child: Text('Email'))),
          GridColumn(
              columnName: 'phone', label: const Center(child: Text('Phone'))),
          GridColumn(
              columnName: 'status', label: const Center(child: Text('Status'))),
          GridColumn(
              columnName: 'actions',
              label: const Center(child: Text('Actions'))),
        ],
      ),
    );
  }

  Widget _buildDeletedDevicesGrid(RecycleBinProvider provider) {
    if (provider.recycleBin.dBDATA?.deletedDevices?.isEmpty ?? true) {
      return _buildEmptyGridMessage('No deleted devices available');
    }
    return SfDataGridTheme(
      data: SfDataGridThemeData(
          headerColor: appTheme.deepOrangeA100,
          gridLineColor: appTheme.pink300),
      child: SfDataGrid(
        source: DeletedDevicesDataSource(provider),
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        columns: <GridColumn>[
          GridColumn(columnName: 'id', label: const Center(child: Text('ID'))),
          GridColumn(
              columnName: 'deviceName',
              label: const Center(child: Text('Device Name'))),
          GridColumn(
              columnName: 'serialNumber',
              label: const Center(child: Text('Serial Number'))),
          GridColumn(
              columnName: 'status', label: const Center(child: Text('Status'))),
          GridColumn(
              columnName: 'actions',
              label: const Center(child: Text('Actions'))),
        ],
      ),
    );
  }

  Widget _buildDeletedAlertsGrid(RecycleBinProvider provider) {
    if (provider.recycleBin.dBDATA?.deletedAlerts?.isEmpty ?? true) {
      return _buildEmptyGridMessage('No deleted alerts available');
    }
    return SfDataGridTheme(
      data: SfDataGridThemeData(
          headerColor: appTheme.deepOrangeA100,
          gridLineColor: appTheme.pink300),
      child: SfDataGrid(
        source: DeletedAlertsDataSource(provider),
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        columns: <GridColumn>[
          GridColumn(columnName: 'id', label: const Center(child: Text('ID'))),
          GridColumn(
              columnName: 'alertName',
              label: const Center(child: Text('Alert Name'))),
          GridColumn(
              columnName: 'description',
              label: const Center(child: Text('Description'))),
          GridColumn(
              columnName: 'status', label: const Center(child: Text('Status'))),
          GridColumn(
              columnName: 'actions',
              label: const Center(child: Text('Actions'))),
        ],
      ),
    );
  }

  Widget _buildDeletedInvoicesGrid(RecycleBinProvider provider) {
    if (provider.recycleBin.dBDATA?.deletedInvoices?.isEmpty ?? true) {
      return _buildEmptyGridMessage('No deleted invoices available');
    }
    return SfDataGridTheme(
      data: SfDataGridThemeData(
          headerColor: appTheme.deepOrangeA100,
          gridLineColor: appTheme.pink300),
      child: SfDataGrid(
        source: DeletedInvoicesDataSource(provider),
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        columns: <GridColumn>[
          GridColumn(columnName: 'id', label: const Center(child: Text('ID'))),
          GridColumn(
              columnName: 'invoiceNumber',
              label: const Center(child: Text('Invoice Number'))),
          GridColumn(
              columnName: 'amount', label: const Center(child: Text('Amount'))),
          GridColumn(
              columnName: 'status', label: const Center(child: Text('Status'))),
          GridColumn(
              columnName: 'actions',
              label: const Center(child: Text('Actions'))),
        ],
      ),
    );
  }

  Widget _buildEmptyGridMessage(String message) {
    return Center(
      child: Text(message),
    );
  }
}

class DeletedOrgsDataSource extends DataGridSource {
  DeletedOrgsDataSource(this.provider) {
    _deletedOrgs = provider.recycleBin.dBDATA?.deletedOrgs
            ?.map<DataGridRow>((org) {
          return DataGridRow(cells: [
            DataGridCell<String>(columnName: 'id', value: org.id.toString()),
            DataGridCell<String>(columnName: 'name', value: org.orgName),
            DataGridCell<String>(columnName: 'email', value: org.orgEmail),
            DataGridCell<String>(columnName: 'phone', value: org.orgPhone),
            DataGridCell<Widget>(
              columnName: 'status',
              value: Card(
                color: org.status == '1'
                    ? Colors.lightGreen
                    : Colors.red.withOpacity(.5),
                child: Center(
                  child: Text(org.status == '1' ? 'Active' : 'Inactive'),
                ),
              ),
            ),
            DataGridCell<Widget>(
              columnName: 'actions',
              value: PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'Restore') {
                    provider.restore(org.id.toString(), 'organizations');
                  } else if (value == 'Delete') {
                    provider.confirmDeleteOrg(org);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Restore', 'Delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ]);
        }).toList() ??
        [];
  }

  final RecycleBinProvider provider;
  List<DataGridRow> _deletedOrgs = [];

  @override
  List<DataGridRow> get rows => _deletedOrgs;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Center(child: Text(row.getCells()[0].value.toString())),
      Center(child: Text(row.getCells()[1].value.toString())),
      Center(child: Text(row.getCells()[2].value.toString())),
      Center(child: Text(row.getCells()[3].value.toString())),
      Center(child: row.getCells()[4].value),
      Center(child: row.getCells()[5].value),
    ]);
  }
}

class DeletedUsersDataSource extends DataGridSource {
  DeletedUsersDataSource(this.provider) {
    _deletedUsers = provider.recycleBin.dBDATA?.deletedUsers
            ?.map<DataGridRow>((org) {
          return DataGridRow(cells: [
            DataGridCell<String>(columnName: 'id', value: org.id.toString()),
            DataGridCell<String>(columnName: 'name', value: org.empName),
            DataGridCell<String>(columnName: 'email', value: org.empEmail),
            DataGridCell<String>(columnName: 'phone', value: org.empPhone),
            DataGridCell<Widget>(
              columnName: 'status',
              value: Card(
                color: org.status == '1'
                    ? Colors.lightGreen
                    : Colors.red.withOpacity(.5),
                child: Center(
                  child: Text(org.status == '1' ? 'Active' : 'Inactive'),
                ),
              ),
            ),
            DataGridCell<Widget>(
              columnName: 'actions',
              value: PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'Restore') {
                    provider.restore(org.id.toString(), 'users');
                  } else if (value == 'Delete') {
                    // provider.confirmDeleteUser(user);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Restore', 'Delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ]);
        }).toList() ??
        [];
  }

  final RecycleBinProvider provider;
  List<DataGridRow> _deletedUsers = [];

  @override
  List<DataGridRow> get rows => _deletedUsers;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Center(child: Text(row.getCells()[0].value.toString())),
      Center(child: Text(row.getCells()[1].value.toString())),
      Center(child: Text(row.getCells()[2].value.toString())),
      Center(child: Text(row.getCells()[3].value.toString())),
      Center(child: row.getCells()[4].value),
      Center(child: row.getCells()[5].value),
    ]);
  }
}

class DeletedDevicesDataSource extends DataGridSource {
  DeletedDevicesDataSource(this.provider) {
    _deletedDevices = provider.recycleBin.dBDATA?.deletedDevices
            ?.map<DataGridRow>((device) {
          return DataGridRow(cells: [
            DataGridCell<String>(columnName: 'id', value: device.id.toString()),
            DataGridCell<String>(
                columnName: 'deviceName', value: device.deviceName),
            DataGridCell<String>(
                columnName: 'serialNumber', value: device.mfrSerialNo),
            DataGridCell<Widget>(
              columnName: 'status',
              value: Card(
                color: device.status == '1'
                    ? Colors.lightGreen
                    : Colors.red.withOpacity(.5),
                child: Center(
                  child: Text(device.status == '1' ? 'Active' : 'Inactive'),
                ),
              ),
            ),
            DataGridCell<Widget>(
              columnName: 'actions',
              value: PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'Restore') {
                    provider.restore(device.id.toString(), 'devices');
                  } else if (value == 'Delete') {
                    // provider.confirmDeleteDevice(device);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Restore', 'Delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ]);
        }).toList() ??
        [];
  }

  final RecycleBinProvider provider;
  List<DataGridRow> _deletedDevices = [];

  @override
  List<DataGridRow> get rows => _deletedDevices;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Center(child: Text(row.getCells()[0].value.toString())),
      Center(child: Text(row.getCells()[1].value.toString())),
      Center(child: Text(row.getCells()[2].value.toString())),
      Center(child: row.getCells()[3].value),
      Center(child: row.getCells()[4].value),
    ]);
  }
}

class DeletedAlertsDataSource extends DataGridSource {
  DeletedAlertsDataSource(this.provider) {
    _deletedAlerts = provider.recycleBin.dBDATA?.deletedAlerts
            ?.map<DataGridRow>((alert) {
          return DataGridRow(cells: [
            DataGridCell<String>(columnName: 'id', value: alert.id.toString()),
            DataGridCell<String>(
                columnName: 'alertName', value: alert.alertName),
            DataGridCell<String>(
                columnName: 'description', value: alert.alertDescription),
            DataGridCell<Widget>(
              columnName: 'status',
              value: Card(
                color: alert.status == '1'
                    ? Colors.lightGreen
                    : Colors.red.withOpacity(.5),
                child: Center(
                  child: Text(alert.status == '1' ? 'Active' : 'Inactive'),
                ),
              ),
            ),
            DataGridCell<Widget>(
              columnName: 'actions',
              value: PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'Restore') {
                    provider.restore(alert.id.toString(), 'alerts');
                  } else if (value == 'Delete') {
                    // provider.confirmDeleteAlert(alert);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Restore', 'Delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ]);
        }).toList() ??
        [];
  }

  final RecycleBinProvider provider;
  List<DataGridRow> _deletedAlerts = [];

  @override
  List<DataGridRow> get rows => _deletedAlerts;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Center(child: Text(row.getCells()[0].value.toString())),
      Center(child: Text(row.getCells()[1].value.toString())),
      Center(child: Text(row.getCells()[2].value.toString())),
      Center(child: row.getCells()[3].value),
      Center(child: row.getCells()[4].value),
    ]);
  }
}

class DeletedInvoicesDataSource extends DataGridSource {
  DeletedInvoicesDataSource(this.provider) {
    _deletedInvoices = provider.recycleBin.dBDATA?.deletedInvoices
            ?.map<DataGridRow>((invoice) {
          return DataGridRow(cells: [
            DataGridCell<String>(
                columnName: 'id', value: invoice.id.toString()),
            DataGridCell<String>(
                columnName: 'invoiceNumber', value: invoice.id.toString()),
            DataGridCell<String>(
                columnName: 'amount', value: invoice.totalAmount.toString()),
            DataGridCell<Widget>(
              columnName: 'status',
              value: Card(
                color: invoice.status == '1'
                    ? Colors.lightGreen
                    : Colors.red.withOpacity(.5),
                child: Center(
                  child: Text(invoice.status == '1' ? 'Paid' : 'Unpaid'),
                ),
              ),
            ),
            DataGridCell<Widget>(
              columnName: 'actions',
              value: PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'Restore') {
                    provider.restore(invoice.id.toString(), 'invoices');
                  } else if (value == 'Delete') {
                    // provider.confirmDeleteInvoice(invoice);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Restore', 'Delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ]);
        }).toList() ??
        [];
  }

  final RecycleBinProvider provider;
  List<DataGridRow> _deletedInvoices = [];

  @override
  List<DataGridRow> get rows => _deletedInvoices;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Center(child: Text(row.getCells()[0].value.toString())),
      Center(child: Text(row.getCells()[1].value.toString())),
      Center(child: Text(row.getCells()[2].value.toString())),
      Center(child: row.getCells()[3].value),
      Center(child: row.getCells()[4].value),
    ]);
  }
}
