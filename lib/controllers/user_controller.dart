import 'package:get/get.dart';

import '../model/user_model.dart';

class UserController extends GetxController { 
  final _data = UserModel().obs;
  UserModel get data => _data.value;
  set data(UserModel n) => _data.value = n;
  // UserModel get data => _data.value;
  // set data(UserModel value) => _data.value = value;
}