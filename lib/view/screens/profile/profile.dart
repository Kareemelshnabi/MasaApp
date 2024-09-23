import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/on_boarding_controller.dart';
import 'package:mas_app/controller/profile/profile_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/orders/my_orders.dart';
import 'package:mas_app/view/screens/profile/chooseLunguage.dart';
import 'package:mas_app/view/screens/profile/contact_us.dart';
import 'package:mas_app/view/screens/profile/edit_profile.dart';
import 'package:mas_app/view/screens/profile/info_about_us.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    OnBoardingController onBoardingController = Get.put(OnBoardingController());
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
          backgroundColor: sharedPreferences!.getBool("darkMode") == false
              ? LightMode.splash
              : DarkMode.darkModeSplash,
          body: OfflineBuilder(
            connectivityBuilder: (context, ConnectivityResult value, child) {
              final bool connected = value != ConnectivityResult.none;

              if (connected) {
                return GetBuilder<ProfileController>(
                  builder: (controller) => controller.statuesRequest ==
                          StatuesRequest.loading
                      ? SizedBox(
                          width: 100.w,
                          height: 100.h,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SingleChildScrollView(
                          child: SizedBox(
                            height: 92.h,
                            width: 100.w,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                    top: 10.5.h,
                                    bottom: 70.h,
                                    right: 4.w,
                                    child: topOfProfile(
                                        sharedPreferences!.getBool("visit") ==
                                                true
                                            ? AssetImage(
                                                ImagesLink.noProfileImage)
                                            : sharedPreferences!
                                                        .getString("img") ==
                                                    ""
                                                ? AssetImage(
                                                    ImagesLink.noProfileImage,
                                                  )
                                                : NetworkImage(
                                                    sharedPreferences!
                                                        .getString("img")!),
                                        sharedPreferences!.getBool("visit") ==
                                                true
                                            ? ""
                                            : sharedPreferences!
                                                .getString("nameEn"),
                                        sharedPreferences!.getBool("visit") ==
                                                true
                                            ? ""
                                            : sharedPreferences!
                                                .getString("email"))),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Positioned(
                                  bottom: 0,
                                  top: 27.h,
                                  child:
                                      bodyOfProfile(controller.darkMode, (val) {
                                    controller.changeToDark(val);
                                    print(
                                        sharedPreferences!.getBool("darkMode"));
                                  }, () {
                                    //logout
                                    sharedPreferences!.getBool("visit") == true
                                        ? onBoardingController.message(
                                            "الرجاء تسجيل الدخول أو إنشاء الحساب لإستكمال الإجراء")
                                        : controller.showBottomSheet(context);
                                  }, () {
                                    if (sharedPreferences!.getBool("visit") ==
                                        true) {
                                      onBoardingController.message(
                                          "الرجاء تسجيل الدخول أو إنشاء الحساب لإستكمال الإجراء");
                                    } else {
                                      controller.englishNameController.text =
                                          sharedPreferences!
                                              .getString("nameEn")!;
                                      controller.emailController.text =
                                          sharedPreferences!
                                              .getString("email")!;
                                      controller.phoneController.text =
                                          sharedPreferences!
                                              .getString("phone")!;
                                      controller.imagerequest =
                                          sharedPreferences!.getString("img")!;
                                      controller.addressController.text =
                                          sharedPreferences!
                                              .getString("address")!;
                                      controller.countryController.text =
                                          sharedPreferences!
                                              .getString("country")!;
                                      controller.governorateController.text =
                                          sharedPreferences!
                                              .getString("governorate")!;

                                      Get.to(() => const EditProfile());
                                    }

                                    //profile
                                  }, () {
                                    Get.to(() => const ContactUs());
                                    //communication
                                  }, () {
                                    Get.to(() => const InfoAboutUs());
                                    //info
                                  }, () {
                                    Get.to(() => const ChooseLunguage());
                                    //launguage
                                  }),
                                ),
                                Positioned(
                                    top: 22.h,
                                    right: 25.w,
                                    left: 25.w,
                                    child: box(() {
                                      // my orders
                                      Get.to(() => const MyOrders());
                                    })),
                              ],
                            ),
                          ),
                        ),
                );
              } else {
                return SizedBox(
                    height: 100.h,
                    width: 100.w,
                    child: const Center(
                        child: Text("no internet ............ !")));
              }
            },
            child: CircularProgressIndicator(
              color: LightMode.registerText,
            ),
          )),
    );
  }

  Widget box(onPress) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 50.w,
        height: 9.h,
        decoration: BoxDecoration(
            color: sharedPreferences!.getBool("darkMode") == false
                ? LightMode.registerText
                : DarkMode.darkModeSplash,
            border: sharedPreferences!.getBool("darkMode") == false
                ? Border(
                    bottom: BorderSide(
                        color: LightMode.registerButtonBorder.withOpacity(.2)),
                    right: BorderSide(
                        color: LightMode.registerButtonBorder.withOpacity(.2)))
                : Border.all(color: DarkMode.buttonDarkColor),
            borderRadius: BorderRadius.circular(5.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: onPress,
              child: Container(
                margin: EdgeInsets.only(top: 2.w, bottom: 2.w),
                child: Row(
                  children: [
                    Text(
                      "طلباتي",
                      style: GoogleFonts.tajawal(
                          color: sharedPreferences!.getBool("darkMode") == false
                              ? LightMode.registerButtonBorder
                              : DarkMode.whiteDarkColor,
                          fontSize: 5.w,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: LightMode.splash,
                      size: 8.w,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget fieldProfile(onPress, title, icon) {
    return Container(
      height: 5.h,
      width: 90.w,
      margin: EdgeInsets.only(right: 4.w, left: 4.w, top: 3.w),
      decoration: BoxDecoration(
          color: sharedPreferences!.getBool("darkMode") == false
              ? null
              : DarkMode.white_2DarkColor,
          borderRadius: BorderRadius.all(Radius.circular(7.w)),
          border: sharedPreferences!.getBool("darkMode") == true
              ? null
              : Border(
                  right: BorderSide(
                      color: LightMode.registerButtonBorder.withOpacity(.2),
                      width: 2),
                  bottom: BorderSide(
                      color: LightMode.registerButtonBorder.withOpacity(.2),
                      width: 2))),
      child: sharedPreferences!.getBool("darkMode") == false
          ? ElevatedButton(
              onPressed: onPress,
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: LightMode.splash,
                    size: 5.w,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    title,
                    style: GoogleFonts.tajawal(
                        color: sharedPreferences!.getBool("darkMode") == false
                            ? LightMode.registerButtonBorder
                            : DarkMode.whiteDarkColor,
                        fontSize: 3.5.w,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ))
          : InkWell(
              onTap: onPress,
              child: Padding(
                padding: EdgeInsets.only(right: 5.w, left: 5.w),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: LightMode.splash,
                      size: 5.w,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      title,
                      style: GoogleFonts.tajawal(
                          color: sharedPreferences!.getBool("darkMode") == false
                              ? LightMode.registerButtonBorder
                              : DarkMode.whiteDarkColor,
                          fontSize: 3.5.w,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget darkFieldProfile(
      onPress, title, icon, Function(bool) onChange, bool value) {
    return Container(
      height: 5.h,
      width: 90.w,
      margin: EdgeInsets.only(right: 4.w, left: 4.w, top: 3.w),
      decoration: BoxDecoration(
          color: sharedPreferences!.getBool("darkMode") == false
              ? null
              : DarkMode.white_2DarkColor,
          borderRadius: BorderRadius.all(Radius.circular(7.w)),
          border: sharedPreferences!.getBool("darkMode") == true
              ? null
              : Border(
                  right: BorderSide(
                      color: LightMode.registerButtonBorder.withOpacity(.2),
                      width: 2),
                  bottom: BorderSide(
                      color: LightMode.registerButtonBorder.withOpacity(.2),
                      width: 2))),
      child: sharedPreferences!.getBool("darkMode") == false
          ? ElevatedButton(
              onPressed: onPress,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        icon,
                        color: LightMode.splash,
                        size: 5.w,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        title,
                        style: GoogleFonts.tajawal(
                            color:
                                sharedPreferences!.getBool("darkMode") == false
                                    ? LightMode.registerButtonBorder
                                    : DarkMode.whiteDarkColor,
                            fontSize: 3.5.w,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Switch(
                      activeColor: LightMode.registerText,
                      activeTrackColor: LightMode.splash,
                      inactiveTrackColor: LightMode.splash.withOpacity(.1),
                      inactiveThumbColor: LightMode.registerText,
                      value: value,
                      onChanged: onChange)
                ],
              ))
          : InkWell(
              onTap: onPress,
              child: Padding(
                padding: EdgeInsets.only(right: 5.w, left: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          icon,
                          color: LightMode.splash,
                          size: 5.w,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          title,
                          style: GoogleFonts.tajawal(
                              color: sharedPreferences!.getBool("darkMode") ==
                                      false
                                  ? LightMode.registerButtonBorder
                                  : DarkMode.whiteDarkColor,
                              fontSize: 3.5.w,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Switch(
                        activeColor: LightMode.registerText,
                        activeTrackColor: LightMode.splash,
                        inactiveTrackColor: LightMode.splash.withOpacity(.1),
                        inactiveThumbColor: LightMode.registerText,
                        value: value,
                        onChanged: onChange)
                  ],
                ),
              ),
            ),
    );
  }

  Widget titleField(text) {
    return Container(
      margin: EdgeInsets.only(right: 4.w, top: 4.w, bottom: 1.w),
      child: Text(
        text,
        style: GoogleFonts.tajawal(
            color: sharedPreferences!.getBool("darkMode") == false
                ? LightMode.registerButtonBorder
                : DarkMode.whiteDarkColor,
            fontSize: 3.5.w,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget bodyOfProfile(value, onPressDark, logOut, onPressProfile,
      onPressCommunication, onPressInfo, onPressLang) {
    return Container(
      width: 100.w,
      height: 72.h,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: sharedPreferences!.getBool("darkMode") == false
                      ? LightMode.registerText
                      : DarkMode.buttonDarkColor)),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7.w), topRight: Radius.circular(7.w)),
          color: sharedPreferences!.getBool("darkMode") == false
              ? LightMode.registerText
              : DarkMode.darkModeSplash),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.w,
          ),
          fieldProfile(onPressProfile, "بيانات حسابي", Icons.person_3_outlined),
          titleField(
            "الدعم",
          ),
          fieldProfile(
              onPressCommunication, "تواصل معنا", Icons.phone_outlined),
          fieldProfile(onPressInfo, "معلومات عنا", Icons.info_outline),
          titleField(
            "الإعدادات",
          ),
          fieldProfile(onPressLang, "اللغة", Icons.language_outlined),
          darkFieldProfile(() {}, "الوضع الليلي", Icons.dark_mode_outlined,
              onPressDark, value),
          fieldProfile(logOut, "تسجيل خروج", Icons.logout_outlined),
        ],
      ),
    );
  }

  Widget topOfProfile(img, name, email) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 6.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: img, fit: BoxFit.fill),
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        SizedBox(
          width: 70.w,
          height: 6.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "أهلا بك , $name",
                textAlign: TextAlign.right,
                style: GoogleFonts.tajawal(
                    color: LightMode.registerText,
                    fontSize: 4.5.w,
                    fontWeight: FontWeight.bold),
              ),
              // SizedBox(
              //   height: 1.w,
              // ),
              Text(
                email ?? "",
                style: GoogleFonts.tajawal(
                    color: LightMode.registerText,
                    fontSize: 3.w,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
