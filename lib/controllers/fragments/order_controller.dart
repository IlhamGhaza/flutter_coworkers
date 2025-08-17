import 'package:flutter_coworkers/config/app_info.dart';
// removed unused import 'package:flutter_coworkers/config/app_log.dart';
import 'package:flutter_coworkers/data/datasources/booking_datasource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/booking_model.dart';

class OrderController extends GetxController {
  void clear() {
    Get.delete<OrderController>(force: true);
  }

  final RxString _selected = 'In Progress'.obs;
  String get selected => _selected.value;
  set selected(String n) => _selected.value = n;

  final RxList<BookingModel> _inProgress = <BookingModel>[].obs;
  List<BookingModel> get inProgress => _inProgress;

  final RxList<BookingModel> _completed = <BookingModel>[].obs;
  List<BookingModel> get completed => _completed;

  final RxString _statusInProgress = ''.obs;
  String get statusInProgress => _statusInProgress.value;
  set statusInProgress(String n) => _statusInProgress.value = n;

  final RxString _statusCompleted = ''.obs;
  String get statusCompleted => _statusCompleted.value;
  set statusCompleted(String n) => _statusCompleted.value = n;

  void ini(String userId) {
    fetchInProgress(userId);
    fetchCompleted(userId);
  }

  void fetchInProgress(String userId) {
    statusInProgress = 'Loading';
    BookingDatasource.fetchOrder(userId, 'In Progress').then((value) {
      value.fold((message) => statusInProgress = message, (data) {
        statusInProgress = 'Success';
        _inProgress.value = data;
      });
    });
  }

  void fetchCompleted(String userId) {
    statusCompleted = 'Loading';
    BookingDatasource.fetchOrder(userId, 'Completed').then((value) {
      value.fold((message) => statusCompleted = message, (data) {
        statusCompleted = 'Success';
        _completed.value = data;
      });
    });
  }

  void setCompleted(
    BuildContext context,
    String bookingId,
    String workerId,
    String userId,
  ) {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Set Completed',
          style: TextStyle(color: Colors.black),
        ),
        content: const Text(
          'You sure want to set this worker has finished the job?',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Yes'),
          ),
        ],
      ),
    ).then((yes) {
      if (yes ?? false) {
        BookingDatasource.setCompleted(bookingId, workerId).then((value) {
          value.fold((message) => AppInfo.failed(context, message), (data) {
            AppInfo.toastSucces(context, 'Worker Complete the Job');
            ini(userId);
          });
        });
      }
    });
  }
}
