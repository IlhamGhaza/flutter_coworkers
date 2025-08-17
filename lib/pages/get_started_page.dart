import 'package:flutter_coworkers/config/enums.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    const getStarted1 = [
      'assets/images/gstarted1.png',
      'assets/images/gstarted2.png',
      'assets/images/gstarted3.png',
    ];
    const getStarted2 = [
      'assets/images/gstarted4.png',
      'assets/images/gstarted5.png',
      'assets/images/gstarted6.png',
    ];
    const getStarted3 = [
      'assets/images/gstarted7.png',
      'assets/images/gstarted8.png',
      'assets/images/gstarted9.png',
    ];
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageStarted(getStarted1),
            DView.height(20),
            imageStarted(getStarted2),
            DView.height(20),
            imageStarted(getStarted3),
            DView.height(30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'get_started_title'.tr,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
            ),
            DView.height(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'get_started_desc'.tr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurface,
                  height: 2,
                ),
              ),
            ),
            DView.height(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FilledButton(
                onPressed: () {
                  Get.offNamed(AppRoute.signIn.path);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'explore_worker'.tr,
                      style: TextStyle(
                          color: Colors.white),
                    ),
                    ImageIcon(
                      AssetImage('assets/images/ic_white_arrow_right.png'),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            DView.height(30),
          ],
        ),
      ),
    );
  }

  Widget imageStarted(List images) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: images.map((e) {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset(e, fit: BoxFit.cover, height: 190),
            );
          }).toList(),
        ),
      ),
    );
  }
}
