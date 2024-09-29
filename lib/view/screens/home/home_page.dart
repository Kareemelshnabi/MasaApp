import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/home/home_page_controller.dart';
import 'package:mas_app/controller/on_boarding_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/chat/chat.dart';
import 'package:mas_app/view/screens/chat/my_orders_chat.dart';
import 'package:mas_app/view/screens/items/item_info.dart';
import 'package:mas_app/view/screens/other_service_and_catigories/categories.dart';
import 'package:mas_app/view/screens/other_service_and_catigories/other_services.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    Get.put(OnBoardingController());
    return Container(
      height: 100.h,
      color: sharedPreferences!.getBool("darkMode") == false
          ? LightMode.registerText
          : DarkMode.darkModeSplash,
      child: SingleChildScrollView(
        child: GetBuilder<HomePageController>(
          builder: (controller) => Column(
            children: [
              Container(
                height: 22.7.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.w),
                  border: Border(
                      bottom: BorderSide(color: LightMode.splash, width: 2)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    appBarHome(
                      () {
                        sharedPreferences!.getBool("visit") == true
                            ? controller.message(S.of(context).erroGuest)
                            : Get.to(() => const MyOrdersChat());
                      },
                      sharedPreferences!.getBool("visit") == true
                          ? S.of(context).you
                          : sharedPreferences!.getString("nameEn"),
                      sharedPreferences!.getBool("visit") == true
                          ? AssetImage(ImagesLink.noProfileImage)
                          : sharedPreferences!.getString("img") == ""
                              ? AssetImage(
                                  ImagesLink.noProfileImage,
                                )
                              : NetworkImage(
                                  sharedPreferences!.getString("img")!),
                    ),
                    GetBuilder<HomePageController>(
                      builder: (controller) => searchField(
                        controller.searchController,
                        controller.speechToText.isListening
                            ? S.of(context).listenSearch
                            : controller.speechEnabled
                                ? S.of(context).search
                                : S.of(context).errorListenSearch,
                        (val) {
                          controller.checkSearch(val);
                        },
                        () => controller.speechToText.isListening
                            ? controller.stopListening()
                            : controller.startListening(),
                        controller.speechToText.isNotListening
                            ? Icons.mic_off
                            : Icons.mic,
                      ),
                    ),
                  ],
                ),
              ),
              OfflineBuilder(
                connectivityBuilder:
                    (context, ConnectivityResult value, child) {
                  final bool connected = value != ConnectivityResult.none;

                  if (connected) {
                    return controller.isSearch == true
                        ? controller.statuesRequest == StatuesRequest.loading
                            ? SizedBox(
                                height: 88.h,
                                width: 100.w,
                                child: const Center(
                                    child: CircularProgressIndicator()))
                            : controller.searchItems.isEmpty
                                ? Container(
                                    margin: EdgeInsets.only(top: 5.h),
                                    height: 10.h,
                                    width: 60.w,
                                    child: DottedBorder(
                                      dashPattern: const [8, 4],
                                      radius: const Radius.circular(10),
                                      strokeWidth: 1.5,
                                      borderType: BorderType.RRect,
                                      color: LightMode.splash,
                                      child: Center(
                                        child: Text(
                                          S.of(context).noProduct,
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.tajawal(
                                              fontSize: 3.5.w,
                                              fontWeight: FontWeight.bold,
                                              color: LightMode.splash),
                                        ),
                                      ),
                                    ),
                                  )
                                : controller.statuesRequest ==
                                        StatuesRequest.loading
                                    ? SizedBox(
                                        height: 88.h,
                                        width: 100.w,
                                        child: const Center(
                                            child: CircularProgressIndicator()))
                                    : SizedBox(
                                        height: 70.h,
                                        child: ListView.builder(
                                          itemBuilder: (context, index) =>
                                              cardItemSearch(
                                                  () async {
                                                    if (sharedPreferences!
                                                            .getBool("visit") ==
                                                        true) {
                                                      controller.message(S
                                                          .of(context)
                                                          .erroGuest);
                                                    } else {
                                                      controller
                                                          .messageAddressDelivery(
                                                              () async {
                                                        await controller
                                                            .storeOrder(
                                                                controller
                                                                    .searchItems[
                                                                        index]
                                                                    .id,
                                                                "product",
                                                                "1");

                                                        if (controller
                                                                .succsess ==
                                                            true) {
                                                          Get.to(
                                                              () =>
                                                                  const ChatPage(),
                                                              arguments: {
                                                                "chatId": controller
                                                                    .storeOrderModel!
                                                                    .id,
                                                                "imageUser":
                                                                    controller
                                                                        .storeOrderModel!
                                                                        .client!
                                                                        .image,
                                                                "nameOfOrder":
                                                                    controller
                                                                        .storeOrderModel!
                                                                        .name
                                                              });
                                                        }
                                                      });
                                                    }
                                                  },
                                                  controller
                                                      .searchItems[index].price,
                                                  controller.searchItems[index]
                                                      .priceAfterDiscount,
                                                  controller.searchItems[index]
                                                      .description,
                                                  controller
                                                      .searchItems[index].name,
                                                  controller.searchItems[index]
                                                          .images!.isEmpty
                                                      ? Image.asset(
                                                          ImagesLink.noImage,
                                                          width: 15.w,
                                                          height: 15.w,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : CachedNetworkImage(
                                                          imageUrl: controller
                                                              .searchItems[
                                                                  index]
                                                              .images![0],
                                                          width: 15.w,
                                                          height: 15.w,
                                                          fit: BoxFit.fill,
                                                        ),
                                                  () {
                                                    Get.to(
                                                        () => const ItemInfo(),
                                                        arguments: {
                                                          "productInfo":
                                                              controller
                                                                  .searchItems[
                                                                      index]
                                                                  .toJson()
                                                        });
                                                  },
                                                  controller.searchItems[index]
                                                      .rating),
                                          itemCount:
                                              controller.searchItems.length,
                                          padding: EdgeInsets.only(top: 4.w),
                                          shrinkWrap: true,
                                        ),
                                      )
                        : Column(
                            children: [
                              rowTitleHome(),
                              controller.statuesRequest ==
                                      StatuesRequest.loading
                                  ? SizedBox(
                                      height: 88.h,
                                      width: 100.w,
                                      child: const Center(
                                          child: CircularProgressIndicator()))
                                  : SizedBox(
                                      height: 60.h,
                                      child: ListView.builder(
                                        padding: EdgeInsets.only(top: 4.w),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            cardItemHome(() async {
                                          if (controller.services[index]
                                              .categories!.isEmpty) {
                                            if (sharedPreferences!
                                                    .getBool("visit") ==
                                                true) {
                                              controller.message(
                                                  S.of(context).erroGuest);
                                            } else {
                                              controller.messageAddressDelivery(
                                                  () async {
                                                await controller.storeOrder(
                                                    controller
                                                        .services[index].id,
                                                    "service",
                                                    "1");
                                                if (controller.succsess ==
                                                    true) {
                                                  Get.to(() => const ChatPage(),
                                                      arguments: {
                                                        "chatId": controller
                                                            .storeOrderModel!
                                                            .id,
                                                        "imageUser": controller
                                                            .storeOrderModel!
                                                            .client!
                                                            .image,
                                                        "nameOfOrder": controller
                                                            .storeOrderModel!
                                                            .name
                                                      });
                                                }
                                              });
                                            }
                                          } else {
                                            Get.to(() => const CategoriesPage(),
                                                arguments: {
                                                  "categories": controller
                                                      .services[index]
                                                      .categories
                                                });
                                          }
                                        },
                                                controller.services[index].name,
                                                controller.services[index]
                                                    .description,
                                                controller.services[index]
                                                            .image ==
                                                        ""
                                                    ? AssetImage(
                                                        ImagesLink.noImage,
                                                        // color: LightMode.registerText,
                                                      )
                                                    : CachedNetworkImageProvider(
                                                        controller
                                                            .services[index]
                                                            .image!,
                                                      )),
                                        itemCount: controller.services.length,
                                        shrinkWrap: true,
                                      ),
                                    ),
                              controller.services.isEmpty ||
                                      controller.services.length == 1 ||
                                      controller.services.length == 2 ||
                                      controller.services.length == 3 ||
                                      controller.services.length == 4
                                  ? const SizedBox()
                                  : cardItemHome(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const OtherServices(),
                                          ));
                                    },
                                      S.of(context).anotherServices,
                                      S.of(context).anotherServiceDescrip,
                                      AssetImage(
                                        ImagesLink.otherServicesImage,
                                      )),
                            ],
                          );
                  } else {
                    return SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: const Center(
                            child: Text("no internet ............ !")));
                  }
                },
                child: const CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarHome(onPress, name, img) {
    return Container(
      margin: EdgeInsets.only(right: 5.w, left: 5.w, top: 10.w),
      width: 100.w,
      height: 6.h,
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
            child: Center(
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: LightMode.splash)),
                child: CircleAvatar(
                  backgroundImage: img,
                  radius: 4.w,
                ),
              ),
            ),
          ),
          Container(
            margin: sharedPreferences!.getString("local") == "ar"
                ? EdgeInsets.only(right: 4.w)
                : EdgeInsets.only(left: 4.w),
            width: 66.w,
            child: Text(
              "${S.of(Get.context!).hello}، $name",
              textAlign: sharedPreferences!.getString("local") == "ar"
                  ? TextAlign.right
                  : TextAlign.left,
              style: GoogleFonts.tajawal(
                  color: sharedPreferences!.getBool("darkMode") == false
                      ? LightMode.registerButtonBorder
                      : DarkMode.whiteDarkColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 4.2.w),
            ),
          ),
          SizedBox(
              width: 10.w,
              child: Center(
                  child: IconButton(
                      onPressed: onPress,
                      icon: Icon(
                        color: sharedPreferences!.getBool("darkMode") == false
                            ? LightMode.registerButtonBorder
                            : DarkMode.whiteDarkColor,
                        Icons.chat_outlined,
                        size: 6.w,
                      )))),
        ],
      ),
    );
  }

  Widget searchField(controller, text, onChange, onPressVoice, icon) {
    return textField(controller, text, onChange, onPressVoice, icon);
  }

  Widget textField(
      controller, text, Function(String)? onChange, onPressVoice, icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.w, top: 5.w, right: 10.w, left: 10.w),
      width: 80.w,
      height: 5.h,
      child: TextFormField(
        onChanged: onChange,
        controller: controller,
        style: GoogleFonts.tajawal(
            color: sharedPreferences!.getBool("darkMode") == false
                ? LightMode.registerButtonBorder
                : DarkMode.whiteDarkColor,
            fontSize: 4.w,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 3.w),
          prefixIcon: Icon(
            Icons.search,
            size: 5.w,
            color: sharedPreferences!.getBool("darkMode") == false
                ? LightMode.registerButtonBorder
                : DarkMode.whiteDarkColor,
          ),
          suffixIcon: IconButton(
              onPressed: onPressVoice,
              icon: Icon(
                icon,
                size: 6.w,
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.splash
                    : DarkMode.whiteDarkColor,
              )),
          hintStyle: GoogleFonts.tajawal(
              color: sharedPreferences!.getBool("darkMode") == false
                  ? LightMode.registerButtonBorder
                  : DarkMode.whiteDarkColor,
              fontSize: 4.w,
              fontWeight: FontWeight.w500),
          hintText: text,
          filled: true,
          fillColor: LightMode.searchField,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(2.w)),
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(2.w))),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(2.w)),
          ),
        ),
      ),
    );
  }

  Widget rowTitleHome() {
    return Container(
      margin: EdgeInsets.only(right: 5.w, left: 5.w, top: 2.w),
      width: 100.w,
      height: 5.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(Get.context!).services,
            style: GoogleFonts.tajawal(
              fontWeight: FontWeight.w700,
              fontSize: 5.w,
              color: sharedPreferences!.getBool("darkMode") == false
                  ? LightMode.registerButtonBorder
                  : DarkMode.whiteDarkColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget cardItemHome(onPress, title, body, img) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 100.w,
        height: 12.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(color: LightMode.splash),
        ),
        margin: EdgeInsets.only(
            left: sharedPreferences!.getString("local") == "ar" ? 5.w : 10.w,
            right: sharedPreferences!.getString("local") == "ar" ? 10.w : 5.w,
            bottom: 5.w),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right:
                  sharedPreferences!.getString("local") == "ar" ? -7.w : null,
              left: sharedPreferences!.getString("local") == "ar" ? null : -7.w,
              top: 2.w,
              bottom: 2.w,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: LightMode.splash),
                    image: DecorationImage(image: img, fit: BoxFit.fill),
                    color: LightMode.splash,
                    shape: BoxShape.circle),
                width: 15.w,
                height: 15.w,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  right: sharedPreferences!.getString("local") == "ar"
                      ? 10.w
                      : 2.w,
                  left: sharedPreferences!.getString("local") == "ar"
                      ? 2.w
                      : 10.w,
                  top: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.tajawal(
                        color: LightMode.splash,
                        fontSize: 4.w,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    body,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.tajawal(
                        color: sharedPreferences!.getBool("darkMode") == false
                            ? LightMode.registerButtonBorder
                            : DarkMode.whiteDarkColor,
                        fontSize: 3.w,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget iconStar(color) {
  return Icon(
    Icons.star,
    size: 4.w,
    color: color,
  );
}

Widget cardItemSearch(onTapBuy, priceWithoutDiscount, priceWithDiscount,
    discription, nameOfItem, img, onPress, rating) {
  return InkWell(
    onTap: onPress,
    child: Container(
      height: 18.h,
      width: 100.w,
      margin: EdgeInsets.only(right: 4.w, left: 4.w, bottom: 4.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.w)),
          border: Border.all(color: LightMode.splash, width: 1.5)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(4.w),
            width: 65.w,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      nameOfItem,
                      style: GoogleFonts.tajawal(
                          color: sharedPreferences!.getBool("darkMode") == false
                              ? LightMode.registerButtonBorder
                              : DarkMode.whiteDarkColor,
                          fontSize: 4.w,
                          fontWeight: FontWeight.bold),
                    ),
                    rating == 0
                        ? Row(
                            children: [
                              iconStar(LightMode.registerButtonBorder
                                  .withOpacity(.2)),
                              iconStar(LightMode.registerButtonBorder
                                  .withOpacity(.2)),
                              iconStar(LightMode.registerButtonBorder
                                  .withOpacity(.2)),
                              iconStar(LightMode.registerButtonBorder
                                  .withOpacity(.2)),
                              iconStar(LightMode.registerButtonBorder
                                  .withOpacity(.2)),
                            ],
                          )
                        : rating == 1
                            ? Row(
                                children: [
                                  iconStar(LightMode.registerButtonBorder
                                      .withOpacity(.2)),
                                  iconStar(LightMode.registerButtonBorder
                                      .withOpacity(.2)),
                                  iconStar(LightMode.registerButtonBorder
                                      .withOpacity(.2)),
                                  iconStar(LightMode.registerButtonBorder
                                      .withOpacity(.2)),
                                  iconStar(LightMode.starColor),
                                ],
                              )
                            : rating == 2
                                ? Row(
                                    children: [
                                      iconStar(LightMode.registerButtonBorder
                                          .withOpacity(.2)),
                                      iconStar(LightMode.registerButtonBorder
                                          .withOpacity(.2)),
                                      iconStar(LightMode.registerButtonBorder
                                          .withOpacity(.2)),
                                      iconStar(LightMode.starColor),
                                      iconStar(LightMode.starColor),
                                    ],
                                  )
                                : rating == 3
                                    ? Row(
                                        children: [
                                          iconStar(LightMode
                                              .registerButtonBorder
                                              .withOpacity(.2)),
                                          iconStar(LightMode
                                              .registerButtonBorder
                                              .withOpacity(.2)),
                                          iconStar(LightMode.starColor),
                                          iconStar(LightMode.starColor),
                                          iconStar(LightMode.starColor),
                                        ],
                                      )
                                    : rating == 4
                                        ? Row(
                                            children: [
                                              iconStar(LightMode
                                                  .registerButtonBorder
                                                  .withOpacity(.2)),
                                              iconStar(LightMode.starColor),
                                              iconStar(LightMode.starColor),
                                              iconStar(LightMode.starColor),
                                              iconStar(LightMode.starColor),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              iconStar(LightMode.starColor),
                                              iconStar(LightMode.starColor),
                                              iconStar(LightMode.starColor),
                                              iconStar(LightMode.starColor),
                                              iconStar(LightMode.starColor),
                                            ],
                                          ),
                  ],
                ),
                SizedBox(
                  height: 2.w,
                ),
                SizedBox(
                  width: 65.w,
                  child: Text(
                    discription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: sharedPreferences!.getString("local") == "ar"
                        ? TextAlign.right
                        : TextAlign.left,
                    style: GoogleFonts.tajawal(
                        color: sharedPreferences!.getBool("darkMode") == false
                            ? LightMode.registerButtonBorder
                            : DarkMode.whiteDarkColor,
                        fontSize: 2.5.w,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 2.w,
                ),
                SizedBox(
                  width: 65.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$priceWithoutDiscount دينار",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: LightMode.registerButtonBorder,
                                color: sharedPreferences!.getBool("darkMode") ==
                                        false
                                    ? LightMode.registerButtonBorder
                                    : DarkMode.whiteDarkColor,
                                fontSize: 2.5.w,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 1.w,
                          ),
                          Text(
                            "$priceWithDiscount دينار",
                            style: GoogleFonts.tajawal(
                                color: sharedPreferences!.getBool("darkMode") ==
                                        false
                                    ? LightMode.registerButtonBorder
                                    : DarkMode.whiteDarkColor,
                                fontSize: 2.5.w,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: onTapBuy,
                        child: Container(
                          width: 22.w,
                          height: 5.h,
                          padding: EdgeInsets.only(
                              top: 1.w, bottom: 1.w, left: 3.w, right: 3.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.w),
                              border: Border.all(color: LightMode.splash)),
                          child: Center(
                            child: Text(
                              S.of(Get.context!).buy,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.tajawal(
                                fontSize: 3.w,
                                fontWeight: FontWeight.w500,
                                color: LightMode.splash,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          img
        ],
      ),
    ),
  );
}
