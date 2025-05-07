class RecycleBinModel {
  String? sTATUS;
  DBDATA? dBDATA;

  RecycleBinModel({this.sTATUS, this.dBDATA});

  RecycleBinModel.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    dBDATA = json['DB_DATA'] != null ? DBDATA.fromJson(json['DB_DATA']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['STATUS'] = sTATUS;
    if (dBDATA != null) {
      data['DB_DATA'] = dBDATA!.toJson();
    }
    return data;
  }
}

class DBDATA {
  List<DeletedOrgs>? deletedOrgs;
  List<DeletedUsers>? deletedUsers;
  List<DeletedDevices>? deletedDevices;
  List<DeletedAlerts>? deletedAlerts;
  List<DeletedInvoices>? deletedInvoices;

  DBDATA(
      {this.deletedOrgs,
      this.deletedUsers,
      this.deletedDevices,
      this.deletedAlerts,
      this.deletedInvoices});

  DBDATA.fromJson(Map<String, dynamic> json) {
    if (json['deleted_orgs'] != null && json['deleted_orgs'] is List) {
      deletedOrgs = <DeletedOrgs>[];
      json['deleted_orgs'].forEach((v) {
        deletedOrgs!.add(DeletedOrgs.fromJson(v));
      });
    }
    if (json['deleted_users'] != null && json['deleted_users'] is List) {
      deletedUsers = <DeletedUsers>[];
      json['deleted_users'].forEach((v) {
        deletedUsers!.add(DeletedUsers.fromJson(v));
      });
    }
    // deletedUsers = json['deleted_users'];
    if (json['deleted_devices'] != null && json['deleted_devices'] is List) {
      deletedDevices = <DeletedDevices>[];
      json['deleted_devices'].forEach((v) {
        deletedDevices!.add(DeletedDevices.fromJson(v));
      });
    }
    if (json['deleted_alerts'] != null && json['deleted_alerts'] is List) {
      deletedAlerts = <DeletedAlerts>[];
      json['deleted_alerts'].forEach((v) {
        deletedAlerts!.add(DeletedAlerts.fromJson(v));
      });
    }
    if (json['deleted_invoices'] != null && json['deleted_invoices'] is List) {
      deletedInvoices = <DeletedInvoices>[];
      json['deleted_invoices'].forEach((v) {
        deletedInvoices!.add(DeletedInvoices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deletedOrgs != null) {
      data['deleted_orgs'] = deletedOrgs!.map((v) => v.toJson()).toList();
    }
    data['deleted_users'] = deletedUsers;
    if (deletedDevices != null) {
      data['deleted_devices'] = deletedDevices!.map((v) => v.toJson()).toList();
    }
    if (deletedAlerts != null) {
      data['deleted_alerts'] = deletedAlerts!.map((v) => v.toJson()).toList();
    }
    if (deletedInvoices != null) {
      data['deleted_invoices'] =
          deletedInvoices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeletedUsers {
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

  DeletedUsers({
    this.id,
    this.empName,
    this.empType,
    this.employeeType,
    this.empEmail,
    this.empPhone,
    this.empAddress,
    this.status,
    this.entryTime,
    this.entryTimeFormated,
  });

  DeletedUsers.fromJson(Map<String, dynamic> json) {
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

class DeletedOrgs {
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

  DeletedOrgs(
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
      this.orgTypeName});

  DeletedOrgs.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class DeletedDevices {
  int? id;
  int? orgId;
  String? deviceKey;
  int? deviceType;
  String? deviceName;
  String? deviceCiteName;
  String? deviceLocation;
  String? mfrName;
  String? mfrContact;
  String? mfrEmail;
  int? mfrDate;
  String? mfrSerialNo;
  String? status;
  int? entryTime;
  String? deviceTypeName;
  String? orgName;

  DeletedDevices(
      {this.id,
      this.orgId,
      this.deviceKey,
      this.deviceType,
      this.deviceName,
      this.deviceCiteName,
      this.deviceLocation,
      this.mfrName,
      this.mfrContact,
      this.mfrEmail,
      this.mfrDate,
      this.mfrSerialNo,
      this.status,
      this.entryTime,
      this.deviceTypeName,
      this.orgName});

  DeletedDevices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orgId = json['org_id'];
    deviceKey = json['device_key'];
    deviceType = json['device_type'];
    deviceName = json['device_name'];
    deviceCiteName = json['device_cite_name'];
    deviceLocation = json['device_location'];
    mfrName = json['mfr_name'];
    mfrContact = json['mfr_contact'];
    mfrEmail = json['mfr_email'];
    mfrDate = json['mfr_date'];
    mfrSerialNo = json['mfr_serial_no'];
    status = json['status'];
    entryTime = json['entry_time'];
    deviceTypeName = json['device_type_name'];
    orgName = json['org_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['org_id'] = orgId;
    data['device_key'] = deviceKey;
    data['device_type'] = deviceType;
    data['device_name'] = deviceName;
    data['device_cite_name'] = deviceCiteName;
    data['device_location'] = deviceLocation;
    data['mfr_name'] = mfrName;
    data['mfr_contact'] = mfrContact;
    data['mfr_email'] = mfrEmail;
    data['mfr_date'] = mfrDate;
    data['mfr_serial_no'] = mfrSerialNo;
    data['status'] = status;
    data['entry_time'] = entryTime;
    data['device_type_name'] = deviceTypeName;
    data['org_name'] = orgName;
    return data;
  }
}

class DeletedAlerts {
  int? id;
  int? deviceId;
  int? alertType;
  String? status;
  int? entryTime;
  String? alertName;
  String? alertColor;
  String? alertDescription;
  String? deviceKey;
  String? orgName;

  DeletedAlerts(
      {this.id,
      this.deviceId,
      this.alertType,
      this.status,
      this.entryTime,
      this.alertName,
      this.alertColor,
      this.alertDescription,
      this.deviceKey,
      this.orgName});

  DeletedAlerts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['device_id'];
    alertType = json['alert_type'];
    status = json['status'];
    entryTime = json['entry_time'];
    alertName = json['alert_name'];
    alertColor = json['alert_color'];
    alertDescription = json['alert_description'];
    deviceKey = json['device_key'];
    orgName = json['org_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['device_id'] = deviceId;
    data['alert_type'] = alertType;
    data['status'] = status;
    data['entry_time'] = entryTime;
    data['alert_name'] = alertName;
    data['alert_color'] = alertColor;
    data['alert_description'] = alertDescription;
    data['device_key'] = deviceKey;
    data['org_name'] = orgName;
    return data;
  }
}

class DeletedInvoices {
  int? id;
  int? customerId;
  int? serviceAmount;
  int? taxAmount;
  int? totalAmount;
  int? paidAmount;
  int? paidTax;
  int? generationDate;
  int? dueDate;
  String? status;
  int? entryTime;
  String? orgName;
  String? orgLogo;

  DeletedInvoices(
      {this.id,
      this.customerId,
      this.serviceAmount,
      this.taxAmount,
      this.totalAmount,
      this.paidAmount,
      this.paidTax,
      this.generationDate,
      this.dueDate,
      this.status,
      this.entryTime,
      this.orgName,
      this.orgLogo});

  DeletedInvoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    serviceAmount = json['service_amount'];
    taxAmount = json['tax_amount'];
    totalAmount = json['total_amount'];
    paidAmount = json['paid_amount'];
    paidTax = json['paid_tax'];
    generationDate = json['generation_date'];
    dueDate = json['due_date'];
    status = json['status'];
    entryTime = json['entry_time'];
    orgName = json['org_name'];
    orgLogo = json['org_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['service_amount'] = serviceAmount;
    data['tax_amount'] = taxAmount;
    data['total_amount'] = totalAmount;
    data['paid_amount'] = paidAmount;
    data['paid_tax'] = paidTax;
    data['generation_date'] = generationDate;
    data['due_date'] = dueDate;
    data['status'] = status;
    data['entry_time'] = entryTime;
    data['org_name'] = orgName;
    data['org_logo'] = orgLogo;
    return data;
  }
}
