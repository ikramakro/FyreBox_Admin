import 'package:fyrebox_admin/data/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// import '../../data/models/loginDeviceAuth/post_login_device_auth_resp.dart'; // Import jsonEncode and jsonDecode

class PrefUtils {
  PrefUtils() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }
  static SharedPreferences? _sharedPreferences;
  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  Future<void> setAccessToken(String token) async {
    await _sharedPreferences!.setString('token', token);
  }

  String? getAccessToken() {
    String? token = _sharedPreferences!.getString('token');
    if (token != null) {
      return token;
    }
    return null;
  }

  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }

  Future<void> setBoolValue(String key, bool value) {
    return _sharedPreferences!.setBool(key, value);
  }

  bool getBoolValue(String key) {
    try {
      return _sharedPreferences!.getBool(key) ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<void> setOrgValue(String key, String value) {
    return _sharedPreferences!.setString(key, value);
  }

  String getOrgValue(String key) {
    try {
      return _sharedPreferences!.getString(key) ?? '';
    } catch (e) {
      return '';
    }
  }

  // Add methods to store and retrieve USERDATA
  Future<void> setUserData(DBDATA userData) async {
    String userDataJson = jsonEncode(userData.toJson());
    await _sharedPreferences!.setString('USER_DATA', userDataJson);
  }

  DBDATA? getUserData() {
    String? userDataJson = _sharedPreferences!.getString('USER_DATA');
    if (userDataJson != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userDataJson);
      return DBDATA.fromJson(userDataMap);
    }
    return null;
  }
}
