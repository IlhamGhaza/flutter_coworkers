import 'package:flutter_coworkers/controllers/checkout_controller.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_color.dart';
import '../config/app_format.dart';
import '../controllers/booking_controller.dart';
import '../controllers/user_controller.dart';
import '../widgets/header_worker_left.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final checkoutController = Get.put(CheckoutController());
  final bookingController = Get.put(BookingController());
  final userController = Get.put(UserController());

  @override
  void dispose() {
    checkoutController.clear();
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
                  offset: const Offset(0, 55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeaderWorkerLeft(
                        title: 'Checkout',
                        subtitle: 'Start hiring and grow',
                        iconLeft: 'assets/ic_back.png',
                        functionLeft: () {
                          Navigator.pop(context);
                        },
                      ),
                      payments(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(offset: const Offset(0, 60), child: walletBox()),
          DView.spaceHeight(50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Total pay',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Obx(() {
                return Text(
                  AppFormat.price(bookingController.bookingDetail.grandTotal),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                );
              }),
            ],
          ),
          DView.spaceHeight(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Material(
                    borderRadius: BorderRadius.circular(6),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                DView.spaceWidth(8),
                const Text(
                  'I agree with terms and conditions',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          DView.spaceHeight(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              if (checkoutController.loading) return DView.loadingCircle();
              return FilledButton.icon(
                onPressed: () {
                  checkoutController.execute(
                    context,
                    bookingController.bookingDetail,
                  );
                },
                icon: const ImageIcon(AssetImage('assets/ic_secure.png')),
                label: const Text('Pay Now'),
              );
            }),
          ),
          DView.spaceHeight(30),
          const Center(
            child: Text(
              'Read Terms & Conditions',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                decorationStyle: TextDecorationStyle.solid,
                fontSize: 16,
                color: Color(0xffB2B3BC),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget walletBox() {
    return Stack(
      children: [
        Image.asset('assets/bg_card.png'),
        Positioned(
          left: 60,
          top: 110,
          child: Text(
            AppFormat.price(45988),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Positioned(
          left: 60,
          right: 60,
          bottom: 106,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return Text(
                  userController.data.name ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                );
              }),
              const Text(
                '12/27',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget payments() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: checkoutController.payments.map((e) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5),
                    color: e['is_active']
                        ? Theme.of(context).primaryColor
                        : const Color(0xffF2F2F2),
                  ),
                  child: Image.asset(e['image']),
                ),
                DView.spaceHeight(8),
                Text(
                  e['label'],
                  style: TextStyle(
                    color: e['is_active']
                        ? Colors.black
                        : const Color(0xffA7A8B3),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
