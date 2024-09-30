import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/profile/faq_controller.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/generated/l10n.dart';
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
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              appBarMyOrders(context),
              questionText(
                  controller.show == false ? 9.h : 15.h,
                  controller.show == false ? null : LightMode.searchField,
                  "كيف يمكنني التسجيل في التطبيق؟",
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
                  "يمكنك التسجيل عبر إدخال بريدك الإلكتروني أو رقم هاتفك وتعيين كلمة مرور، أو استخدام حسابات التواصل الاجتماعي الخاصة بك."),
              questionText(
                  controller.show_1 == false ? 9.h : 15.h,
                  controller.show_1 == false ? null : LightMode.searchField,
                  "كيف أقوم بتقديم طلب طباعة أو خدمة؟",
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
                      : LightMode.splash,
                  controller.show_1,
                  "بعد تسجيل الدخول، اختر الخدمة المطلوبة من قائمة الخدمات، قم بتحميل الملفات اللازمة، حدد التفاصيل مثل حجم الطباعة وعدد النسخ، ثم قم بتأكيد الطلب والدفع."),
              questionText(
                  controller.show_2 == false ? 9.h : 15.h,
                  controller.show_2 == false ? null : LightMode.searchField,
                  "ما هي طرق الدفع المتاحة؟",
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
                      : LightMode.splash,
                  controller.show_2,
                  "يمكنك الدفع عبر البطاقة الائتمانية، بطاقة الخصم المباشر، أو عبر الخدمات الإلكترونية مثل PayPal أو Apple Pay.."),
              questionText(
                  controller.show_3 == false ? 9.h : 15.h,
                  controller.show_3 == false ? null : LightMode.searchField,
                  "كيف يمكنني متابعة حالة طلبي؟",
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
                      : LightMode.splash,
                  controller.show_3,
                  "بعد تقديم الطلب، يمكنك متابعة حالته من خلال قسم \"الطلبات\" في التطبيق، حيث ستتمكن من معرفة ما إذا كان الطلب قيد التنفيذ أو جاهزاً للتوصيل.."),
              questionText(
                  controller.show_4 == false ? 9.h : 15.h,
                  controller.show_4 == false ? null : LightMode.searchField,
                  "هل يمكنني تعديل أو إلغاء الطلب بعد تقديمه؟",
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
                      : LightMode.splash,
                  controller.show_4,
                  "يمكنك تعديل أو إلغاء الطلب قبل بدء عملية الطباعة أو التجهيز. إذا تم بدء العملية، يرجى التواصل مع الدعم لمعرفة الخيارات المتاحة."),
              questionText(
                  controller.show_5 == false ? 9.h : 15.h,
                  controller.show_5 == false ? null : LightMode.searchField,
                  "كم من الوقت يستغرق إتمام الطلب؟",
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
                      : LightMode.splash,
                  controller.show_5,
                  "يعتمد الوقت على نوع الخدمة المطلوبة. يتم تقديم تقدير زمني لكل طلب عند تقديمه، كما يمكنك متابعة التحديثات عبر التطبيق."),
              questionText(
                  controller.show_6 == false ? 9.h : 15.h,
                  controller.show_6 == false ? null : LightMode.searchField,
                  "هل توجد رسوم توصيل؟",
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
                      : LightMode.splash,
                  controller.show_6,
                  "نعم، رسوم التوصيل تختلف حسب المنطقة. يمكنك رؤية تفاصيل رسوم التوصيل عند إتمام الطلب."),
              questionText(
                  controller.show_7 == false ? 9.h : 15.h,
                  controller.show_7 == false ? null : LightMode.searchField,
                  "ما هي المناطق التي يتم التوصيل إليها؟",
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
                      : LightMode.splash,
                  controller.show_7,
                  "نقوم بالتوصيل إلى جميع المناطق داخل الكويت، وقد تختلف الرسوم حسب موقعك."),
              questionText(
                  controller.show_8 == false ? 9.h : 15.h,
                  controller.show_8 == false ? null : LightMode.searchField,
                  "كيف يمكنني التواصل مع خدمة العملاء؟",
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
                      : LightMode.splash,
                  controller.show_8,
                  "يمكنك التواصل مع خدمة العملاء عبر الدردشة المباشرة داخل التطبيق أو عبر البريد الإلكتروني ورقم الهاتف المدرجين في قسم \"اتصل بنا\"."),
              questionText(
                  controller.show_9 == false ? 9.h : 15.h,
                  controller.show_9 == false ? null : LightMode.searchField,
                  "هل يمكنني إعادة طباعة أو طلب تعديلات بعد استلامي للطلب؟",
                  controller.show_9 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.splash
                          : DarkMode.darkModeSplash, () {
                controller.showText_9();
              },
                  controller.show_9 == false
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                  controller.show_9 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : LightMode.splash,
                  controller.show_9,
                  "ذا كانت هناك أي مشكلة في جودة الطباعة أو الخدمة، يمكنك التواصل معنا لإعادة الطباعة أو إجراء التعديلات اللازمة"),
              questionText(
                  controller.show_10 == false ? 9.h : 15.h,
                  controller.show_10 == false ? null : LightMode.searchField,
                  "ما هي سياسات الاسترداد؟",
                  controller.show_10 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.splash
                          : DarkMode.darkModeSplash, () {
                controller.showText_10();
              },
                  controller.show_10 == false
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                  controller.show_10 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : LightMode.splash,
                  controller.show_10,
                  "في حال عدم رضاك عن جودة الخدمة، يمكنك طلب استرداد خلال 7 أيام من استلام الطلب، بعد مراجعة الحالة."),
              questionText(
                  controller.show_11 == false ? 9.h : 15.h,
                  controller.show_11 == false ? null : LightMode.searchField,
                  "هل يمكنني طلب طباعة مخصصة لمنتجاتي الخاصة؟",
                  controller.show_11 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.splash
                          : DarkMode.darkModeSplash, () {
                controller.showText_11();
              },
                  controller.show_11 == false
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                  controller.show_11 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : LightMode.splash,
                  controller.show_11,
                  "نعم، نحن نقدم خدمات طباعة مخصصة بناءً على احتياجاتك. يمكنك تحديد تفاصيل الطباعة الخاصة بالمنتج عند تقديم الطلب."),
              questionText(
                  controller.show_12 == false ? 9.h : 15.h,
                  controller.show_12 == false ? null : LightMode.searchField,
                  "ما هي أنواع الطباعة المتاحة؟",
                  controller.show_12 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.splash
                          : DarkMode.darkModeSplash, () {
                controller.showText_12();
              },
                  controller.show_12 == false
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                  controller.show_12 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : LightMode.splash,
                  controller.show_12,
                  "نقدم مجموعة واسعة من خدمات الطباعة، بما في ذلك طباعة الوثائق، البانرات، طباعة على التيشرتات، الأكواب، وغيرها."),
              questionText(
                  controller.show_13 == false ? 9.h : 15.h,
                  controller.show_13 == false ? null : LightMode.searchField,
                  "هل يمكنني استلام الطلب من المتجر بدلاً من التوصيل؟",
                  controller.show_13 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.splash
                          : DarkMode.darkModeSplash, () {
                controller.showText_13();
              },
                  controller.show_13 == false
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                  controller.show_13 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : LightMode.splash,
                  controller.show_13,
                  "نعم، يمكنك اختيار خيار \"الاستلام من المتجر\" عند إتمام الطلب لتوفير رسوم التوصيل."),
              questionText(
                  controller.show_14 == false ? 9.h : 15.h,
                  controller.show_14 == false ? null : LightMode.searchField,
                  "كيف يمكنني الحصول على عروض وخصومات؟",
                  controller.show_14 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.splash
                          : DarkMode.darkModeSplash, () {
                controller.showText_14();
              },
                  controller.show_14 == false
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                  controller.show_14 == false
                      ? sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.registerButtonBorder
                          : DarkMode.whiteDarkColor
                      : LightMode.splash,
                  controller.show_14,
                  "تابعنا عبر التطبيق أو على حسابات التواصل الاجتماعي للحصول على آخر العروض والخصومات الحصرية."),
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
            SizedBox(
              width: 80.w,
              child: Text(
                title,
                style: GoogleFonts.tajawal(
                    fontSize: 3.5.w,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
            ),
            SizedBox(
              width: 10.w,
              child: IconButton(
                  onPressed: onPress,
                  icon: Icon(
                    icon,
                    color: colorIcon,
                  )),
            )
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
              S.of(context).faq,
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
