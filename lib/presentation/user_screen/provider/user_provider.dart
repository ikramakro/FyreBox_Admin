import 'dart:async';
import 'package:fyrebox_admin/presentation/emergency_screen/models/actions_item_model.dart';

import '../../../core/app_export.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/shared_prf.dart';
import '../../../data/models/employee_type_model.dart';
// import '../../../data/models/loginDeviceAuth/post_login_device_auth_resp.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../../data/models/user_data_model.dart';
import '../../../data/repository/repository.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel userModelObj = UserModel();
  UserDataModel model = UserDataModel();
  final _repository = Repository();
  LocalStorageService sp = LocalStorageService();
  PrefUtils prefUtils = PrefUtils();
  EmployeeTypeModel emptype = EmployeeTypeModel();
  int selectedEmpTypeId = 0; // Track selected employee type
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isOrganizationOwner = false;
  String? selectedUserRole;
  bool hasFullAccess = false;
  bool hasInsertAccess = false;
  bool hasUpdateAccess = false;
  bool hasDeleteAccess = false;

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  UserProvider() {
    init();
  }

  init() async {
    await loadEmployeeData();
    await loadDashboardData();
  }

  List<SelectionPopupModel> employeeRole = [
    SelectionPopupModel(
      id: 1,
      title: "Fainance Manager",
    ),
    SelectionPopupModel(
      id: 2,
      title: "Sales Manager",
      isSelected: true,
    ),
    SelectionPopupModel(
      id: 3,
      title: "Distributer",
      isSelected: true,
    ),
  ];
  List<ActionsItemModel> actionsItemList =
      List.generate(2, (index) => ActionsItemModel());
  void onChanged(String value) {
    if (model.dBDATA != null && model.dBDATA!.isNotEmpty) {
      List<DBDATA> filteredData = [];

      if (value == 'Active') {
        filteredData =
            model.dBDATA!.where((user) => user.status == '1').toList();
      } else if (value == 'Inactive') {
        filteredData =
            model.dBDATA!.where((user) => user.status == '0').toList();
      } else {
        filteredData = model.dBDATA!; // Show all users if no filter is selected
      }

      // Update the model with the filtered data
      model.dBDATA = filteredData;
      notifyListeners(); // Notify the UI to update with the filtered data
    }
  }

  void setSelectedEmpType(int empTypeId) {
    selectedEmpTypeId = empTypeId;
    loadDashboardData(); // Reload data for the selected type
  }

  FutureOr<void> loadDashboardData() async {
    await _repository.userData(
      formData: {
        'operation': 'get_employees',
        'access_token': 'developer_bypass',
        'emp_type': selectedEmpTypeId.toString(), // Pass selected employee type
      },
    ).then((value) async {
      model = value;
      if (model.sTATUS != "ERROR") {
        notifyListeners();
      } else {
        showError(model.errorDescription ?? '');
      }
    });
  }

  FutureOr<void> loadEmployeeData() async {
    await _repository.employeetypeData(
      formData: {
        'operation': 'get_employee_types',
        'access_token': 'developer_bypass',
      },
    ).then((value) async {
      emptype = value;
      if (emptype.sTATUS != "ERROR") {
        if (emptype.dBDATA != null && emptype.dBDATA!.isNotEmpty) {
          selectedEmpTypeId =
              emptype.dBDATA!.first.id!; // Select first type by default
          await loadDashboardData();
        }
        notifyListeners();
      } else {
        showError('');
      }
    });
  }

  // FutureOr<void> addUser({
  //   Function? onSuccess,
  //   Function? onError,
  // }) async {
  //   await _repository.addUser(
  //     formData: {
  //       'operation': 'register_employee',
  //       'emp_name': userNameController.text,
  //       'emp_email': emailController.text,
  //       'user_password': passwordController.text,
  //       'employee_type': selectedEmpTypeId,
  //       'password': passwordController.text,
  //       'emp_phone': phoneController.text,
  //       'emp_address': addressController.text,
  //       'access_token': 'developer_bypass',
  //       'terms_and_condition': '1'
  //     },
  //   ).then((value) async {
  //     if (value.sTATUS != "ERROR") {
  //       showSuccess(value.dESCRIPTION ?? '');
  //       NavigatorService.popAndPushNamed(AppRoutes.rootScreen, arguments: 1);
  //       notifyListeners();
  //     } else {
  //       showError(value.eRRORDESCRIPTION ?? '');
  //     }
  //   });
  // }

  FutureOr<void> deleteUser({
    required String id,
    Function? onSuccess,
    Function? onError,
  }) async {
    await _repository.deleteUser(
      formData: {
        'operation': 'delete_employee',
        'emp_id': id,
        'access_token': 'developer_bypass',
      },
    ).then((value) async {
      if (value.sTATUS != "ERROR") {
        // Remove user from the local state
        model.dBDATA?.removeWhere((user) => user.id.toString() == id);
        notifyListeners(); // Update the UI
        if (onSuccess != null) {
          onSuccess();
        }
      } else {
        if (onError != null) {
          onError(value.eRRORDESCRIPTION ?? 'Failed to delete user');
        }
      }
    }).catchError((error) {
      if (onError != null) {
        onError('An error occurred while deleting the user');
      }
    });
  }

  FutureOr<void> addUser({
    Function? onSuccess,
    Function? onError,
  }) async {
    await _repository.addUser(
      formData: {
        'user_name': userNameController.text,
        'org_amdin': isOrganizationOwner ? '1' : '0',
        'user_email': emailController.text,
        'user_password': passwordController.text,
        'user_role_type': selectedUserRole == 'Admin' ? '1' : '2',
        'full_access': hasFullAccess ? '1' : '0',
        'insert_access': hasInsertAccess ? '1' : '0',
        'update_access': hasUpdateAccess ? '1' : '0',
        'delete_access': hasDeleteAccess ? '1' : '0',
        'operation': 'add_org_user',
        'access_token': 'developer_bypass',
      },
    ).then((value) async {
      if (value.sTATUS != "ERROR") {
        showSuccess(value.dESCRIPTION ?? '');
        NavigatorService.popAndPushNamed(AppRoutes.rootScreen, arguments: 1);
        notifyListeners();
      } else {
        showError(value.eRRORDESCRIPTION ?? '');
      }
    });
  }

  onSelected(dynamic value) {
    for (var element in userModelObj.dropdownItemList) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    notifyListeners();
  }

  void setOrganizationOwner(bool value) {
    isOrganizationOwner = value;
    notifyListeners();
  }

  void setUserRole(String role) {
    selectedUserRole = role;
    notifyListeners();
  }

  void setFullAccess(bool value) {
    hasFullAccess = value;
    notifyListeners();
  }

  void setInsertAccess(bool value) {
    hasInsertAccess = value;
    notifyListeners();
  }

  void setUpdateAccess(bool value) {
    hasUpdateAccess = value;
    notifyListeners();
  }

  void setDeleteAccess(bool value) {
    hasDeleteAccess = value;
    notifyListeners();
  }

  void onSelectedChipView(int index, bool value) {
    for (var element in userModelObj.actionsItemList) {
      element.isSelected = false;
    }
    userModelObj.actionsItemList[index].isSelected = value;
    notifyListeners();
  }
}


