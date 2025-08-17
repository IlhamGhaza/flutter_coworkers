import 'package:flutter_coworkers/config/app_info.dart';
import 'package:flutter_coworkers/config/enums.dart';
import 'package:flutter_coworkers/data/datasources/user_datasource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  void clear() {
    Get.delete<SignUpController>(force: true);
  }

  final edtName = TextEditingController();
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool n) => _loading.value = n;

  void execute(BuildContext context) {
    if (edtName.text == '') {
      AppInfo.failed(context, 'Name wajib diisi');
      return;
    }

    if (edtEmail.text == '') {
      AppInfo.failed(context, 'Email wajib diisi');
      return;
    }

    if (!GetUtils.isEmail(edtEmail.text)) {
      AppInfo.failed(context, 'Email tidak valid');
      return;
    }

    if (edtPassword.text == '') {
      AppInfo.failed(context, 'Password wajib diisi');
      return;
    }

    if (edtPassword.text.length < 8) {
      AppInfo.failed(context, 'Password minimal 8 karakter');
      return;
    }

    loading = true;
    UserDatasource.signUp(edtName.text, edtEmail.text, edtPassword.text).then((
      value,
    ) {
      loading = false;
      value.fold(
        (message) {
          AppInfo.failed(context, message);
        },
        (data) {
          Get.offAllNamed(
            AppRoute.signIn.path,
            arguments: 'signup_success'.tr,
          );
        },
      );
    });
  }
}
