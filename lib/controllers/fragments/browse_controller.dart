import 'package:get/get.dart';

class BrowseController extends GetxController {
  clear() {
    Get.delete<BrowseController>(force: true);
  }

  List categories = [
    {
      'label': 'Driver',
      'icon': 'assets/ic_driver.png',
    },
    {
      'label': 'Tutor',
      'icon': 'assets/ic_tutor.png',
    },
    {
      'label': 'Gardener',
      'icon': 'assets/ic_gardener.png',
    },
    {
      'label': 'Cleaner',
      'icon': 'assets/ic_cleaner.png',
    },
    {
      'label': 'Other',
      'icon': 'assets/ic_others.png',
    },
  ];

  List highRatedWorkers = [
    {
      'image': 'assets/shian.png',
      'name': 'Shian',
      'rate': 4.8,
    },
    {
      'image': 'assets/cindinan.png',
      'name': 'Cindinan',
      'rate': 4.9,
    },
    {
      'image': 'assets/ajinomo.png',
      'name': 'Ajinomo',
      'rate': 4.8,
    },
    {
      'image': 'assets/sajima.png',
      'name': 'Sajima',
      'rate': 4.8,
    },
  ];

  List newcomers = [
    {
      'image': 'assets/jundi.png',
      'name': 'Jundi',
      'job': 'Gardener',
    },
    {
      'image': 'assets/mona.png',
      'name': 'Mona',
      'job': 'Chef',
    },
    {
      'image': 'assets/sushi.png',
      'name': 'Sushi',
      'job': 'Tutor',
    },
    {
      'image': 'assets/romi.png',
      'name': 'Romi',
      'job': 'Writer',
    },
    {
      'image': 'assets/lona.png',
      'name': 'Lona',
      'job': 'Cleaner',
    },
    {
      'image': 'assets/daren.png',
      'name': 'Daren',
      'job': 'Security',
    },
  ];

  List curatedTips = [
    {
      'image': 'assets/news1.png',
      'name': '12 Tips Seleksi Pekerja',
      'category': 'Productivity',
      'is_popular': false,
    },
    {
      'image': 'assets/news3.png',
      'name': 'Kapan Harus Scale Up?',
      'category': 'BUssiness',
      'is_popular': true,
    },
    {
      'image': 'assets/news2.png',
      'name': 'Pemilihan Alat Cleaner',
      'category': 'Health',
      'is_popular': false,
    },
  ];
}
