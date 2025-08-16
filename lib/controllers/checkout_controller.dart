import 'package:flutter_coworkers/config/app_info.dart';
import 'package:flutter_coworkers/config/enums.dart';
import 'package:flutter_coworkers/datasources/booking_datasource.dart';
import 'package:flutter_coworkers/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  clear() {
    Get.delete<CheckoutController>(force: true);
  }

  final List<Map<String, dynamic>> payments = [
    {
      'image': 'assets/ic_wallet_payment.png',
      'label': 'Wallet',
      'is_active': true,
    },
    {'image': 'assets/ic_master_card.png', 'label': 'CC', 'is_active': false},
    {'image': 'assets/ic_paypal.png', 'label': 'PayPal', 'is_active': false},
    {'image': 'assets/ic_other.png', 'label': 'Other', 'is_active': false},
  ];

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool n) => _loading.value = n;

  execute(BuildContext context, BookingModel bookingDetail) {
    loading = true;
    BookingDatasource.checkout(bookingDetail).then((value) {
      loading = false;
      value.fold((message) => AppInfo.failed(context, message), (data) {
        Navigator.pushNamed(context, AppRoute.successBooking.name);
      });
    });
  }
}
