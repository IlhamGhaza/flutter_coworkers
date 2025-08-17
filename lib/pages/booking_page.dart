import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../config/enums.dart';
import '../controllers/booking_controller.dart';
import '../controllers/user_controller.dart';
import '../widgets/header_worker_left.dart';
import '../widgets/section_title.dart';

import '../config/app_color.dart';
import '../config/app_format.dart';
import '../config/appwrite.dart';
import '../data/models/worker_model.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.worker});
  final WorkerModel worker;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final bookingController = Get.put(BookingController());
  final userController = Get.put(UserController());

  @override
  void initState() {
    bookingController.iniBookingDetail(userController.data.$id!, widget.worker);
    super.initState();
  }

  @override
  void dispose() {
    bookingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 172,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColor.bgHeader,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeaderWorkerLeft(
                        title: 'booking_worker'.tr,
                        subtitle: 'grow_business'.tr,
                        iconLeft: 'assets/images/ic_back.png',
                        functionLeft: () {
                          Get.back();
                        },
                      ),
                      worker(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DView.height(90),
          selectDuration(),
          DView.height(30),
          whenYouNeed(),
          DView.height(30),
          details(),
          DView.height(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FilledButton(
              onPressed: () {
                Get.toNamed(AppRoute.checkout.path);
              },
              child: Text('proceed_checkout'.tr),
            ),
          ),
          DView.height(20),
        ],
      ),
    );
  }

  Widget details() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(text: 'details'.tr),
          Obx(() {
            return itemDetail(
              'hiring_duration'.tr,
              '${bookingController.duration} hours',
            );
          }),
          itemDetail(
            'date'.tr,
            DateFormat(
              'dd MMM yyyy',
            ).format(bookingController.bookingDetail.date),
          ),
          GetBuilder<BookingController>(
            builder: (controller) {
              return itemDetail(
                'subtotal'.tr,
                AppFormat.price(controller.bookingDetail.subtotal),
              );
            },
          ),
          itemDetail(
            'insurance'.tr,
            AppFormat.price(bookingController.bookingDetail.insurance),
          ),
          itemDetail(
            'tax14'.tr,
            AppFormat.price(bookingController.bookingDetail.tax),
          ),
          itemDetail(
            'platform_fee'.tr,
            AppFormat.price(bookingController.bookingDetail.platformFee),
          ),
          itemDetail(
            'grand_total'.tr,
            AppFormat.price(bookingController.bookingDetail.grandTotal),
          ),
        ],
      ),
    );
  }

  Widget itemDetail(String title, String data) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            data,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget whenYouNeed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(text: 'when_need'.tr, autoPadding: true),
        DView.height(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          ),
          padding: const EdgeInsets.fromLTRB(12, 12, 6, 12),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/ic_clock.png',
                  width: 24,
                  height: 24,
                ),
              ),
              DView.width(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'today'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(DateFormat('dd MMM yyyy').format(DateTime.now())),
                  ],
                ),
              ),
              Radio(
                value: 1,
                groupValue: 1,
                visualDensity: const VisualDensity(horizontal: -4),
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget selectDuration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(text: 'how_many_hours'.tr, autoPadding: true),
        DView.height(),
        SizedBox(
          height: 100,
          child: Obx(() {
            int durationSelected = bookingController.duration;
            return ListView.builder(
              padding: const EdgeInsets.only(left: 20),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: bookingController.hourDuartion.length,
              itemBuilder: (context, index) {
                int itemDuration = bookingController.hourDuartion[index];
                return GestureDetector(
                  onTap: () {
                    bookingController.setDuration(
                      itemDuration,
                      widget.worker.hourRate,
                    );
                  },
                  child: itemDuration == durationSelected
                      ? itemDurationSelected(itemDuration)
                      : itemDurationUnSelected(itemDuration),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Container itemDurationSelected(int itemDuration) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$itemDuration',
            style: const TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('hours'.tr, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Container itemDurationUnSelected(int itemDuration) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColor.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$itemDuration',
            style: const TextStyle(
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('hours'.tr),
        ],
      ),
    );
  }

  Widget worker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.white,
        elevation: 8,
        shadowColor: Colors.black12,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.network(
                Appwrite.imageURL(widget.worker.image),
                width: 70,
                height: 70,
              ),
              DView.width(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.worker.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        DView.width(4),
                        Image.asset(
                          'assets/images/ic_verified.png',
                          width: 16,
                          height: 16,
                        ),
                      ],
                    ),
                    DView.height(4),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/ic_star_small.png',
                          width: 16,
                          height: 16,
                        ),
                        DView.width(2),
                        Text(
                          widget.worker.rating.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              DView.width(12),
              Row(
                children: [
                  Text(
                    AppFormat.price(widget.worker.hourRate),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text('per_hr_short'.tr),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
