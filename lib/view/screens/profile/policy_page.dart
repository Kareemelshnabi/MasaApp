import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/profile/policy_controller.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PolicyController());
    return Scaffold(
      backgroundColor: sharedPreferences!.getBool("darkMode") == false
          ? LightMode.registerText
          : DarkMode.darkModeSplash,
      body: GetBuilder<PolicyController>(
        builder: (controller) => Column(
          children: [
            appBarMyPolicy(context),
            SizedBox(
              height: 2.w,
            ),
            Image.asset(
              ImagesLink.policyImage,
              height: 15.h,
              width: 30.w,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 2.w,
            ),
            questionText(
                controller.show == false ? 10.5.h : 23.h,
                controller.show == false ? null : LightMode.searchField,
                "أ. المقدمة:",
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
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash,
                controller.show,
                "تنص على أن استخدام التطبيق يعني الموافقة على الشروط والأحكام."),
            questionText(
                controller.show_1 == false ? 10.5.h : 23.h,
                controller.show_1 == false ? null : LightMode.searchField,
                "ب. الاستخدام المقبول:",
                controller.show_1 == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash, () {
              controller.showText_1();
            },
                controller.show_1 == false
                    ? Icons.arrow_drop_down
                    : Icons.arrow_drop_up,
                controller.show_1 == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash,
                controller.show_1,
                "يجب على المستخدمين الالتزام باستخدام التطبيق للأغراض المشروعة فقط."),
            questionText(
                controller.show_2 == false ? 10.5.h : 23.h,
                controller.show_2 == false ? null : LightMode.searchField,
                "ج. حقوق الملكية الفكرية:",
                controller.show_2 == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash, () {
              controller.showText_2();
            },
                controller.show_2 == false
                    ? Icons.arrow_drop_down
                    : Icons.arrow_drop_up,
                controller.show_2 == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash,
                controller.show_2,
                "توضيح أن جميع المحتويات داخل التطبيق هي ملك للشركة ولا يجوز استخدامها بدون إذن."),
            questionText(
                controller.show_3 == false ? 10.5.h : 23.h,
                controller.show_3 == false ? null : LightMode.searchField,
                "د. سياسة الدفع والرسوم:",
                controller.show_3 == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash, () {
              controller.showText_3();
            },
                controller.show_3 == false
                    ? Icons.arrow_drop_down
                    : Icons.arrow_drop_up,
                controller.show_3 == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash,
                controller.show_3,
                "تحديد شروط الدفع مقابل الخدمات داخل التطبيق، وكيفية إتمام المعاملات."),
            questionText(
                controller.show_4 == false ? 10.5.h : 23.h,
                controller.show_4 == false ? null : LightMode.searchField,
                "هـ. سياسة الإلغاء والاسترداد:",
                controller.show_4 == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash, () {
              controller.showText_4();
            },
                controller.show_4 == false
                    ? Icons.arrow_drop_down
                    : Icons.arrow_drop_up,
                controller.show_4 == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash,
                controller.show_4,
                "توضيح متى يمكن للمستخدم إلغاء الطلب أو طلب استرداد الأموال، إن وجدت."),
            questionText(
                controller.show_5 == false ? 10.5.h : 23.h,
                controller.show_5 == false ? null : LightMode.searchField,
                "و. التعديلات على الشروط:",
                controller.show_5 == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash, () {
              controller.showText_5();
            },
                controller.show_5 == false
                    ? Icons.arrow_drop_down
                    : Icons.arrow_drop_up,
                controller.show_5 == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash,
                controller.show_5,
                "توضيح أن الشركة تحتفظ بالحق في تعديل الشروط في أي وقت مع إشعار مسبق للمستخدمين."),
            questionText(
                controller.show_6 == false ? 10.5.h : 23.h,
                controller.show_6 == false ? null : LightMode.searchField,
                "ز. المسؤولية القانونية:",
                controller.show_6 == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash, () {
              controller.showText_6();
            },
                controller.show_6 == false
                    ? Icons.arrow_drop_down
                    : Icons.arrow_drop_up,
                controller.show_6 == false
                    ? sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor
                    : sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.splash
                        : DarkMode.darkModeSplash,
                controller.show_6,
                "تحديد حدود المسؤولية القانونية للشركة تجاه أي أضرار أو خسائر قد تنشأ عن استخدام التطبيق"),
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

Widget appBarMyPolicy(context) {
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
              S.of(context).privacy,
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
