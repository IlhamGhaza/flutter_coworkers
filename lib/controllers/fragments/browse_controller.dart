import 'package:get/get.dart';

class BrowseController extends GetxController {
  void clear() {
    Get.delete<BrowseController>(force: true);
  }

  List<Map<String, String>> categories = [
    {
      'label': 'Driver',
      'icon': 'assets/images/ic_driver.png',
    },
    {
      'label': 'Tutor',
      'icon': 'assets/images/ic_tutor.png',
    },
    {
      'label': 'Gardener',
      'icon': 'assets/images/ic_gardener.png',
    },
    {
      'label': 'Cleaner',
      'icon': 'assets/images/ic_cleaner.png',
    },
    {
      'label': 'Other',
      'icon': 'assets/images/ic_others.png',
    },
  ];

  List<Map<String, dynamic>> highRatedWorkers = [
    {
      'image': 'assets/images/shian.png',
      'name': 'Shian',
      'rate': 4.8,
    },
    {
      'image': 'assets/images/cindinan.png',
      'name': 'Cindinan',
      'rate': 4.9,
    },
    {
      'image': 'assets/images/ajinomo.png',
      'name': 'Ajinomo',
      'rate': 4.8,
    },
    {
      'image': 'assets/images/sajima.png',
      'name': 'Sajima',
      'rate': 4.8,
    },
  ];

  List<Map<String, String>> newcomers = [
    {
      'image': 'assets/images/jundi.png',
      'name': 'Jundi',
      'job': 'Gardener',
    },
    {
      'image': 'assets/images/mona.png',
      'name': 'Mona',
      'job': 'Chef',
    },
    {
      'image': 'assets/images/sushi.png',
      'name': 'Sushi',
      'job': 'Tutor',
    },
    {
      'image': 'assets/images/romi.png',
      'name': 'Romi',
      'job': 'Writer',
    },
    {
      'image': 'assets/images/lona.png',
      'name': 'Lona',
      'job': 'Cleaner',
    },
    {
      'image': 'assets/images/daren.png',
      'name': 'Daren',
      'job': 'Security',
    },
  ];

  List<Map<String, dynamic>> curatedTips = [
    {
      'image': 'assets/images/news1.png',
      'name': '12 Tips Seleksi Pekerja',
      'category': 'Productivity',
      'is_popular': false,
    },
    {
      'image': 'assets/images/news3.png',
      'name': 'Kapan Harus Scale Up?',
      'category': 'BUssiness',
      'is_popular': true,
    },
    {
      'image': 'assets/images/news2.png',
      'name': 'Pemilihan Alat Cleaner',
      'category': 'Health',
      'is_popular': false,
    },
  ];
}
