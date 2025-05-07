class OrderDevice {
  String? sTATUS;
  List<DBDATA>? dBDATA;
  String? eRRORDESCRIPTION;
  OrderDevice({this.sTATUS, this.dBDATA, this.eRRORDESCRIPTION});

  OrderDevice.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    if (json['STATUS'] != 'ERROR') {
      if (json['DB_DATA'] != null) {
        dBDATA = <DBDATA>[];
        json['DB_DATA'].forEach((v) {
          dBDATA!.add(DBDATA.fromJson(v));
        });
      }
      eRRORDESCRIPTION = null;
    } else {
      eRRORDESCRIPTION = json['ERROR_DESCRIPTION'];
      dBDATA = null;
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
  int? orgId;
  int? deviceType;
  int? deviceQuantity;
  String? deviceDescription;
  String? status;
  int? entryTime;
  String? orgName;
  String? deviceTypeName;
  String? entryTimeFormated;

  DBDATA(
      {this.id,
      this.orgId,
      this.deviceType,
      this.deviceQuantity,
      this.deviceDescription,
      this.status,
      this.entryTime,
      this.orgName,
      this.deviceTypeName,
      this.entryTimeFormated});

  DBDATA.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orgId = json['org_id'];
    deviceType = json['device_type'];
    deviceQuantity = json['device_quantity'];
    deviceDescription = json['device_description'];
    status = json['status'];
    entryTime = json['entry_time'];
    orgName = json['org_name'];
    deviceTypeName = json['device_type_name'];
    entryTimeFormated = json['entry_time_formated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['org_id'] = orgId;
    data['device_type'] = deviceType;
    data['device_quantity'] = deviceQuantity;
    data['device_description'] = deviceDescription;
    data['status'] = status;
    data['entry_time'] = entryTime;
    data['org_name'] = orgName;
    data['device_type_name'] = deviceTypeName;
    data['entry_time_formated'] = entryTimeFormated;
    return data;
  }
}
