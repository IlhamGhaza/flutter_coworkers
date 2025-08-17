import 'package:flutter_coworkers/data/datasources/worker_datasource.dart';
import 'package:flutter_coworkers/data/models/worker_model.dart';
import 'package:get/get.dart';

class ListWorkerController extends GetxController {
  void clear() {
    Get.delete<ListWorkerController>(force: true);
  }

  final List<Map<String, dynamic>> topRated = [
    {'image': 'assets/images/shian.png', 'name': 'Shian', 'rate': 4.8},
    {'image': 'assets/images/cindinan.png', 'name': 'Cindinan', 'rate': 4.9},
    {'image': 'assets/images/ajinomo.png', 'name': 'Ajinomo', 'rate': 4.8},
    {'image': 'assets/images/sajima.png', 'name': 'Sajima', 'rate': 4.8},
  ];

  final RxList<WorkerModel> _availableWorkers = <WorkerModel>[].obs;
  List<WorkerModel> get availableWorkers => _availableWorkers;
  set availableWorkers(List<WorkerModel> n) => _availableWorkers.value = n;

  final RxString _statusFetch = ''.obs;
  String get statusFetch => _statusFetch.value;
  set statusFetch(String n) => _statusFetch.value = n;

  void fetchAvailable(String category) {
    statusFetch = 'Loading';
    WorkerDatasource.fetchAvailable(category).then((value) {
      value.fold(
        (message) {
          statusFetch = message;
        },
        (workers) {
          statusFetch = 'Success';
          availableWorkers = workers;
        },
      );
    });
  }
}
