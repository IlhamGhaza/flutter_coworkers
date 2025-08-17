import 'package:flutter_coworkers/config/enums.dart';
import 'package:flutter_coworkers/config/session.dart';
import 'package:flutter_coworkers/controllers/user_controller.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_coworkers/config/appwrite.dart';

import '../../config/app_color.dart';
import '../../controllers/fragments/settings_controller.dart';

class SettingsFragment extends StatefulWidget {
  const SettingsFragment({super.key});

  @override
  State<SettingsFragment> createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {
  final userController = Get.put(UserController());
  final settingsController = Get.put(SettingsController());

  void logout() {
    Get.dialog(
      AlertDialog(
        title: Text('sign_out'.tr),
        content: Text('sign_out_confirm'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('no'.tr),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text('yes'.tr),
          ),
        ],
      ),
    ).then((yes) async {
      if (yes ?? false) {
        try {
          await Appwrite.account.deleteSession(sessionId: 'current');
        } catch (e) {
          // Ignore errors from remote session deletion; still clear local session
        }
        await AppSession.removeUser();
        Get.offAllNamed(AppRoute.signIn.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        SizedBox(
          height: 172 + 120,
          child: Stack(
            children: [
              Container(
                height: 172,
                decoration: const BoxDecoration(
                  color: AppColor.bgHeader,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(80),
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 24),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    header(),
                    DView.height(20),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 6),
                        shape: BoxShape.circle,
                        color: const Color(0xffBFA8FF),
                      ),
                      alignment: Alignment.center,
                      child: Obx(() {
                        String initialName = userController.data.name == null
                            ? ""
                            : userController.data.name!.substring(0, 1);
                        return Text(
                          initialName,
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        DView.height(),
        Center(
          child: Obx(
            () => Text(
              userController.data.name ?? '',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
        Center(
          child: Text('recruiter_account'.tr,
              style: const TextStyle(fontSize: 16)),
        ),
        DView.height(),
        itemSetting('assets/images/ic_edit.png', 'Edit Profile'),
        itemDivider(),
        itemSetting('assets/images/ic_invoice.png', 'Invoices'),
        itemDivider(),
        itemSetting('assets/images/ic_payment_setting.png', 'Payments'),
        itemDivider(),
        itemSetting(
          'assets/images/ic_notification_setting.png',
          'notifications'.tr,
          onTap: () => Get.toNamed(AppRoute.notifications.path),
        ),
        itemDivider(),
        itemSetting(
          'assets/images/ic_settings_grey.png',
          'theme'.tr,
          onTap: _showThemeSheet,
        ),
        itemDivider(),
        itemSetting(
          'assets/images/ic_settings_grey.png',
          'language'.tr,
          onTap: _showLanguageSheet,
        ),
        itemDivider(),
        itemSetting('assets/images/ic_rate_app.png', 'Rate App'),
        itemDivider(),
        itemSetting('assets/images/ic_sign_out.png', 'sign_out'.tr,
            onTap: logout),
      ],
    );
  }

  Widget itemDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 20,
      endIndent: 20,
      color: Color(0xffEAEAEA),
    );
  }

  Widget itemSetting(String icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      onTap: onTap,
      leading: ImageIcon(AssetImage(icon)),
      title: Text(title),
      titleTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
    );
  }

  Column header() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 4),
        Text(
          'my_settings'.tr,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text('protect_account'.tr,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            )),
      ],
    );
  }

  void _showThemeSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Obx(() {
          final current = settingsController.themeMode;
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('system'.tr),
                  trailing: current == ThemeMode.system
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () {
                    settingsController.applyTheme(ThemeMode.system);
                    Get.back();
                  },
                ),
                ListTile(
                  title: Text('light'.tr),
                  trailing: current == ThemeMode.light
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () {
                    settingsController.applyTheme(ThemeMode.light);
                    Get.back();
                  },
                ),
                ListTile(
                  title: Text('dark'.tr),
                  trailing: current == ThemeMode.dark
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () {
                    settingsController.applyTheme(ThemeMode.dark);
                    Get.back();
                  },
                ),
                DView.height(),
              ],
            ),
          );
        });
      },
    );
  }

  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Obx(() {
          final current = settingsController.languageCode;
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('system'.tr),
                  trailing:
                      current == 'system' ? const Icon(Icons.check) : null,
                  onTap: () {
                    settingsController.applyLanguage('system');
                    Get.back();
                  },
                ),
                ListTile(
                  title: Text('english'.tr),
                  trailing: current == 'en_US' ? const Icon(Icons.check) : null,
                  onTap: () {
                    settingsController.applyLanguage('en_US');
                    Get.back();
                  },
                ),
                ListTile(
                  title: Text('indonesian'.tr),
                  trailing: current == 'id_ID' ? const Icon(Icons.check) : null,
                  onTap: () {
                    settingsController.applyLanguage('id_ID');
                    Get.back();
                  },
                ),
                DView.height(),
              ],
            ),
          );
        });
      },
    );
  }
}
