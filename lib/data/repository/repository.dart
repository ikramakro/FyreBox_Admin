import 'dart:convert';

import 'package:fyrebox_admin/core/utils/pref_utils.dart';
import 'package:fyrebox_admin/data/models/orderdevice.dart';
import 'package:fyrebox_admin/data/models/usermodel.dart';

import '../../core/utils/constant.dart';
import '../apiClient/api_client.dart';

import '../models/alert_model.dart';
import '../models/base_model.dart';
import '../models/dashboard_model.dart';
import '../models/device_model.dart';
import '../models/employee_type_model.dart';
import '../models/invoice_model.dart';
import '../models/loginDeviceAuth/post_login_device_auth_resp.dart';
import '../models/org_detail.dart';
import '../models/orgization_model.dart';
import '../models/recycle_bin_model.dart';
import '../models/register_model.dart';
import '../models/user_data_model.dart';
import '../models/vistors_model.dart';

/// Repository class for managing API requests.
/// This class provides a simplified interface for making the
/// API request using the [ApiClient] instance
class Repository {
  final _apiClient = ApiClient();
  Future<PostLoginDeviceAuthResp> login(
      {Map<String, dynamic>? formData}) async {
    final response = await _apiClient.post(
        baseUrl: 'https://fyreboxhub.com/admin/api/get_data.php',
        formdata: formData);
    print('============>>>>>>>>>>    ${response.data["JWT"]}');
    PrefUtils().setAccessToken(response.data["JWT"]);
    return PostLoginDeviceAuthResp.fromJson(response.data);
  }

  Future<UserModel> login1({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.post(
        baseUrl: 'https://fyreboxhub.com/admin/api/get_data.php',
        formdata: formData);

    // Convert the response data from a string to a JSON object
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    print('============>>>>>>>>>>    ${jsonResponse["JWT"]}');
    PrefUtils().setAccessToken(jsonResponse["JWT"]);
    // Use the JSON object to create a UserModel
    return UserModel.fromJson(jsonResponse);
  }

  Future<DashboardModel> dashboardData({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.post1(
        baseUrl: 'https://fyreboxhub.com/admin/api/get_data.php',
        formdata: formData,
        contantType: "application/x-www-form-urlencoded");
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return DashboardModel.fromJson(jsonResponse);
  }

  Future<InvoiceModel> invoiceData({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.post1(
        baseUrl: 'https://fyreboxhub.com/admin/api/get_data.php',
        formdata: formData,
        contantType: "application/x-www-form-urlencoded");
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return InvoiceModel.fromJson(jsonResponse);
  }

  Future<OrganizationsModel> organizationData(
      {Map<String, dynamic>? formData}) async {
    final response = await _apiClient.post1(
        baseUrl: 'https://fyreboxhub.com/admin/api/get_data.php',
        formdata: formData,
        contantType: "application/x-www-form-urlencoded");
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return OrganizationsModel.fromJson(jsonResponse);
  }

  Future<RecycleBinModel> getRecycleBinData(
      {Map<String, dynamic>? formData}) async {
    final response = await _apiClient.get(
      baseUrl: 'https://fyreboxhub.com/admin/api/get_data.php',
      formData: formData,
    );

    print('====>>>  ${response.data}');
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return RecycleBinModel.fromJson(jsonResponse);
  }

  Future<RegisterModel> register({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.post1(
        baseUrl: 'https://fyreboxhub.com/admin/api/set_data.php',
        formdata: formData,
        contantType: "application/x-www-form-urlencoded");
    return RegisterModel.fromJson(response.data);
  }

  Future<UserDataModel> userData({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.get(
        baseUrl: 'https://fyreboxhub.com/admin/api/get_data.php',
        formData: formData);
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return UserDataModel.fromJson(jsonResponse);
  }

  Future<EmployeeTypeModel> employeetypeData(
      {Map<String, dynamic>? formData}) async {
    final response = await _apiClient.get(
        baseUrl: 'https://fyreboxhub.com/admin/api/get_data.php',
        formData: formData);

    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return EmployeeTypeModel.fromJson(jsonResponse);
  }

  Future<AlertResponse> alertData({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.post(
        baseUrl: 'https://fyreboxhub.com/admin/api/get_data.php',
        formdata: formData);
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return AlertResponse.fromJson(jsonResponse);
  }

  Future<BaseModel> addUser({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.post1(
        baseUrl: 'https://fyreboxhub.com/admin/api/set_data.php',
        formdata: formData,
        contantType: "application/x-www-form-urlencoded");
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return BaseModel.fromJson(jsonResponse);
  }

  Future<BaseModel> deleteUser({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.post1(
        baseUrl: 'https://fyreboxhub.com/admin/api/set_data.php',
        formdata: formData,
        contantType: "application/x-www-form-urlencoded");
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return BaseModel.fromJson(jsonResponse);
  }

  Future<BaseModel> updateUserDetails({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.post1(
        baseUrl: 'https://fyreboxhub.com/admin/api/set_data.php',
        formdata: formData,
        contantType: "application/x-www-form-urlencoded");
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return BaseModel.fromJson(jsonResponse);
  }

  Future<BaseModel> updateUserPassword({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.post1(
        baseUrl: 'https://fyreboxhub.com/admin/api/set_data.php',
        formdata: formData,
        contantType: "application/x-www-form-urlencoded");
    print('=====>>>${response.data}');
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return BaseModel.fromJson(jsonResponse);
  }

  Future<BaseModel> contactFyreBox({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.post1(
        baseUrl: 'https://fyreboxhub.com/admin/api/set_data.php',
        formdata: formData,
        contantType: "application/x-www-form-urlencoded");
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return BaseModel.fromJson(jsonResponse);
  }

  Future<BaseModel> addDevice({dynamic formData}) async {
    final response = await _apiClient.post1(
        baseUrl: 'https://fyreboxhub.com/api/set_data.php',
        formdata: formData,
        contantType: "multipart/form-data");
    return BaseModel.fromJson(response.data);
  }

  Future<BaseModel> orderDevice({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.post1(
        baseUrl: 'https://fyreboxhub.com/admin/api/set_data.php',
        formdata: formData,
        contantType: "application/x-www-form-urlencoded");
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return BaseModel.fromJson(jsonResponse);
  }

  Future<OrderDevice> getorderDevice({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.get(
      baseUrl: 'https://fyreboxhub.com/admin/api/get_data.php',
      formData: formData,
    );
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return OrderDevice.fromJson(jsonResponse);
  }

  Future<DeviceResponse> deviceData({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.get(
        baseUrl: 'https://fyreboxhub.com/admin/api/get_data.php',
        formData: formData);
    final Map<String, dynamic> jsonResponse = json.decode(response.data);
    return DeviceResponse.fromJson(jsonResponse);
  }

  Future<VistorResponse> vistorData({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.get(
        baseUrl: 'https://fyreboxhub.com/admin/api/get_data.php.php',
        formData: formData);
    return VistorResponse.fromJson(response.data);
  }

  Future<Organization> orgData({Map<String, dynamic>? formData}) async {
    final response = await _apiClient.get(
        baseUrl: 'https://fyreboxhub.com/api/get_org_details',
        formData: formData);
    evacuationMaps =
        Organization.fromJson(response.data).dbData?.evacuationMaps ?? [];
    helplines = Organization.fromJson(response.data).dbData?.helplines ?? [];
    dbData = Organization.fromJson(response.data).dbData;
    return Organization.fromJson(response.data);
  }
}
// https://fyreboxhub.com/admin/api/get_data.php.php?operation=get_visitor&org_id=1