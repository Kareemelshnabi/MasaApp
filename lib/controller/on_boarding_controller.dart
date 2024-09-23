import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/register/main_register.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class OnBoardingController extends GetxController {
  int x = 0;
  bool chooseVisit = false;
  bool chooseSeller = false;

  chooseType(String type) {
    if (type == "seller") {
      sharedPreferences!.setBool("visit", false);
      chooseSeller = true;
      chooseVisit = false;
    } else {
      sharedPreferences!.setBool("visit", true);
      chooseSeller = false;
      chooseVisit = true;
    }
    update();
  }

  changOnboard(y) {
    x = y;
    update();
  }

  message(message) {
    Get.defaultDialog(
        title: "خطأ",
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                    fontSize: 3.5.w,
                    color: LightMode.registerButtonBorder,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 3.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.off(() => const MainRegister());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: LightMode.splash,
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      width: 30.w,
                      height: 5.h,
                      child: Center(
                        child: Text(
                          "إنشاء حساب",
                          style: GoogleFonts.tajawal(
                              fontSize: 4.w,
                              color: LightMode.registerText,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: LightMode.splash),
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      width: 30.w,
                      height: 5.h,
                      child: Center(
                        child: Text(
                          "إلغاء",
                          style: GoogleFonts.tajawal(
                              fontSize: 4.w,
                              color: LightMode.splash,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void onInit() {
    print(sharedPreferences!.getString("pageStart"));
    print(sharedPreferences!.getString("local"));
    sharedPreferences!.setBool("darkMode", false);

    super.onInit();
  }
}
