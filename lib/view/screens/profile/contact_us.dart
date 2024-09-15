import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBarMyOrders(context),
            bodyText(
                "إذا كان لديك أي استفسار، تواصل معنا. سنكون سعداء بمساعدتك."),
            cardOfInfo(
                Icons.phone,
                "رقم الهاتف",
                "يمكنك الاتصال بنا أو إرسال رسالة نصية أو واتساب إلينا على الأرقام أدناه، وسيتم تطبيق الرسوم وفقًا لمزودي الشبكة لديك.",
                "+20 0100 310 5824",
                () {},
                false,
                null,
                null,
                null,
                null),
            SizedBox(
              height: 5.w,
            ),
            cardOfInfo(
                Icons.email,
                "البريد الإلكتروني",
                "نرد على رسائل البريد الإلكتروني خلال 24 ساعة.",
                "nabilgehad13@gmail.com",
                () {},
                false,
                null,
                null,
                null,
                null),
            SizedBox(
              height: 5.w,
            ),
            cardOfInfo(
                Icons.people,
                "مواقع التواصل",
                "تابعنا على مواقع التواصل الاجتماعي الخاصة بنا للحصول على إشعارات بالتحديثات والعروض المثيرة.",
                "",
                null,
                true, () {
              //facebook
            }, () {
              //instegram
            }, () {
              //youtube
            }, () {
              //twitter
            }),
          ],
        ),
      ),
    );
  }
}

Widget cardOfInfo(icon, title, body, textOnPress, onPress, icons,
    onPressFaceBook, onPressInstegram, onPressYoutube, onPressTwitter) {
  return Container(
    padding: EdgeInsets.all(4.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(3.w),
      color: LightMode.searchField,
    ),
    width: 100.w,
    height: 27.8.h,
    margin: EdgeInsets.only(bottom: 3.w, right: 4.w, left: 4.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 9.w,
            height: 9.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w),
                color: LightMode.splash),
            child: Icon(
              icon,
              color: LightMode.registerText,
              size: 7.w,
            )),
        SizedBox(
          height: 2.w,
        ),
        Text(
          title,
          style: GoogleFonts.tajawal(
            fontSize: 3.5.w,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 2.w,
        ),
        Text(
          body,
          style: GoogleFonts.tajawal(
            fontSize: 3.w,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 2.w,
        ),
        icons == false
            ? TextButton(
                onPressed: onPress,
                child: Text(
                  textDirection: TextDirection.ltr,
                  textOnPress,
                  style: GoogleFonts.tajawal(
                      fontSize: 3.5.w,
                      fontWeight: FontWeight.w700,
                      color: LightMode.splash),
                ))
            : Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 2.w),
                      height: 7.w,
                      width: 7.w,
                      decoration: BoxDecoration(
                        color: LightMode.splash,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: onPressFaceBook,
                          icon: Icon(
                            Icons.facebook,
                            color: LightMode.registerText,
                            size: 6.w,
                          ))),
                  Container(
                      margin: EdgeInsets.only(right: 2.w),
                      height: 7.w,
                      width: 7.w,
                      padding: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        color: LightMode.splash,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                          onTap: onPressTwitter,
                          child: Image.asset(
                            ImagesLink.instegramImage,
                            height: 7.w,
                            width: 7.w,
                            fit: BoxFit.fill,
                          ))),
                  Container(
                      margin: EdgeInsets.only(right: 2.w),
                      height: 7.w,
                      width: 7.w,
                      padding: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        color: LightMode.splash,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                          onTap: onPressTwitter,
                          child: Image.asset(
                            ImagesLink.youtubeImage,
                            height: 7.w,
                            width: 7.w,
                            fit: BoxFit.fill,
                          ))),
                  Container(
                      margin: EdgeInsets.only(right: 2.w),
                      height: 7.w,
                      width: 7.w,
                      padding: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        color: LightMode.splash,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                          onTap: onPressTwitter,
                          child: Image.asset(
                            ImagesLink.twitterImage,
                            height: 7.w,
                            width: 7.w,
                            fit: BoxFit.fill,
                          )))
                ],
              ),
      ],
    ),
  );
}

Widget bodyText(text) {
  return SizedBox(
    width: 100.w,
    height: 7.h,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.tajawal(
        fontSize: 3.5.w,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget appBarMyOrders(context) {
  return SizedBox(
    width: 100.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(top: 7.w),
            child: IconButton(
                onPressed: () {
                  Navigator.canPop(context)
                      ? Get.back()
                      : Get.off(() => const Home());
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.only(top: 6.5.h, bottom: 2.h, right: 22.w),
            child: Text(
              "تواصل معنا",
              style: GoogleFonts.tajawal(
                fontSize: 5.w,
                fontWeight: FontWeight.bold,
                color: LightMode.typeUserTitle,
              ),
            ),
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    ),
  );
}
