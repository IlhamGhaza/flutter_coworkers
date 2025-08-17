import 'package:flutter_coworkers/widgets/input_auth.dart';
import 'package:flutter_coworkers/widgets/input_auth_password.dart';
import 'package:flutter_coworkers/widgets/secondary_button.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_coworkers/config/app_info.dart';

import '../config/enums.dart';
import '../controllers/sign_in_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final signInController = Get.put(SignInController());

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is String && args.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        AppInfo.success(context, args.tr);
      });
    }
  }

  @override
  void dispose() {
    signInController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/signin_background.png',
                  fit: BoxFit.fitWidth,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/applogo.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  child: Transform.translate(
                    offset: const Offset(0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'sign_in'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        DView.height(8),
                        Text("manage_worker".tr,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          DView.height(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                InputAuth(
                  editingController: signInController.edtEmail,
                  title: 'email_address'.tr,
                  hint: 'write_email'.tr,
                ),
                DView.height(),
                InputAuthPassword(
                  editingController: signInController.edtPassword,
                  title: 'password'.tr,
                  hint: 'write_password'.tr,
                ),
                DView.height(30),
                Obx(() {
                  bool loading = signInController.loading;
                  if (loading) return DView.loadingCircle();
                  return FilledButton(
                    onPressed: () {
                      signInController.execute(context);
                    },
                    style: FilledButton.styleFrom(),
                    child: Text(
                      'sign_in_explore'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }),
                DView.height(),
                SecondaryButton(
                  onPressed: () {
                    Get.toNamed(AppRoute.signUp.path);
                  },
                  child: Text('create_new_account'.tr),
                ),
              ],
            ),
          ),
          DView.height(30),
        ],
      ),
    );
  }
}
