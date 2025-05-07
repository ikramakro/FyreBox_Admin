import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/constant.dart';
import '../../../data/models/orgization_model.dart';
import '../../../data/repository/repository.dart';

class AddOrganizationProvider extends ChangeNotifier {
  OrganizationsModel model = OrganizationsModel();
  final _repository = Repository();

  // Other methods remain as they are...

  // Converts FormData to Map<String, dynamic>

  // Converts FormData to Map<String, dynamic>
  Future<Map<String, dynamic>> _formDataToMap(FormData formData) async {
    final Map<String, dynamic> dataMap = {};

    // Loop through each entry in FormData fields
    for (var entry in formData.fields) {
      dataMap[entry.key] = entry.value;
    }

    // Include files as MultipartFile objects in the map
    for (var fileEntry in formData.files) {
      dataMap[fileEntry.key] =
          fileEntry.value; // Keep the file as MultipartFile
    }

    return dataMap;
  }

  Future<void> addOrganization({
    required String name,
    required String email,
    required String phone,
    required String type,
    String? vat,
    XFile? logo,
    XFile? evacuationMap,
    required String address,
    required int status,
  }) async {
    try {
      // Create FormData with text and file data
      final formData = FormData.fromMap({
        'operation': 'add_organization',
        'org_name': name,
        'org_email': email,
        'org_phone': phone,
        'org_type': type,
        'org_vat': vat,
        'org_address': address,
        'org_status': status.toString(),
        // Add files as MultipartFile for binary data

        // : await MultipartFile.fromFile(
        //   evacuationMap.readAsBytes(),
        // ),
      });
      Map<String, dynamic> data = {
        if (logo != null)
          'org_logo': logo != null ? Image.file(File(logo.path)) : "(binary)",
        //    await MultipartFile.fromFile(
        // logo.path,

        if (evacuationMap != null)
          'org_evacuation_map': evacuationMap != null
              ? Image.file(File(evacuationMap.path))
              : "(binary)",
      };
      // Convert FormData to Map<String, dynamic> for simpler processing
      final dataMap = await _formDataToMap(formData);
      dataMap.addAll(data);
      final response = await _repository.addDevice(formData: dataMap);

      if (response.sTATUS != "ERROR") {
        notifyListeners();
        showSuccess('Organization added successfully');
      } else {
        showError('Failed to add organization');
      }
    } catch (error) {
      showError('An error occurred: $error');
    }
  }
}
