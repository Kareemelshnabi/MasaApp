import 'package:get/get.dart';

class PolicyController extends GetxController {
  bool show = false;
  showText() {
    if (show == false) {
      show = true;
      update();
    } else {
      show = false;
      update();
    }
  }
}