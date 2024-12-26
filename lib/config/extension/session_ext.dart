import 'package:d_session/d_session.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../model/user_model.dart';

class SessionExt {
  static Future<bool> setUser(Map user) async {
    bool success = await DSession.setUser(Map.from(user));

    if (success) {
      final userController = Get.put(UserController());
      userController.data = UserModel.fromJson(Map.from(user));
    }
    return success;
  }

  //getuser
  static Future<Map?> getUser(Map user) async {
    Map? mapUser = await DSession.getUser();
    if (mapUser != null) {
      final userController = Get.put(UserController());
      userController.data = UserModel.fromJson(Map.from(mapUser));
    }
    return mapUser;
  }

  //removeuser
  static Future<bool> removeUser(Map user) async {
    bool success = await DSession.removeUser();
    if (success) {
      final userController = Get.put(UserController());
      userController.data = UserModel();
    }
    return success;
  }
}
