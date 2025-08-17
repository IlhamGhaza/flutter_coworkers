import 'package:flutter_coworkers/config/enums.dart';
import 'package:flutter_coworkers/controllers/list_worker_controller.dart';
import 'package:flutter_coworkers/controllers/worker_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessBookingController extends GetxController {
  void clear() {
    Get.delete<SuccessBookingController>(force: true);
  }

  void toWorkerProfile(BuildContext context, String workerId, String category) {
    final workerProfileController = Get.put(WorkerProfileController());
    workerProfileController.checkHiredBy(workerId);
    final listWorkerController = Get.put(ListWorkerController());
    listWorkerController.fetchAvailable(category);
    Get.until((route) => route.settings.name == AppRoute.workerProfile.path);
  }

  void toListWorker(BuildContext context, String category) {
    final listWorkerController = Get.put(ListWorkerController());
    listWorkerController.fetchAvailable(category);
    Get.until((route) => route.settings.name == AppRoute.listWorker.path);
  }
}
