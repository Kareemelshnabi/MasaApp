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
        builder: (controller) => SingleChildScrollView(
          child: Column(
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
                  controller.show == false ? 9.h : 18.h,
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
                  "نحن في تطبيق \"masa\" نولي اهتماماً كبيراً بخصوصية مستخدمينا. نهدف إلى حماية المعلومات الشخصية الخاصة بك وضمان استخدامها بطريقة تتماشى مع القوانين المعمول بها. تنطبق هذه السياسة على جميع البيانات التي نجمعها من خلال استخدامك للتطبيق."),
              questionText(
                  controller.show_1 == false ? 9.h : 25.h,
                  controller.show_1 == false ? null : LightMode.searchField,
                  "المعلومات التي نجمعها",
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
                  ''' نقوم بجمع المعلومات التالية عند استخدامك للتطبيق:
- المعلومات الشخصية: مثل الاسم، عنوان البريد الإلكتروني، رقم الهاتف، ومعلومات الدفع.
- المعلومات التقنية: مثل نوع الجهاز، عنوان الـ IP، نظام التشغيل، وإصدار التطبيق المستخدم.
- المعلومات حول الاستخدام: بيانات حول تفاعلك مع التطبيق، مثل الصفحات التي تزورها والخدمات التي تطلبها.
  '''),
              questionText(
                  controller.show_2 == false ? 9.h : 25.h,
                  controller.show_2 == false ? null : LightMode.searchField,
                  " كيفية استخدام المعلومات",
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
                  '''نستخدم المعلومات التي نجمعها للأغراض التالية:
- تحسين تجربة المستخدم: تخصيص المحتوى والخدمات بناءً على احتياجاتك.
- تنفيذ الطلبات: معالجة الطلبات التي تقدمها عبر التطبيق وتسهيل عملية الدفع والتوصيل.
- التواصل: إرسال إشعارات حول طلباتك، العروض الترويجية، أو التحديثات المتعلقة بالتطبيق.
- الأمان: حماية بياناتك وتأمين التطبيق من أي تهديدات أمنية.  '''),
              questionText(
                  controller.show_3 == false ? 9.h : 27.h,
                  controller.show_3 == false ? null : LightMode.searchField,
                  "مشاركة المعلومات",
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
                  '''نحن لا نبيع أو نؤجر معلوماتك الشخصية لأي طرف ثالث. قد نشارك المعلومات فقط في الحالات التالية:
- مقدمو الخدمات: نشارك معلوماتك مع مقدمي خدمات خارجيين لمساعدتنا في تشغيل التطبيق (مثل شركات التوصيل أو معالجات الدفع).
- الامتثال القانوني: إذا طلب منا القانون أو الجهات التنظيمية مشاركة بياناتك.
- حماية حقوقنا: لحماية حقوقنا أو حقوق المستخدمين الآخرين في حال حدوث نزاع قانوني. '''),
              questionText(
                  controller.show_4 == false ? 9.h : 15.h,
                  controller.show_4 == false ? null : LightMode.searchField,
                  "تخزين البيانات",
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
                  "نحتفظ بمعلوماتك الشخصية طالما كان ذلك ضروريًا لتحقيق الأغراض التي تم جمعها من أجلها، أو للامتثال للمتطلبات القانونية."),
              questionText(
                  controller.show_5 == false ? 9.h : 15.h,
                  controller.show_5 == false ? null : LightMode.searchField,
                  "أمان البيانات",
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
                  "نلتزم بحماية معلوماتك من الوصول غير المصرح به أو التعديل أو الإفصاح غير المشروع باستخدام تدابير أمان تقنية وإدارية مناسبة."),
              questionText(
                  controller.show_6 == false ? 9.h : 25.h,
                  controller.show_6 == false ? null : LightMode.searchField,
                  "حقوقك",
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
                  '''لديك الحق في:
- الوصول إلى بياناتك الشخصية: يمكنك طلب نسخة من المعلومات التي نحتفظ بها عنك.
- تعديل أو حذف بياناتك: يمكنك طلب تعديل أو حذف بياناتك الشخصية في أي وقت.
- إلغاء الاشتراك: يمكنك إلغاء الاشتراك من الرسائل الترويجية عبر النقر على رابط الإلغاء المرفق في الرسائل '''),
              questionText(
                  controller.show_7 == false ? 9.h : 20.h,
                  controller.show_7 == false ? null : LightMode.searchField,
                  "ملفات تعريف الارتباط (Cookies)",
                  controller.show_7 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.splash
                          : DarkMode.darkModeSplash, () {
                controller.showText_7();
              },
                  controller.show_7 == false
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                  controller.show_7 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.splash
                          : DarkMode.darkModeSplash,
                  controller.show_7,
                  "ستخدم التطبيق ملفات تعريف الارتباط لتخصيص تجربة المستخدم وتحليل كيفية استخدامك للتطبيق. يمكنك التحكم في إعدادات ملفات تعريف الارتباط من خلال إعدادات جهازك."),
              questionText(
                  controller.show_8 == false ? 9.h : 20.h,
                  controller.show_8 == false ? null : LightMode.searchField,
                  "التحديثات على سياسة الخصوصية",
                  controller.show_8 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.splash
                          : DarkMode.darkModeSplash, () {
                controller.showText_8();
              },
                  controller.show_8 == false
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                  controller.show_8 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.splash
                          : DarkMode.darkModeSplash,
                  controller.show_8,
                  "قد نقوم بتحديث سياسة الخصوصية من وقت لآخر لتتماشى مع التغييرات في ممارساتنا أو المتطلبات القانونية. سيتم إخطارك بأي تغييرات جوهرية عن طريق إشعار داخل التطبيق."),
            ],
          ),
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
