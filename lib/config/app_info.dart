import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';

class AppInfo {
  static toastSucces(String message) {
    DInfo.toastSuccess(message);
  }

  static success(BuildContext context, String message) {
    // DInfo.snackBarSuccess(context, message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static failed(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xffE65556),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
