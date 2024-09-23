// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mas_app/core/constant/colors.dart';

import '../main.dart';

class DarkModeController extends GetxController {
  bool value = false;
  enableDarkMode(bool val) {
    value = val;
    sharedPreferences!.setBool("darkMode", value);
    print("${sharedPreferences!.getBool("darkMode")}");
    checkMode();
    update();
  }

  checkMode() {
    // splash

     Color backGroundDark = LightMode.splash;
     //button  textbutton
       
     Color buttonDarfkDark = LightMode.splash;


    if (sharedPreferences!.getBool("darkMode") == false) {
       backGroundDark = LightMode.splash;
    } else if (sharedPreferences!.getBool("darkMode") == true) {

 backGroundDark = DarkMode.darkModeSplash;

    }
  }

  @override
  void onInit() {
    // sharedPreferences!.setBool("darkMode", value);
    //checkMode();
    super.onInit();
  }
}
