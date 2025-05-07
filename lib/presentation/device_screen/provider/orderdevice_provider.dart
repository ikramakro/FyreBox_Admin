import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fyrebox_admin/core/utils/constant.dart';
import '../../../core/app_export.dart';
import '../../../data/models/orderdevice.dart';
import '../../../data/repository/repository.dart';

class OrderDeviceProvider extends ChangeNotifier {
  OrderDevice data = OrderDevice();
  final _repository = Repository();

  OrderDeviceProvider() {
    orderDevice();
  }

  FutureOr<void> orderDevice() async {
    await _repository.getorderDevice(
      formData: {
        'operation': 'get_device_orders',
        'access_token': 'developer_bypass',
      },
    ).then((value) async {
      if (value.sTATUS != "ERROR") {
        data = value;
        notifyListeners();
      } else {
        showError(value.eRRORDESCRIPTION ?? '');
      }
    });
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      final response = await _repository.deleteUser(
        formData: {
          'operation': 'delete_order',
          'order_id': orderId,
          'access_token': 'developer_bypass',
        },
      );

      if (response.sTATUS != "ERROR") {
        data.dBDATA?.removeWhere((order) => order.id.toString() == orderId);
        notifyListeners();
      } else {
        // Handle error (e.g., show error message)
        debugPrint(response.eRRORDESCRIPTION ?? 'Error deleting order');
      }
    } catch (e) {
      debugPrint('An error occurred while deleting the order: $e');
    }
  }
}
