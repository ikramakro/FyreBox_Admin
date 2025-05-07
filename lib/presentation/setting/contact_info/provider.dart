import 'package:flutter/material.dart';
import 'package:fyrebox_admin/data/repository/repository.dart';
import 'package:fyrebox_admin/core/utils/constant.dart';

class ProfileProvider extends ChangeNotifier {
  final _repository = Repository();

  // Form fields
  String? phoneNo;
  String? alternativePhone;
  String? website;
  String? url;

  // Additional form data
  String operation = 'contact_fyrebox';
  int contactPriority = 1; // Default priority: High
  String? contactSubject;
  String? contactDescription;

  // Setter methods
  void setPhoneNo(String value) {
    phoneNo = value;
    notifyListeners();
  }

  void setAlternativePhone(String value) {
    alternativePhone = value;
    notifyListeners();
  }

  void setWebsite(String value) {
    website = value;
    notifyListeners();
  }

  void setUrl(String value) {
    url = value;
    notifyListeners();
  }

  Future<void> submitContactInfo() async {
    try {
      final response = await _repository.updateUserPassword(
        formData: {
          'operation': operation,
          'contact_priority': contactPriority,
          'contact_subject': contactSubject,
          'contact_description': contactDescription,
          'phone_no': phoneNo,
          'alternative_phone': alternativePhone,
          'website': website,
          'url': url,
        },
      );

      if (response.sTATUS != "ERROR") {
        // Handle success
        showSuccess('Contact info submitted successfully');
      } else {
        // Handle error
        showError(response.eRRORDESCRIPTION ?? 'Failed to submit contact info');
      }
    } catch (error) {
      showError('An error occurred while submitting contact info');
    }
  }
}
