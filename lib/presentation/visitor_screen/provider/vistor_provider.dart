import 'dart:async';
import '../../../core/app_export.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/shared_prf.dart';
import '../../../data/models/orgization_model.dart';
import '../../../data/repository/repository.dart';

class OrganizationProvider extends ChangeNotifier {
  OrganizationsModel model = OrganizationsModel();
  final _repository = Repository();
  LocalStorageService sp = LocalStorageService();
  PrefUtils prefUtils = PrefUtils();

  OrganizationProvider() {
    init();
  }

  init() async {
    await loadOrganizationsData();
  }

  Future<void> loadOrganizationsData() async {
    await _repository.organizationData(
      formData: {
        'operation': 'get_organizations',
        'access_token': 'developer_bypass',
      },
    ).then((value) {
      model = value;
      if (model.sTATUS != "ERROR") {
        notifyListeners();
      } else {
        showError('Error fetching organizations');
      }
    });
  }

  Future<void> deleteOrganization(String orgId) async {
    await _repository.organizationData(
      formData: {
        'operation': 'delete_organization',
        'org_id': orgId,
        'access_token': 'developer_bypass',
      },
    ).then((value) {
      if (value.sTATUS != "ERROR") {
        model.dBDATA?.removeWhere((org) => org.id == orgId);
        notifyListeners();
        showSuccess('Organization deleted successfully');
      } else {
        showError('Failed to delete organization');
      }
    }).catchError((error) {
      showError('An error occurred while deleting the organization');
    });
  }

  Future<void> sendQuation(
      String orgId, String description, String subject) async {
    await _repository.organizationData(
      formData: {
        'operation': 'send_quotation',
        'org_id': orgId,
        'quotation_subject': 'subject',
        'quotation_body': description
      },
    ).then((value) {
      if (value.sTATUS != "ERROR") {
        notifyListeners();
        showSuccess('Successfully Send Quation to Organization');
      } else {
        showError('Failed to Send Quation  ');
      }
    }).catchError((error) {
      showError('An error occurred while Send Quation ');
    });
  }
}
