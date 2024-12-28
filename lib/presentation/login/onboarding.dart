import 'package:flutter/material.dart';

import '../../config/assets/assets.gen.dart';
import '../../config/extension/route_ext.dart';
import '../../config/theme/app_theme.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AssetGenImage> getStarted = [
      Assets.images.gstarted1,
      Assets.images.gstarted2,
      Assets.images.gstarted3,
    ];
    final List<AssetGenImage> getStarted2 = [
      Assets.images.gstarted4,
      Assets.images.gstarted5,
      Assets.images.gstarted6,
    ];
    final List<AssetGenImage> getStarted3 = [
      Assets.images.gstarted7,
      Assets.images.gstarted8,
      Assets.images.gstarted9,
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Column(
                spacing: 20,
                children: [
                  _imageStarted(getStarted),
                  _imageStarted(getStarted2),
                  _imageStarted(getStarted3),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Cari pekerja untuk \n pertumbugan bisnis",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    color: Color(0xff13162f),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'kami menyediakan pekerjaan yang \n berkualitas dan berkualitas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 2,
                    color: Color(0xffa7a8b3),
                  ),
                ),
              ),
              //button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteExt.register.name);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mulai",
                      ), 
                      ImageIcon(
                        AssetImage(Assets.images.icWhiteArrowRight.path),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _imageStarted(List<AssetGenImage> images) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: images
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(
                  e.path,
                  fit: BoxFit.cover,
                  height: 190,
                ),
              ),
            )
            .toList(),
      ),
    ),
  );
}
