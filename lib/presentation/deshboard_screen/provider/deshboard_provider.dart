import 'dart:async';
import 'package:flutter/material.dart';

import '../../../data/models/dashboard_model.dart';
import '../../../data/models/invoice_model.dart';
import '../../../data/repository/repository.dart';

class DeshboardProvider extends ChangeNotifier {
  DashboardModel deshboardModel = DashboardModel();
  InvoiceModel invoiceModel = InvoiceModel();
  final _repository = Repository();

  DeshboardProvider() {
    init();
  }

  Future<void> init() async {
    await loadDashboardData();
    await loadInvoiceData();
  }

  Future<void> loadDashboardData() async {
    try {
      final response = await _repository.dashboardData(
        formData: {
          'operation': 'get_dashboard_data',
          'access_token': 'developer_bypass',
        },
      );
      deshboardModel = response;
      notifyListeners();
    } catch (error) {
      // Handle errors if needed
    }
  }

  Future<void> loadInvoiceData() async {
    try {
      final response = await _repository.invoiceData(
        formData: {
          'operation': 'get_invoices',
          'access_token': 'developer_bypass',
        },
      );
      invoiceModel = response;
      notifyListeners();
    } catch (error) {
      // Handle errors if needed
    }
  }

  void deleteInvoice(int id) {
    invoiceModel.dBDATA?.removeWhere((invoice) => invoice.id == id);
    notifyListeners(); // This will rebuild the UI
  }
}
