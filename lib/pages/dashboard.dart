import 'package:flutter_coworkers/controllers/dashboard_controller.dart';
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
    final width = MediaQuery.of(context).size.width;
    final useRail = width >= 600; // tablet and above
    final extendedRail = width >= 840; // wide screens show extended rail

    if (useRail) {
      return Obx(() {
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                backgroundColor: Theme.of(context).colorScheme.surface,
                selectedIndex: dashboardController.index,
                onDestinationSelected: (i) => dashboardController.index = i,
                extended: extendedRail,
                labelType: extendedRail
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.selected,
                indicatorColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.14),
                selectedIconTheme: IconThemeData(
                  color: Theme.of(context).colorScheme.primary,
                ),
                unselectedIconTheme: IconThemeData(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                selectedLabelTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
                destinations: dashboardController.menu.map((e) {
                  return NavigationRailDestination(
                    icon: ImageIcon(AssetImage(e['icon_off'])),
                    selectedIcon: ImageIcon(AssetImage(e['icon_on'])),
                    label: Text(e['label']),
                  );
                }).toList(),
              ),
              const VerticalDivider(width: 1),
              Expanded(child: dashboardController.currentFragment),
            ],
          ),
        );
      });
    }

    return Obx(() {
      return Scaffold(
        body: dashboardController.currentFragment,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          currentIndex: dashboardController.index,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            dashboardController.index = value;
          },
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor:
              Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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
        ),
      );
    });
  }
}
