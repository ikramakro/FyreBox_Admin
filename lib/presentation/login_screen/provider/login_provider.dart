import 'dart:async';
import 'package:fyrebox_admin/core/utils/constant.dart';
import 'package:fyrebox_admin/data/models/usermodel.dart';
import '../../../core/app_export.dart';
// import '../../../data/models/loginDeviceAuth/post_login_device_auth_resp.dart';
import '../../../data/repository/repository.dart';
// import '../models/login_model.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // LoginModel loginModelObj = LoginModel();
  bool isShowPassword = true;
  final _repository = Repository();
  var postLoginDeviceAuthResp = UserModel();

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }

  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  FutureOr<void> callLoginDeviceAuth({
    Function? onSuccess,
    Function? onError,
  }) async {
    await _repository.login1(
      formData: {
        'access_token': 'developer_bypass',
        'operation': 'admin_login_form',
        'admin_email': userNameController.text,
        'admin_password': passwordController.text,
        'remember_me': '0'
      },
    ).then((value) async {
      postLoginDeviceAuthResp = value;
      if (postLoginDeviceAuthResp.sTATUS != "ERROR") {
        PrefUtils prefUtils = PrefUtils();
        // sp.saveToDisk('orgid', postLoginDeviceAuthResp.uSERDATA?.orgId ?? '');
        await prefUtils.setUserData(postLoginDeviceAuthResp.dBDATA ?? DBDATA());
        await prefUtils.setBoolValue('isLogin', true);

        onSuccess!.call();
        notifyListeners();
      } else {
        showError(postLoginDeviceAuthResp.errorDescription ?? '');
        // notifyListeners();
      }
    });
  }
}
