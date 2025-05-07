class InvoiceModel {
  String? sTATUS;
  List<DBDATA>? dBDATA;

  InvoiceModel({this.sTATUS, this.dBDATA});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    if (json['DB_DATA'] != null) {
      dBDATA = <DBDATA>[];
      json['DB_DATA'].forEach((v) {
        dBDATA!.add(new DBDATA.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS'] = this.sTATUS;
    if (this.dBDATA != null) {
      data['DB_DATA'] = this.dBDATA!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DBDATA {
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
  String? address;
  String? orgPhone;
  String? orgLogo;
  String? generationDateFormated;
  String? dueDateFormated;
  String? entryTimeFormated;
  int? employeeType;

  DBDATA(
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
      this.address,
      this.orgPhone,
      this.orgLogo,
      this.generationDateFormated,
      this.dueDateFormated,
      this.entryTimeFormated,
      this.employeeType});

  DBDATA.fromJson(Map<String, dynamic> json) {
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
    address = json['address'];
    orgPhone = json['org_phone'];
    orgLogo = json['org_logo'];
    generationDateFormated = json['generation_date_formated'];
    dueDateFormated = json['due_date_formated'];
    entryTimeFormated = json['entry_time_formated'];
    employeeType = json['employee_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['service_amount'] = this.serviceAmount;
    data['tax_amount'] = this.taxAmount;
    data['total_amount'] = this.totalAmount;
    data['paid_amount'] = this.paidAmount;
    data['paid_tax'] = this.paidTax;
    data['generation_date'] = this.generationDate;
    data['due_date'] = this.dueDate;
    data['status'] = this.status;
    data['entry_time'] = this.entryTime;
    data['org_name'] = this.orgName;
    data['address'] = this.address;
    data['org_phone'] = this.orgPhone;
    data['org_logo'] = this.orgLogo;
    data['generation_date_formated'] = this.generationDateFormated;
    data['due_date_formated'] = this.dueDateFormated;
    data['entry_time_formated'] = this.entryTimeFormated;
    data['employee_type'] = this.employeeType;
    return data;
  }
}
