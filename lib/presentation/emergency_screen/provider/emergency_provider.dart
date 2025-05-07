import 'dart:async';
import '../../../core/app_export.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/shared_prf.dart';
import '../../../data/models/recycle_bin_model.dart';
import '../../../data/repository/repository.dart';

class RecycleBinProvider extends ChangeNotifier {
  RecycleBinModel recycleBin = RecycleBinModel();
  final _repository = Repository();
  LocalStorageService sp = LocalStorageService();
  PrefUtils prefUtils = PrefUtils();
  int selectedTabIndex = 0;

  RecycleBinProvider() {
    init();
  }

  init() async {
    await loadRecycleBinData();
  }

  void setSelectedTab(int index) {
    selectedTabIndex = index;
    notifyListeners(); // Update the UI to reflect the selected tab
  }

  FutureOr<void> loadRecycleBinData() async {
    await _repository.getRecycleBinData(
      formData: {
        'operation': 'get_recycle_bin',
        'access_token': 'developer_bypass',
      },
    ).then((value) async {
      recycleBin = value;
      if (recycleBin.sTATUS != "ERROR") {
        notifyListeners();
      } else {
        showError(recycleBin.sTATUS ?? '');
      }
    });
  }

  void onChanged(String value) {
    // Filtering logic can be added here
    notifyListeners();
  }

  void viewOrgDetails(DeletedOrgs org) {
    // Implement logic to view organization details
  }
  Future<void> restore(String id, String table) async {
    // USERDATA userdata = prefUtils.getUserData()!;

    await _repository.orderDevice(
      formData: {
        'operation': 'restore_data',
        'access_token': 'developer_bypass',
        'id': id,
        'table': table
      },
    ).then((value) async {
      if (value.sTATUS != "ERROR") {
        showSuccess(value.dESCRIPTION ?? '');
        await loadRecycleBinData();
      } else {
        showError(value.eRRORDESCRIPTION ?? 'Error updating alert status.');
      }
    });
  }

  void confirmDeleteOrg(DeletedOrgs org) {
    // Implement logic to confirm deletion of organization
    // showDeleteConfirmationDialog(org);
  }

  // void showDeleteConfirmationDialog(DeletedOrgs org) {
  //   // Show confirmation dialog
  //   showDialog(
  //     context: navigatorKey.currentContext!,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Delete Organization'),
  //         content:
  //             const Text('Are you sure you want to delete this organization?'),
  //         actions: <Widget>[
  //           TextButton(
  //               child: const Text('Cancel'),
  //               onPressed: () => Navigator.of(context).pop()),
  //           TextButton(
  //             child: const Text('Delete'),
  //             onPressed: () async {
  //               await deleteOrg(org.id.toString());
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Future<void> deleteOrg(String orgId) async {
  //   await _repository.deleteOrg(
  //     formData: {
  //       'operation': 'delete_organization',
  //       'org_id': orgId,
  //       'access_token': 'developer_bypass',
  //     },
  //   ).then((value) {
  //     if (value.sTATUS != "ERROR") {
  //       // Remove the organization from the list
  //       recycleBin.dBDATA?.deletedOrgs
  //           ?.removeWhere((org) => org.id == int.parse(orgId));
  //       notifyListeners();
  //       showSuccess('Organization deleted successfully');
  //     } else {
  //       showError(value.sTATUS ?? 'Failed to delete organization');
  //     }
  //   }).catchError((error) {
  //     showError('An error occurred while deleting the organization');
  //   });
  // }
}
