import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/profile/faq_controller.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FaqController());
    return Scaffold(
      backgroundColor: sharedPreferences!.getBool("darkMode") == false
          ? LightMode.registerText
          : DarkMode.darkModeSplash,
      body: GetBuilder<FaqController>(
        builder: (controller) => Column(
          children: [
            appBarMyOrders(context),
            questionText(
                controller.show == false ? 10.4.h : 20.h,
                controller.show == false ? null : LightMode.searchField,
                "ما هو التطبيق الخاص بنا ؟",
                controller.show == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash, () {
              controller.showText();
            },
                controller.show == false
                    ? Icons.arrow_drop_down
                    : Icons.arrow_drop_up,
                controller.show == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : LightMode.splash,
                controller.show,
                "هو تطبيق بيقدم خدمات كتير تساعدنا علي توفير وقت لذهاب وتضيع الوقت وبيقدم خدمات كثير مثل خدمات دراسية وخدمات كثير يمكن التعرف عليها من خلال تصفح التطبيق الخاص بنا ويمكن طلب أي شئ تريده من خلالنا ويمكن التحدث معنا من خلال خدمة العملاء")
          ],
        ),
      ),
    );
  }
}

Widget questionText(
    height, color, title, textColor, onPress, icon, colorIcon, show, body) {
  return Container(
    margin: EdgeInsets.only(top: 2.w),
    padding: EdgeInsets.only(top: 2.w, bottom: 3.w, right: 5.w, left: 5.w),
    width: 100.w,
    height: height,
    color: color,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.tajawal(
                  fontSize: 3.5.w,
                  fontWeight: FontWeight.bold,
                  color: textColor),
            ),
            IconButton(
                onPressed: onPress,
                icon: Icon(
                  icon,
                  color: colorIcon,
                ))
          ],
        ),
        show == true
            ? Text(
                body,
                style: GoogleFonts.tajawal(
                    fontSize: 3.w,
                    fontWeight: FontWeight.w600,
                    color: sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor),
              )
            : const SizedBox(),
        show == false
            ? Divider(
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.registerButtonBorder
                    : DarkMode.whiteDarkColor,
                height: 2,
              )
            : const SizedBox()
      ],
    ),
  );
}

Widget appBarMyOrders(context) {
  return SizedBox(
    width: 100.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 20.w,
          child: Padding(
            padding: EdgeInsets.only(top: 7.w),
            child: IconButton(
                onPressed: () {
                  Navigator.canPop(context)
                      ? Get.back()
                      : Get.off(() => const Home());
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 6.w,
                  color: sharedPreferences!.getBool("darkMode") == false
                      ? LightMode.registerButtonBorder
                      : DarkMode.whiteDarkColor,
                )),
          ),
        ),
        SizedBox(
          width: 60.w,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 6.5.h,
              bottom: 2.h,
            ),
            child: Text(
              "الأسئلة الشائعة",
              style: GoogleFonts.tajawal(
                fontSize: 5.w,
                fontWeight: FontWeight.bold,
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.typeUserTitle
                    : DarkMode.whiteDarkColor,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
      ],
    ),
  );
}
