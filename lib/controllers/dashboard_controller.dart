import 'package:flutter_coworkers/pages/fragments/browse_fragment.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../pages/fragments/order_fragment.dart';
import '../pages/fragments/settings_fragment.dart';
import '../pages/fragments/wallet_fragment.dart';

class DashboardController extends GetxController {
  void clear() {
    Get.delete<DashboardController>(force: true);
  }

  final RxInt _index = 0.obs;
  int get index => _index.value;
  set index(int n) => _index.value = n;

  Widget get currentFragment => menu[index]['fragment'];

  List<Map<String, dynamic>> menu = [
    {
      'icon_off': 'assets/images/ic_browse_grey.png',
      'icon_on': 'assets/images/ic_browse_purple.png',
      'label': 'Browse',
      'fragment': const BrowseFragment(),
    },
    {
      'icon_off': 'assets/images/ic_orders_grey.png',
      'icon_on': 'assets/images/ic_orders_purple.png',
      'label': 'Orders',
      'fragment': const OrderFragment(),
    },
    {
      'icon_off': 'assets/images/ic_wallet_grey.png',
      'icon_on': 'assets/images/ic_wallet_payment.png',
      'label': 'Wallet',
      'fragment': const WalletFragment(),
    },
    {
      'icon_off': 'assets/images/ic_settings_grey.png',
      'icon_on': 'assets/images/ic_settings_purple.png',
      'label': 'Settings',
      'fragment': const SettingsFragment(),
    },
  ];
}
