// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mas_app/view/screens/home/home.dart';

import '../main.dart';

class DarkModeController extends GetxController {
  bool value = false;
  changLang(lang) async {
    if (lang == "ar") {
    
      await sharedPreferences!.setString("local", "ar");
                            Get.updateLocale(const Locale("ar"));

      Get.offAll(() => const Home());
      update();
    } else {
     
      await sharedPreferences!.setString("local", "en");
                            Get.updateLocale(const Locale("en"));

      update();

      Get.offAll(() => const Home());
    }
  }

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
