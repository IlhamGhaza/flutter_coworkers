import 'package:flutter_coworkers/config/app_info.dart';
import 'package:flutter_coworkers/config/enums.dart';
import 'package:flutter_coworkers/data/datasources/booking_datasource.dart';
import 'package:flutter_coworkers/data/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  void clear() {
    Get.delete<CheckoutController>(force: true);
  }

  final List<Map<String, dynamic>> payments = [
    {
      'image': 'assets/images/ic_wallet_payment.png',
      'label': 'Wallet',
      'is_active': true,
    },
    {
      'image': 'assets/images/ic_master_card.png',
      'label': 'CC',
      'is_active': false
    },
    {
      'image': 'assets/images/ic_paypal.png',
      'label': 'PayPal',
      'is_active': false
    },
    {
      'image': 'assets/images/ic_other.png',
      'label': 'Other',
      'is_active': false
    },
  ];

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool n) => _loading.value = n;

  void execute(BuildContext context, BookingModel bookingDetail) {
    loading = true;
    BookingDatasource.checkout(bookingDetail).then((value) {
      loading = false;
      value.fold((message) => AppInfo.failed(context, message), (data) {
        Get.toNamed(AppRoute.successBooking.path);
      });
    });
  }
}
