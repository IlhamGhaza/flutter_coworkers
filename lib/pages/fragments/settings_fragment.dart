import 'package:flutter_coworkers/config/enums.dart';
import 'package:flutter_coworkers/config/session.dart';
import 'package:flutter_coworkers/controllers/user_controller.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_color.dart';

class SettingsFragment extends StatefulWidget {
  const SettingsFragment({super.key});

  @override
  State<SettingsFragment> createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {
  final userController = Get.put(UserController());

  logout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign Out', style: TextStyle(color: Colors.black)),
          content: const Text(
            'You sure want to sign out?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    ).then((yes) {
      if (yes ?? false) {
        AppSession.removeUser();
        Navigator.pushReplacementNamed(context, AppRoute.signIn.name);
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
                    DView.spaceHeight(20),
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
                          style: const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
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
        DView.spaceHeight(),
        Center(
          child: Obx(
            () => Text(
              userController.data.name ?? '',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const Center(
          child: Text('Recruiter Account', style: TextStyle(fontSize: 16)),
        ),
        DView.spaceHeight(),
        itemSetting('assets/ic_edit.png', 'Edit Profile'),
        itemDivider(),
        itemSetting('assets/ic_invoice.png', 'Invoices'),
        itemDivider(),
        itemSetting('assets/ic_payment_setting.png', 'Payments'),
        itemDivider(),
        itemSetting('assets/ic_notification_setting.png', 'Notification'),
        itemDivider(),
        itemSetting('assets/ic_rate_app.png', 'Rate App'),
        itemDivider(),
        itemSetting('assets/ic_sign_out.png', 'Sign Out', onTap: logout),
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
      titleTextStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Column header() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'My Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text('Protect your account', style: TextStyle(color: Colors.black)),
      ],
    );
  }
}
