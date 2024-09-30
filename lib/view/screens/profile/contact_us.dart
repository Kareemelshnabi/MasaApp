import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/profile/contact_us_controller.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    ContactUsController controller = Get.put(ContactUsController());
    return Scaffold(
      backgroundColor: sharedPreferences!.getBool("darkMode") == false
          ? LightMode.registerText
          : DarkMode.darkModeSplash,
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBarMyOrders(context),
            bodyText(S.of(context).bodyContact),
            cardOfInfo(Icons.phone, S.of(context).phone,
                S.of(context).mobileInfo, "+965 6576 6660", () {
              controller.urlLuncher("phone");
            }, false, null, null, null, null),
            SizedBox(
              height: 5.w,
            ),
            cardOfInfo(Icons.email, S.of(context).email,
                S.of(context).emailInfo, "online.almasyaa@gmail.com", () {
              controller.urlLuncher("gmail");
            }, false, null, null, null, null),
            SizedBox(
              height: 5.w,
            ),
            cardOfInfo(Icons.people, S.of(context).socialMedia,
                S.of(context).socialInfo, "", null, true, () {
              controller.urlLuncher("facebook");
              //facebook
            }, () {
                            controller.urlLuncher("instagram");

              //instegram
            }, () {
                                          controller.urlLuncher("youtup");

              //youtube
            }, () {
                                                        controller.urlLuncher("twitter");

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
              color: sharedPreferences!.getBool("darkMode") == false
                  ? LightMode.registerText
                  : DarkMode.darkModeSplash,
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
              color: sharedPreferences!.getBool("darkMode") == false
                  ? LightMode.registerButtonBorder
                  : DarkMode.whiteDarkColor),
        ),
        SizedBox(
          height: 2.w,
        ),
        Text(
          body,
          style: GoogleFonts.tajawal(
              fontSize: 3.w,
              fontWeight: FontWeight.w400,
              color: sharedPreferences!.getBool("darkMode") == false
                  ? LightMode.registerButtonBorder
                  : DarkMode.whiteDarkColor),
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
                      color: sharedPreferences!.getBool("darkMode") == false
                          ? LightMode.splash
                          : DarkMode.whiteDarkColor),
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
                            color:
                                sharedPreferences!.getBool("darkMode") == false
                                    ? LightMode.registerText
                                    : DarkMode.darkModeSplash,
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
                            color:
                                sharedPreferences!.getBool("darkMode") == false
                                    ? LightMode.registerText
                                    : DarkMode.darkModeSplash,
                            fit: BoxFit.fill,
                          ))),
                  // Container(
                  //     margin: EdgeInsets.only(right: 2.w),
                  //     height: 7.w,
                  //     width: 7.w,
                  //     padding: EdgeInsets.all(1.w),
                  //     decoration: BoxDecoration(
                  //       color: LightMode.splash,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: InkWell(
                  //         onTap: onPressTwitter,
                  //         child: Image.asset(
                  //           ImagesLink.youtubeImage,
                  //           height: 7.w,
                  //           width: 7.w,
                  //           color:
                  //               sharedPreferences!.getBool("darkMode") == false
                  //                   ? LightMode.registerText
                  //                   : DarkMode.darkModeSplash,
                  //           fit: BoxFit.fill,
                  //         ))),
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
                            color:
                                sharedPreferences!.getBool("darkMode") == false
                                    ? LightMode.registerText
                                    : DarkMode.darkModeSplash,
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
          color: sharedPreferences!.getBool("darkMode") == false
              ? LightMode.registerButtonBorder
              : DarkMode.whiteDarkColor),
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
            margin: EdgeInsets.only(top: 6.5.h, bottom: 2.h),
            child: Text(
              S.of(context).contact,
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
