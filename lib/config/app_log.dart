import 'package:d_method/d_method.dart';

class AppLog {
  static void success({String? title, required String body}) {
    if (title == null) {
      DMethod.printBasic(body, 40);
      return;
    }

    DMethod.printTitle(title, body, titleCode: 10, bodyCode: 40);
  }

  static void error({String? title, required String body}) {
    if (title == null) {
      DMethod.printBasic(body, 160);
      return;
    }

    DMethod.printTitle(title, body, titleCode: 1, bodyCode: 160);
  }

  static void netral({String? title, required String body}) {
    if (title == null) {
      DMethod.printBasic(body);
      return;
    }

    DMethod.printTitle(title, body);
  }
}
