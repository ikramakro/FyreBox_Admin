class UserDataModel {
  String? sTATUS;
  List<DBDATA>? dBDATA;
  String? errorDescription;
  UserDataModel({this.sTATUS, this.dBDATA, this.errorDescription});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    if (json['STATUS'] == 'SUCCESSFUL') {
      if (json['DB_DATA'] != null) {
        dBDATA = <DBDATA>[];
        json['DB_DATA'].forEach((v) {
          dBDATA!.add(new DBDATA.fromJson(v));
        });
      }
    } else {
      dBDATA = null;
      errorDescription = json['ERROR_DESCRIPTION'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['STATUS'] = sTATUS;
    if (dBDATA != null) {
      data['DB_DATA'] = dBDATA!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DBDATA {
  int? id;
  String? empName;
  int? empType;
  String? employeeType;
  String? empEmail;
  String? empPhone;
  String? empAddress;
  String? status;
  int? entryTime;
  String? entryTimeFormated;

  DBDATA(
      {this.id,
      this.empName,
      this.empType,
      this.employeeType,
      this.empEmail,
      this.empPhone,
      this.empAddress,
      this.status,
      this.entryTime,
      this.entryTimeFormated});

  DBDATA.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empName = json['emp_name'];
    empType = json['emp_type'];
    employeeType = json['employee_type'];
    empEmail = json['emp_email'];
    empPhone = json['emp_phone'];
    empAddress = json['emp_address'];
    status = json['status'];
    entryTime = json['entry_time'];
    entryTimeFormated = json['entry_time_formated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['emp_name'] = empName;
    data['emp_type'] = empType;
    data['employee_type'] = employeeType;
    data['emp_email'] = empEmail;
    data['emp_phone'] = empPhone;
    data['emp_address'] = empAddress;
    data['status'] = status;
    data['entry_time'] = entryTime;
    data['entry_time_formated'] = entryTimeFormated;
    return data;
  }
}
