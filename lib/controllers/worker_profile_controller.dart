import 'package:flutter_coworkers/datasources/booking_datasource.dart';
import 'package:get/get.dart';

class WorkerProfileController extends GetxController {
  clear() {
    Get.delete<WorkerProfileController>(force: true);
  }

  // recruiter
  final _recruiterId = ''.obs;
  String get recruiterId => _recruiterId.value;
  set recruiterId(String n) => _recruiterId.value = n;

  checkHiredBy(String workerId) {
    BookingDatasource.checkHireBy(workerId).then((value) {
      value.fold((message) => recruiterId = 'Available', (booking) {
        recruiterId = booking.userId;
      });
    });
  }
}
