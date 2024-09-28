// ignore_for_file: avoid_print

import 'package:get/get_state_manager/get_state_manager.dart';

import '../main.dart';

class DarkModeController extends GetxController {
  bool value = false;
  enableDarkMode(bool val) {
    value = val;
    sharedPreferences!.setBool("darkMode", value);
    print("${sharedPreferences!.getBool("darkMode")}");
    update();
  }



  @override
  void onInit() {
    // sharedPreferences!.setBool("darkMode", value);
    //checkMode();
    super.onInit();
  }
}
