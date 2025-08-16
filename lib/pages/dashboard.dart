import 'package:flutter_coworkers/controllers/dashboard_controller.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final dashboardController = Get.put(DashboardController());

  @override
  void dispose() {
    dashboardController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => dashboardController.currentFragment),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: dashboardController.index,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            dashboardController.index = value;
          },
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            height: 2,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            height: 2,
          ),
          items: dashboardController.menu.map((e) {
            return BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(e['icon_off'])),
              activeIcon: ImageIcon(AssetImage(e['icon_on'])),
              label: e['label'],
            );
          }).toList(),
        );
      }),
    );
  }
}
