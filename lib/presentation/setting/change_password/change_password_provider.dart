// import 'package:flutter/material.dart';
// import 'package:fyrebox_admin/data/models/usermodel.dart';
// import '../../../core/utils/constant.dart';
// import '../../../data/repository/repository.dart';
// import '../../../core/utils/pref_utils.dart';
// // import '../../../data/models/loginDeviceAuth/post_login_device_auth_resp.dart';

// class ChangePasswordProvider extends ChangeNotifier {
//   final TextEditingController oldPasswordController = TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController retypePasswordController =
//       TextEditingController();
//   final _repository = Repository();
//   PrefUtils prefUtils = PrefUtils();
//   DBDATA? userdata;

//   ChangePasswordProvider() {
//     init();
//   }

//   void init() async {
//     userdata = prefUtils.getUserData();
//   }

//   Future<void> changePassword() async {
//     if (newPasswordController.text != retypePasswordController.text) {
//       showError('New password and re-type password do not match');
//       return;
//     }

//     try {
//       final response = await _repository.updateUserPassword(
//         formData: {
//           'old_password': oldPasswordController.text,
//           'user_id': userdata?.adminId ?? '',
//           'new_password': newPasswordController.text,
//           're_password': retypePasswordController.text,
//           'operation': 'update_user_password',
//           'access_token': 'developer_bypass',
//         },
//       );

//       if (response.sTATUS != "ERROR") {
//         // Handle success
//         showSuccess('Password changed successfully');
//         notifyListeners();
//       } else {
//         // Handle error
//         showError(response.eRRORDESCRIPTION ?? 'Failed to change password');
//       }
//     } catch (error) {
//       showError('An error occurred while changing the password');
//     }
//   }
// }
import 'package:flutter/material.dart';
import '../../../core/utils/constant.dart';
import '../../../data/repository/repository.dart';
import '../../../core/utils/pref_utils.dart';

import 'package:fyrebox_admin/data/models/usermodel.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  final _repository = Repository();
  PrefUtils prefUtils = PrefUtils();
  DBDATA? userdata;
  bool isOldPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isRetypePasswordVisible = false;
  ChangePasswordProvider() {
    init();
  }

  void init() async {
    userdata = prefUtils.getUserData();
  }

  void toggleOldPasswordVisibility() {
    isOldPasswordVisible = !isOldPasswordVisible;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible = !isNewPasswordVisible;
    notifyListeners();
  }

  void toggleRetypePasswordVisibility() {
    isRetypePasswordVisible = !isRetypePasswordVisible;
    notifyListeners();
  }

  Future<void> changePassword() async {
    if (newPasswordController.text != retypePasswordController.text) {
      showError('New password and re-type password do not match');
      return;
    }
    Future<void> changePassword() async {
      if (newPasswordController.text != retypePasswordController.text) {
        showError('New password and re-type password do not match');
        return;
      }

      try {
        final response = await _repository.updateUserPassword(
          formData: {
            'old_password': oldPasswordController.text,
            'admin_id': userdata?.adminId ?? '',
            'new_password': newPasswordController.text,
            're_password': retypePasswordController.text,
            'operation': 'update_user_password',
            'access_token': 'developer_bypass',
          },
        );

        if (response.sTATUS != "ERROR") {
          // Handle success
          showSuccess('Password changed successfully');
          notifyListeners();
        } else {
          // Handle error
          showError(response.eRRORDESCRIPTION ?? 'Failed to change password');
        }
      } catch (error) {
        showError('An error occurred while changing the password');
      }
    }
  }
}