// import 'dart:async';
// import '../../../core/app_export.dart';
// import '../../../core/utils/constant.dart';
// import '../../../core/utils/shared_prf.dart';
// import '../../../data/models/employee_type_model.dart';
// import '../../../data/models/loginDeviceAuth/post_login_device_auth_resp.dart';
// import '../../../data/models/user_data_model.dart';
// import '../../../data/repository/repository.dart';
// import '../models/user_model.dart';

// class UserProvider extends ChangeNotifier {
//   UserModel userModelObj = UserModel();

//   UserDataModel model = UserDataModel();
//   final _repository = Repository();
//   LocalStorageService sp = LocalStorageService();
//   PrefUtils prefUtils = PrefUtils();
//   EmployeeTypeModel emptype=EmployeeTypeModel();
//   bool isOrganizationOwner = false;
//   String? selectedUserRole;
//   bool hasFullAccess = false;
//   bool hasInsertAccess = false;
//   bool hasUpdateAccess = false;
//   bool hasDeleteAccess = false;

//   final TextEditingController userNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   UserProvider() {
//     init();
//   }

//   init() async {
//         loadEmployeeData();
//     await loadDashboardData();

//   }

//   FutureOr<void> addUser({
//     Function? onSuccess,
//     Function? onError,
//   }) async {
//     USERDATA userdata = prefUtils.getUserData()!;

//     await _repository.addUser(
//       formData: {
//         'user_name': userNameController.text,
//         'org_id': userdata.orgId,
//         'org_amdin': isOrganizationOwner ? '1' : '0',
//         'user_email': emailController.text,
//         'user_password': passwordController.text,
//         'user_role_type': selectedUserRole == 'Admin' ? '1' : '2',
//         'full_access': hasFullAccess ? '1' : '0',
//         'insert_access': hasInsertAccess ? '1' : '0',
//         'update_access': hasUpdateAccess ? '1' : '0',
//         'delete_access': hasDeleteAccess ? '1' : '0',
//         'operation': 'add_org_user',
//         'access_token': 'developer_bypass',
//       },
//     ).then((value) async {
//       if (value.sTATUS != "ERROR") {
//         showSuccess(value.dESCRIPTION ?? '');
//         NavigatorService.popAndPushNamed(AppRoutes.rootScreen, arguments: 1);
//         notifyListeners();
//       } else {
//         showError(value.eRRORDESCRIPTION ?? '');
//       }
//     });
//   }

