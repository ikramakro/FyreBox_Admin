import 'package:fyrebox_admin/data/models/user_data_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_drop_down.dart';
import 'models/user_model.dart';
import 'provider/user_provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  UserScreenState createState() => UserScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const UserScreen(),
    );
  }
}

class UserScreenState extends State<UserScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<UserProvider>(context, listen: false);
      if (provider.emptype.dBDATA != null &&
          provider.emptype.dBDATA!.isNotEmpty) {
        _tabController = TabController(
          length: provider.emptype.dBDATA!.length,
          vsync: this,
        );
        setState(() {}); // Update the UI after initializing the TabController
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
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        if (_tabController == null && provider.emptype.dBDATA != null) {
          _tabController = TabController(
            length: provider.emptype.dBDATA!.length,
            vsync: this,
          );
        }

        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                NavigatorService.pushNamed(AppRoutes.addOrgScreen);
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.add),
            ),
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: _tabController != null
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50.v,
                              width: 200.v,
                              child: Selector<UserProvider, UserModel?>(
                                selector: (context, provider) =>
                                    provider.userModelObj,
                                builder: (context, userModelObj, child) {
                                  return CustomDropDown(
                                    icon: Container(
                                      margin: EdgeInsets.only(left: 16.h),
                                      child: CustomImageView(
                                        imagePath: ImageConstant
                                            .imgArrowdropdownfilled,
                                        height: 20.h,
                                        width: 24.h,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      provider.onChanged(value.title);
                                    },
                                    hintText: "Filter".tr,
                                    hintStyle: theme.textTheme.bodyLarge!,
                                    items: userModelObj?.dropdownItemList ?? [],
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.h,
                                      vertical: 18.h,
                                    ),
                                  );
                                },
                              ),
                            ),
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
                        tabs: provider.emptype.dBDATA!.map((empType) {
                          return Tab(text: empType.empType);
                        }).toList(),
                        onTap: (index) {
                          provider.setSelectedEmpType(
                              provider.emptype.dBDATA![index].id!);
                        },
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: provider.emptype.dBDATA!.map((empType) {
                            return _buildEmployeeDataGrid(provider);
                          }).toList(),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child:
                        CircularProgressIndicator()), // Show a loading indicator if TabController is not initialized
          ),
        );
      },
    );
  }

  Widget _buildEmployeeDataGrid(UserProvider provider) {
    if (provider.model.dBDATA == null) {
      return Center(
          child: Text(provider.model.errorDescription ?? 'No data available'));
    }

    return SfDataGridTheme(
      data: SfDataGridThemeData(
          headerColor: appTheme.deepOrangeA100,
          gridLineColor: appTheme.pink300),
      child: SfDataGrid(
        source: UserDataSource(
          users: provider.model.dBDATA ?? [],
          onDelete: (user) =>
              _showDeleteConfirmationDialog(context, user, provider),
          onView: (user) => _showUserDetailsBottomSheet(context, user),
        ),
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        columns: <GridColumn>[
          GridColumn(columnName: 'id', label: const Center(child: Text('ID'))),
          GridColumn(
              columnName: 'name',
              label: const Center(child: Text('Employee Name'))),
          GridColumn(
              columnName: 'email', label: const Center(child: Text('Email'))),
          GridColumn(
              columnName: 'phone', label: const Center(child: Text('Phone'))),
          GridColumn(
              columnName: 'address',
              label: const Center(child: Text('Address'))),
          GridColumn(
              columnName: 'regDate',
              label: const Center(child: Text('Reg. Date'))),
          GridColumn(
              columnName: 'status', label: const Center(child: Text('Status'))),
          GridColumn(
              columnName: 'actions',
              label: const Center(child: Text('Actions'))),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, DBDATA user, UserProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop()),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                provider.deleteUser(
                  id: user.id.toString(),
                  onSuccess: () {
                    // Dismiss the dialog after successful deletion
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('User deleted successfully'),
                      ),
                    );
                  },
                  onError: (errorMessage) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showUserDetailsBottomSheet(BuildContext context, DBDATA user) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
              const Text(
                'User Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              _buildUserDetailRow('Name', user.empName ?? ''),
              _buildUserDetailRow('Email', user.empEmail ?? ''),
              _buildUserDetailRow('Phone', user.empPhone ?? ''),
              _buildUserDetailRow('Address', user.empAddress ?? ''),
              _buildUserDetailRow('Reg. Date', user.entryTimeFormated ?? ''),
              _buildUserDetailRow(
                  'Status', user.status == '1' ? 'Active' : 'Inactive'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserDataSource extends DataGridSource {
  UserDataSource({
    required List<DBDATA> users,
    required this.onDelete,
    required this.onView,
  }) {
    _users = users.map<DataGridRow>((user) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'id', value: user.id.toString()),
        DataGridCell<String>(columnName: 'name', value: user.empName),
        DataGridCell<String>(columnName: 'email', value: user.empEmail),
        DataGridCell<String>(columnName: 'phone', value: user.empPhone),
        DataGridCell<String>(columnName: 'address', value: user.empAddress),
        DataGridCell<String>(
            columnName: 'regDate', value: user.entryTimeFormated),
        DataGridCell<Widget>(
          columnName: 'status',
          value: Card(
            color: user.status == '1'
                ? Colors.lightGreen
                : Colors.red.withOpacity(.5),
            child: Center(
              child: Text(user.status == '1' ? 'Active' : 'Inactive'),
            ),
          ),
        ),
        DataGridCell<Widget>(
          columnName: 'actions',
          value: PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'View') {
                onView(user);
              } else if (value == 'Delete') {
                onDelete(user);
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
          ),
        ),
      ]);
    }).toList();
  }

  List<DataGridRow> _users = [];
  final Function(DBDATA) onDelete;
  final Function(DBDATA) onView;

  @override
  List<DataGridRow> get rows => _users;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Center(child: Text(row.getCells()[0].value.toString())),
      Center(child: Text(row.getCells()[1].value.toString())),
      Center(child: Text(row.getCells()[2].value.toString())),
      Center(child: Text(row.getCells()[3].value.toString())),
      Center(child: Text(row.getCells()[4].value.toString())),
      Center(child: Text(row.getCells()[5].value.toString())),
      Center(child: row.getCells()[6].value),
      Center(
          child:
              row.getCells()[7].value), // Ensure there are exactly 8 cells here
    ]);
  }
}
