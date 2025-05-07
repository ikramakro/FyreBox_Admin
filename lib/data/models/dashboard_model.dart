class DashboardModel {
  String? sTATUS;
  DBDATA? dBDATA;
  String? errorDescription;
  DashboardModel({this.sTATUS, this.dBDATA});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    if (json['STATUS'] != 'ERROR') {
      dBDATA =
          json['DB_DATA'] != null ? new DBDATA.fromJson(json['DB_DATA']) : null;
    } else {
      dBDATA = null;
      errorDescription = json['ERROR_DESCRIPTION'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS'] = this.sTATUS;
    if (this.dBDATA != null) {
      data['DB_DATA'] = this.dBDATA!.toJson();
    }
    return data;
  }
}

class DBDATA {
  int? totalOrgs;
  int? totalDevices;
  int? totalRevenue;
  int? totalDueInvoices;
  List<int>? thisMonthRevenue;
  int? thisMonthTotalSalesAmount;

  DBDATA(
      {this.totalOrgs,
      this.totalDevices,
      this.totalRevenue,
      this.totalDueInvoices,
      this.thisMonthRevenue,
      this.thisMonthTotalSalesAmount});

  DBDATA.fromJson(Map<String, dynamic> json) {
    totalOrgs = json['total_orgs'];
    totalDevices = json['total_devices'];
    totalRevenue = json['total_revenue'];
    totalDueInvoices = json['total_due_invoices'];
    thisMonthRevenue = json['this_month_revenue'].cast<int>();
    thisMonthTotalSalesAmount = json['this_month_total_sales_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_orgs'] = this.totalOrgs;
    data['total_devices'] = this.totalDevices;
    data['total_revenue'] = this.totalRevenue;
    data['total_due_invoices'] = this.totalDueInvoices;
    data['this_month_revenue'] = this.thisMonthRevenue;
    data['this_month_total_sales_amount'] = this.thisMonthTotalSalesAmount;
    return data;
  }
}
