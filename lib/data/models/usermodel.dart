class UserModel {
  String? sTATUS;
  DBDATA? dBDATA;
  String? dESCRIPTION;
  String? errorDescription;

  UserModel(
      {this.sTATUS, this.dBDATA, this.dESCRIPTION, this.errorDescription});

  UserModel.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    if (json['STATUS'] == 'SUCCESSFUL') {
      dBDATA =
          json['DB_DATA'] != null ? new DBDATA.fromJson(json['DB_DATA']) : null;
      dESCRIPTION = json['DESCRIPTION'];
    } else {
      dBDATA = null;
      dESCRIPTION = null;
      errorDescription = json['ERROR_DESCRIPTION'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['STATUS'] = sTATUS;
    if (dBDATA != null) {
      data['DB_DATA'] = dBDATA!.toJson();
    }
    data['DESCRIPTION'] = dESCRIPTION;
    return data;
  }
}

class DBDATA {
  String? accountType;
  int? adminId;
  String? adminFirstName;
  String? adminLastName;
  String? adminFullName;
  String? adminEmail;
  String? adminDp;
  String? adminOccupation;
  String? adminDescription;
  int? adminEntryTime;

  DBDATA(
      {this.accountType,
      this.adminId,
      this.adminFirstName,
      this.adminLastName,
      this.adminFullName,
      this.adminEmail,
      this.adminDp,
      this.adminOccupation,
      this.adminDescription,
      this.adminEntryTime});

  DBDATA.fromJson(Map<String, dynamic> json) {
    accountType = json['account_type'];
    adminId = json['admin_id'];
    adminFirstName = json['admin_first_name'];
    adminLastName = json['admin_last_name'];
    adminFullName = json['admin_full_name'];
    adminEmail = json['admin_email'];
    adminDp = json['admin_dp'];
    adminOccupation = json['admin_occupation'];
    adminDescription = json['admin_description'];
    adminEntryTime = json['admin_entry_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_type'] = accountType;
    data['admin_id'] = adminId;
    data['admin_first_name'] = adminFirstName;
    data['admin_last_name'] = adminLastName;
    data['admin_full_name'] = adminFullName;
    data['admin_email'] = adminEmail;
    data['admin_dp'] = adminDp;
    data['admin_occupation'] = adminOccupation;
    data['admin_description'] = adminDescription;
    data['admin_entry_time'] = adminEntryTime;
    return data;
  }
}
