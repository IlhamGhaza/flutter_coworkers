import 'package:flutter_coworkers/models/booking_model.dart';
import 'package:flutter_coworkers/models/worker_model.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  clear() {
    Get.delete<BookingController>(force: true);
  }

  final hourDuartion = [5, 10, 15, 25, 40, 100];

  final _duration = 10.obs;
  int get duration => _duration.value;
  setDuration(int n, double hourRate) {
    _duration.value = n;
    BookingModel newBookingModel = bookingDetail
      ..hiringDuration = n
      ..subtotal = n * hourRate;
    _bookingDetail.value = newBookingModel;
    update();
  }

  final _bookingDetail = BookingModel(
    userId: '',
    workerId: '',
    date: DateTime.now(),
    hiringDuration: 0,
    subtotal: 0,
    insurance: 0,
    tax: 0,
    platformFee: 0,
    grandTotal: 0,
    payWith: '',
    status: 'In Progress',
    $id: '',
    $createdAt: '',
    $updatedAt: '',
  ).obs;
  BookingModel get bookingDetail => _bookingDetail.value;

  iniBookingDetail(String userId, WorkerModel worker) {
    _bookingDetail.value = BookingModel(
      userId: userId,
      workerId: worker.$id,
      date: DateTime.now(),
      hiringDuration: duration,
      subtotal: duration * worker.hourRate,
      insurance: 599,
      tax: 934,
      platformFee: 344,
      grandTotal: 2323,
      payWith: 'Wallet',
      status: 'In Progress',
      $id: '',
      $createdAt: '',
      $updatedAt: '',
      worker: worker,
    );
  }
}
