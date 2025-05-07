class EmployeeTypeModel {
  String? sTATUS;
  List<DBDATA1>? dBDATA;

  EmployeeTypeModel({this.sTATUS, this.dBDATA});

  EmployeeTypeModel.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    if (json['DB_DATA'] != null) {
      dBDATA = <DBDATA1>[];
      json['DB_DATA'].forEach((v) {
        dBDATA!.add(DBDATA1.fromJson(v));
      });
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

class DBDATA1 {
  int? id;
  String? empType;
  String? status;
  int? entryTime;

  DBDATA1({this.id, this.empType, this.status, this.entryTime});

  DBDATA1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empType = json['emp_type'];
    status = json['status'];
    entryTime = json['entry_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['emp_type'] = empType;
    data['status'] = status;
    data['entry_time'] = entryTime;
    return data;
  }
}
