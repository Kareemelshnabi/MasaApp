import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/items/items_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/chat/chat.dart';
import 'package:mas_app/view/screens/items/item_info.dart';
import 'package:mas_app/view/screens/profile/edit_profile.dart';
import 'package:mas_app/view/widget/no_data.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemsController());
    return OfflineBuilder(
      connectivityBuilder: (context, ConnectivityResult value, child) {
        final bool connected = value != ConnectivityResult.none;

        if (connected) {
          return GetBuilder<ItemsController>(
            builder: (controller) => Container(
              height: 100.h,
              color: sharedPreferences!.getBool("darkMode") == false
                  ? LightMode.registerText
                  : DarkMode.darkModeSplash,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    topOfItemesPage(
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
                    controller.isSearch == true
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
                                      color: sharedPreferences!
                                                  .getBool("darkMode") ==
                                              false
                                          ? LightMode.splash
                                          : DarkMode.whiteDarkColor,
                                      child: Center(
                                        child: Text(
                                          S.of(context).noProduct,
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.tajawal(
                                              fontSize: 3.5.w,
                                              fontWeight: FontWeight.bold,
                                              color: sharedPreferences!.getBool(
                                                          "darkMode") ==
                                                      false
                                                  ? LightMode.splash
                                                  : DarkMode.whiteDarkColor),
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
                                        height: 73.h,
                                        child: ListView.builder(
                                          itemBuilder: (context, index) =>
                                              cardItem(
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
                        : controller.statuesRequest == StatuesRequest.loading
                            ? SizedBox(
                                height: 88.h,
                                width: 100.w,
                                child: const Center(
                                    child: CircularProgressIndicator()))
                            : controller.products.isEmpty
                                ? noData(S.of(context).noProduct)
                                : SizedBox(
                                    height: 73.h,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) => cardItem(
                                          () async {
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
                                                        .products[index].id,
                                                    "product",
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
                                          },
                                          controller.products[index].price,
                                          controller.products[index]
                                              .priceAfterDiscount,
                                          controller
                                              .products[index].description,
                                          controller.products[index].name,
                                          controller.products[index].images!
                                                  .isEmpty
                                              ? Image.asset(
                                                  ImagesLink.noImage,
                                                  width: 15.w,
                                                  height: 15.w,
                                                  fit: BoxFit.fill,
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl: controller
                                                      .products[index]
                                                      .images![0],
                                                  width: 15.w,
                                                  height: 15.w,
                                                  fit: BoxFit.fill,
                                                ),
                                          () {
                                            Get.to(() => const ItemInfo(),
                                                arguments: {
                                                  "productInfo": controller
                                                      .products[index]
                                                      .toJson()
                                                });
                                          },
                                          controller.products[index].rating),
                                      itemCount: controller.products.length,
                                      padding: EdgeInsets.only(top: 4.w),
                                      shrinkWrap: true,
                                    ),
                                  ),
                    controller.linkMore == ""
                        ? const SizedBox()
                        : onBtnClick(S.of(context).more, () {
                            controller.getMoreItems();
                          })
                  ],
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
              height: 100.h,
              width: 100.w,
              child: const Center(child: Text("no internet ............ !")));
        }
      },
      child: const CircularProgressIndicator(),
    );
  }

  Widget topOfItemesPage(controller, hintText, onChange, onPress, icon) {
    return Container(
      //  margin: EdgeInsets.only(top: 2.h),
      height: 15.h,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: LightMode.splash, width: 2))),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(right: 4.w, top: 3.h),
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 6.w,
                    color: sharedPreferences!.getBool("darkMode") == false
                        ? LightMode.registerButtonBorder
                        : DarkMode.whiteDarkColor,
                  ))),
          searchField(controller, hintText, onChange, onPress, icon),
        ],
      ),
    );
  }

  Widget searchField(controller, text, onChange, onPress, icon) {
    return textField(controller, text, onChange, onPress, icon);
  }

  Widget textField(controller, text, onChange, onPress, icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.w, top: 5.h, right: 2.w, left: 4.w),
      width: 72.w,
      height: 6.h,
      child: TextFormField(
        onChanged: onChange,
        controller: controller,
        style: GoogleFonts.tajawal(
            color: sharedPreferences!.getBool("darkMode") == false
                ? LightMode.registerButtonBorder
                : DarkMode.whiteDarkColor),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 5.w,
            color: sharedPreferences!.getBool("darkMode") == false
                ? LightMode.registerButtonBorder
                : DarkMode.whiteDarkColor,
          ),
          suffixIcon: IconButton(
              onPressed: onPress,
              icon: Icon(
                icon,
                color: sharedPreferences!.getBool("darkMode") == false
                    ? LightMode.splash
                    : DarkMode.whiteDarkColor,
                size: 5.w,
              )),
          contentPadding: EdgeInsets.only(top: 2.w),
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

  Widget cardItem(onTapBuy, priceWithoutDiscount, priceWithDiscount,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nameOfItem,
                        style: GoogleFonts.tajawal(
                            color:
                                sharedPreferences!.getBool("darkMode") == false
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
                          children: [
                            Text(
                              "$priceWithoutDiscount دينار",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor:
                                      LightMode.registerButtonBorder,
                                  color:
                                      sharedPreferences!.getBool("darkMode") ==
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
                                  color:
                                      sharedPreferences!.getBool("darkMode") ==
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
                            width: 20.w,
                            height: 4.h,
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
                                  fontWeight: FontWeight.w700,
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
}

Widget iconStar(color) {
  return Icon(
    Icons.star,
    size: 4.w,
    color: color,
  );
}