//   Future<void> deleteUser(String userId) async {
//     await _repository.addUser(
//       formData: {
//         'operation': 'delete_user_account',
//         'user_id': userId,
//         'access_token': 'developer_bypass',
//       },
//     ).then((value) {
//       if (value.sTATUS != "ERROR") {
//         // Remove the user from the list
//         model.dBDATA?.removeWhere((user) => user.id == userId);
//         notifyListeners();
//         showSuccess('User deleted successfully');
//       } else {
//         showError(value.eRRORDESCRIPTION ?? 'Failed to delete user');
//       }
//     }).catchError((error) {
//       showError('An error occurred while deleting the user');
//     });
//   }

//   FutureOr<void> loadDashboardData({
//     Function? onSuccess,
//     Function? onError,
//   }) async {
   

//     await _repository.userData(
//       formData: {
//         'operation': 'get_employees',
//         'access_token': 'developer_bypass',
        
//       },
//     ).then((value) async {
//       model = value;
//       if (model.sTATUS != "ERROR") {
//         notifyListeners();
//       } else {
//         showError(model.errorDescription ?? '');
//       }
//     });
//   }
// FutureOr<void> loadEmployeeData({
//     Function? onSuccess,
//     Function? onError,
//   }) async {
//     // USERDATA userdata = prefUtils.getUserData()!;

//     await _repository.employeetypeData(
//       formData: {
//         'operation': 'get_employee_types',
//         'access_token': 'developer_bypass',
       
//       },
//     ).then((value) async {
//       emptype = value;
//       if (model.sTATUS != "ERROR") {
//         notifyListeners();
//       } else {
//         showError( '');
//       }
//     });
//   }
//   onSelected(dynamic value) {
//     for (var element in userModelObj.dropdownItemList) {
//       element.isSelected = false;
//       if (element.id == value.id) {
//         element.isSelected = true;
//       }
//     }
//     notifyListeners();
//   }

//   void setOrganizationOwner(bool value) {
//     isOrganizationOwner = value;
//     notifyListeners();
//   }

//   void setUserRole(String role) {
//     selectedUserRole = role;
//     notifyListeners();
//   }

//   void setFullAccess(bool value) {
//     hasFullAccess = value;
//     notifyListeners();
//   }

//   void setInsertAccess(bool value) {
//     hasInsertAccess = value;
//     notifyListeners();
//   }

//   void setUpdateAccess(bool value) {
//     hasUpdateAccess = value;
//     notifyListeners();
//   }

//   void setDeleteAccess(bool value) {
//     hasDeleteAccess = value;
//     notifyListeners();
//   }

//   void onChanged(String value) async {
//     // For filtered data
//     String org = await prefUtils.getOrgValue('orgid');

//     if (value == 'Active') {
//       await _repository.userData(
//         formData: {
//           'operation': 'get_user_data',
//           'access_token': 'developer_bypass',
//           'org_id': org,
//           'status': '1'
//         },
//       ).then((value) async {
//         model = value;
//         if (model.sTATUS != "ERROR") {
//           notifyListeners();
//         } else {
//           showError(model.errorDescription ?? '');
//         }
//       });
//     } else if (value == 'In-Active') {
//       await _repository.userData(
//         formData: {
//           'operation': 'get_user_data',
//           'access_token': 'developer_bypass',
//           'org_id': org,
//           'status': '0'
//         },
//       ).then((value) async {
//         model = value;
//         if (model.sTATUS != "ERROR") {
//           notifyListeners();
//         } else {
//           showError(model.errorDescription ?? '');
//         }
//       });
//     } else {
//       await _repository.userData(
//         formData: {
//           'operation': 'get_user_data',
//           'access_token': 'developer_bypass',
//           'org_id': org,
//         },
//       ).then((value) async {
//         model = value;
//         if (model.sTATUS != "ERROR") {
//           notifyListeners();
//         } else {
//           showError(model.errorDescription ?? '');
//         }
//       });
//     }
//     notifyListeners();
//   }

//   void onSelectedChipView(int index, bool value) {
//     userModelObj.actionsItemList.forEach((element) {
//       element.isSelected = false;
//     });
//     userModelObj.actionsItemList[index].isSelected = value;
//     notifyListeners();
//   }
// }
