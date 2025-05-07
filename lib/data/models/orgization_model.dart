class OrganizationsModel {
  String? sTATUS;
  List<DBDATA>? dBDATA;

  OrganizationsModel({this.sTATUS, this.dBDATA});

  OrganizationsModel.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    if (json['DB_DATA'] != null) {
      dBDATA = <DBDATA>[];
      json['DB_DATA'].forEach((v) {
        dBDATA!.add(DBDATA.fromJson(v));
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

class DBDATA {
  int? id;
  String? orgName;
  String? orgEmail;
  String? orgPhone;
  int? type;
  String? orgVat;
  String? orgLogo;
  String? orgEvacuationMap;
  String? address;
  int? addedBy;
  String? status;
  int? entryTime;
  String? orgTypeName;
  String? entryTimeFormated;

  DBDATA(
      {this.id,
      this.orgName,
      this.orgEmail,
      this.orgPhone,
      this.type,
      this.orgVat,
      this.orgLogo,
      this.orgEvacuationMap,
      this.address,
      this.addedBy,
      this.status,
      this.entryTime,
      this.orgTypeName,
      this.entryTimeFormated});

  DBDATA.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orgName = json['org_name'];
    orgEmail = json['org_email'];
    orgPhone = json['org_phone'];
    type = json['type'];
    orgVat = json['org_vat'];
    orgLogo = json['org_logo'];
    orgEvacuationMap = json['org_evacuation_map'];
    address = json['address'];
    addedBy = json['added_by'];
    status = json['status'];
    entryTime = json['entry_time'];
    orgTypeName = json['org_type_name'];
    entryTimeFormated = json['entry_time_formated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['org_name'] = orgName;
    data['org_email'] = orgEmail;
    data['org_phone'] = orgPhone;
    data['type'] = type;
    data['org_vat'] = orgVat;
    data['org_logo'] = orgLogo;
    data['org_evacuation_map'] = orgEvacuationMap;
    data['address'] = address;
    data['added_by'] = addedBy;
    data['status'] = status;
    data['entry_time'] = entryTime;
    data['org_type_name'] = orgTypeName;
    data['entry_time_formated'] = entryTimeFormated;
    return data;
  }
}
