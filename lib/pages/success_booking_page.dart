import 'package:flutter_coworkers/widgets/secondary_button.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../config/app_format.dart';
import '../config/appwrite.dart';
import '../controllers/booking_controller.dart';
import '../controllers/success_booking_controller.dart';

class SuccessBookingPage extends StatefulWidget {
  const SuccessBookingPage({super.key});

  @override
  State<SuccessBookingPage> createState() => _SuccessBookingPageState();
}

class _SuccessBookingPageState extends State<SuccessBookingPage> {
  final successBookingController = Get.put(SuccessBookingController());
  final bookingController = Get.put(BookingController());
  @override
  void dispose() {
    successBookingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/blur_purple.png'),
          Image.asset('assets/images/blur_blue.png'),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'success_hiring'.tr,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                DView.height(10),
                Text(
                  'time_expand'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                ),
                DView.height(50),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 6),
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        Appwrite.imageURL(
                          bookingController.bookingDetail.worker!.image,
                        ),
                        width: 136,
                        height: 136,
                        fit: BoxFit.cover,
                      ),
                    ),
                    hiredText(),
                  ],
                ),
                DView.height(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bookingController.bookingDetail.worker!.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    DView.width(4),
                    Image.asset(
                      'assets/images/ic_verified.png',
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
                DView.height(8),
                rating(),
                DView.height(60),
                SizedBox(
                  width: 270,
                  child: FilledButton(
                    onPressed: () {
                      successBookingController.toWorkerProfile(
                        context,
                        bookingController.bookingDetail.workerId,
                        bookingController.bookingDetail.worker!.category,
                      );
                    },
                    child: Text('worker_profile'.tr),
                  ),
                ),
                DView.height(),
                SizedBox(
                  width: 270,
                  child: SecondaryButton(
                    onPressed: () {
                      successBookingController.toListWorker(
                        context,
                        bookingController.bookingDetail.worker!.category,
                      );
                    },
                    child: Text('hire_other_worker'.tr),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row rating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingBar.builder(
          initialRating: bookingController.bookingDetail.worker!.rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20,
          itemPadding: const EdgeInsets.all(0),
          itemBuilder: (context, _) =>
              const Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {},
          ignoreGestures: true,
        ),
        DView.width(8),
        Text(
          '(${AppFormat.number(bookingController.bookingDetail.worker!.ratingCount)})',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget hiredText() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Transform.translate(
          offset: const Offset(0, 6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xffBFA8FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'hired'.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
