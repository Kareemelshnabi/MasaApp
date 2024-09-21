import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/items/items_info_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/chat/chat.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class ItemInfo extends StatelessWidget {
  const ItemInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemsInfoController());
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<ItemsInfoController>(
          builder: (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topOfItemesInfoPage(
                controller.searchController,
                controller.speechToText.isListening
                    ? "جاري الاستماع..."
                    : controller.speechEnabled
                        ? "ابحث معنا"
                        : "Speech not available",
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
                          child:
                              const Center(child: CircularProgressIndicator()))
                      : controller.searchItems.isEmpty
                          ? Center(
                              child: Container(
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
                                      "لا يوجد منتجات",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.tajawal(
                                          fontSize: 3.5.w,
                                          fontWeight: FontWeight.bold,
                                          color: LightMode.splash),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : controller.statuesRequest == StatuesRequest.loading
                              ? SizedBox(
                                  height: 88.h,
                                  width: 100.w,
                                  child: const Center(
                                      child: CircularProgressIndicator()))
                              : SizedBox(
                                  height: 73.h,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) => cardItem(
                                        () async {
                                          if (sharedPreferences!
                                                  .getBool("visit") ==
                                              true) {
                                            controller.message(
                                                "الرجاء تسجيل الدخول أو انشاء حساب");
                                          } else {
                                            controller.messageAddressDelivery(
                                                () async {
                                              await controller.storeOrder(
                                                  controller
                                                      .searchItems[index].id,
                                                  "product",
                                                  "1");

                                              if (controller.succsess == true) {
                                                Get.to(() => const ChatPage(),
                                                    arguments: {
                                                      "chatId": controller
                                                          .storeOrderModel!.id,
                                                      "imageUser": controller
                                                          .storeOrderModel!
                                                          .client!
                                                          .image,
                                                      "nameOfOrder": controller
                                                          .storeOrderModel!.name
                                                    });
                                              }
                                            });
                                          }
                                        },
                                        controller.searchItems[index].price,
                                        controller.searchItems[index]
                                            .priceAfterDiscount,
                                        controller
                                            .searchItems[index].description,
                                        controller.searchItems[index].name,
                                        controller.searchItems[index].images!
                                                .isEmpty
                                            ? Image.asset(
                                                ImagesLink.noImage,
                                                width: 15.w,
                                                height: 15.w,
                                                fit: BoxFit.fill,
                                              )
                                            : CachedNetworkImage(
                                                imageUrl: controller
                                                    .searchItems[index]
                                                    .images![0],
                                                width: 15.w,
                                                height: 15.w,
                                                fit: BoxFit.fill,
                                              ),
                                        () {
                                          Get.to(() => const ItemInfo(),
                                              arguments: {
                                                "productInfo": controller
                                                    .searchItems[index]
                                                    .toJson()
                                              });
                                        },
                                        controller.searchItems[index].rating),
                                    itemCount: controller.searchItems.length,
                                    padding: EdgeInsets.only(top: 4.w),
                                    shrinkWrap: true,
                                  ),
                                )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.w,
                        ),
                        bodyInfoItemPage(
                            SizedBox(
                              width: 60.w,
                              height: 30.h,
                              child: controller.index == null
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: controller
                                              .productInfo!.images!.isEmpty
                                          ? 1
                                          : controller
                                              .productInfo!.images!.length,
                                      itemBuilder: (context, index) =>
                                          controller
                                                  .productInfo!.images!.isEmpty
                                              ? Image.asset(
                                                  ImagesLink.noImage,
                                                  width: 60.w,
                                                  height: 30.h,
                                                  fit: BoxFit.fill,
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl: controller
                                                      .productInfo!
                                                      .images![index],
                                                  width: 60.w,
                                                  height: 30.h,
                                                  fit: BoxFit.fill,
                                                ),
                                    )
                                  : controller.img == ""
                                      ? Image.asset(
                                          ImagesLink.noImage,
                                          width: 60.w,
                                          height: 30.h,
                                          fit: BoxFit.fill,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: controller.img!,
                                          width: 60.w,
                                          height: 30.h,
                                          fit: BoxFit.fill,
                                        ),
                            ),
                            controller.productInfo!.brand,
                            controller.productInfo!.description,
                            controller.productInfo!.rating!,
                            controller.productInfo!.rating,
                            controller.productInfo!.ratingCount!),
                        controller.productInfo!.specifications!.isNotEmpty
                            ? Center(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 6.w, left: 6.w),
                                  width: 100.w,
                                  height: 18.5.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: controller
                                        .productInfo!.specifications!.length,
                                    itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          controller.setIndex(
                                              index,
                                              controller.productInfo!
                                                  .specifications![index].image,
                                              controller.productInfo!
                                                  .specifications![index].title,
                                              controller.productInfo!
                                                  .specifications![index].price,
                                              controller
                                                  .productInfo!
                                                  .specifications![index]
                                                  .priceAfterDiscount,
                                              controller
                                                  .productInfo!
                                                  .specifications![index]
                                                  .available);
                                        },
                                        child: cardOfItem(
                                            controller
                                                        .productInfo!
                                                        .specifications![index]
                                                        .image ==
                                                    ""
                                                ? Image.asset(
                                                    ImagesLink.noImage,
                                                    width: 18.w,
                                                    height: 8.h,
                                                    fit: BoxFit.fill,
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl: controller
                                                        .productInfo!
                                                        .specifications![index]
                                                        .image!,
                                                    width: 18.w,
                                                    height: 8.h,
                                                    fit: BoxFit.fill,
                                                  ),
                                            controller.productInfo!
                                                .specifications![index].title,
                                            "${controller.productInfo!.specifications![index].price} دينار كويتي",
                                            controller
                                                        .productInfo!
                                                        .specifications![index]
                                                        .available ==
                                                    0
                                                ? false
                                                : true,
                                            controller.index == index
                                                ? LightMode.splash
                                                : LightMode
                                                    .registerButtonBorder)),
                                  ),
                                ),
                              )
                            : Container(),
                        infoAboutItem(() {
//****************************************** */
                        }, () {
                          //************************************* */
                        },
                            controller.index == null
                                ? controller.productInfo!.priceAfterDiscount
                                : controller.priceAfterdiscount,
                            controller.index == null
                                ? ((controller.productInfo!.discountValue!.toDouble() / double.parse(controller.productInfo!.price!)) *
                                        100)
                                    .roundToDouble()
                                : (((double.parse(controller.price!) - double.parse(controller.priceAfterdiscount!)) /
                                            double.parse(controller.price!)) *
                                        100)
                                    .roundToDouble(),
                            controller.index == null
                                ? controller.productInfo!.price
                                : controller.price,
                            controller.productInfo!.freeDeliveryEndDate == null ||
                                    DateTime.now().isAfter(DateTime.parse(
                                        controller
                                            .productInfo!.freeDeliveryEndDate!))
                                ? ""
                                : "التوصيل مجاني ",
                            controller.productInfo!.freeDeliveryEndDate == null ||
                                    DateTime.now().isAfter(
                                        DateTime.parse(controller.productInfo!.freeDeliveryEndDate!))
                                ? ""
                                : "${controller.productInfo!.freeDeliveryStartDate} , ${controller.productInfo!.freeDeliveryEndDate}",
                            "التوصيل الي ${sharedPreferences!.getString("address")} - ${sharedPreferences!.getString("nameEn")}",
                            controller.index == null ? true : controller.available),
                        listOfQuantity(
                          controller.quantity,
                          controller.quantityList.length,
                          controller.quantityList,
                          (val) {
                            controller.changeQuantity(val);
                          },
                        ),
                        onBtnClick("اشتر الأن", () async {
                          if (controller.quantity != null) {
                            if (sharedPreferences!.getBool("visit") == true) {
                              controller.message(
                                  "الرجاء  تسجيل الدخول أو انشاء حساب");
                            } else {
                              controller.messageAddressDelivery(() async {
                                controller.index == null
                                    ? await controller.storeOrder(
                                        controller.productInfo!.id.toString(),
                                        "product",
                                        controller.quantity.toString())
                                    : controller.storeOrder(
                                        controller
                                            .productInfo!
                                            .specifications![controller.index!]
                                            .id
                                            .toString(),
                                        "product_specifications",
                                        controller.quantity.toString());
                                if (controller.succsess == true) {
                                  Get.to(() => const ChatPage(), arguments: {
                                    "chatId": controller.storeOrderModel!.id,
                                    "imageUser": controller
                                        .storeOrderModel!.client!.image,
                                    "nameOfOrder":
                                        controller.storeOrderModel!.name
                                  });
                                }
                              });
                            }
                          } else {
                            controller.showMessageWarning();
                          }
                        }, LightMode.btnGreen),
                        bottomPage("Mas", "Mas"),
                        divider(.5.w),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 3.w, right: 5.w, bottom: 2.w),
                          child: Text(
                            "التسوق بثقة",
                            style: GoogleFonts.tajawal(
                                fontSize: 3.w,
                                color: LightMode.registerButtonBorder,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w, left: 10.w),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  rowWithIcon(Icons.attach_money_outlined,
                                      "الدفع عند الاستلام"),
                                  rowWithIcon(
                                      Icons.delivery_dining, "تشحن من Mas")
                                ],
                              ),
                              SizedBox(
                                height: 3.w,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  rowWithIcon(Icons.delivery_dining_outlined,
                                      "الشحن مجاني"),
                                  rowWithIcon(Icons.lock, "معاملتك آمنة")
                                ],
                              )
                            ],
                          ),
                        ),
                        divider(.5.w),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 3.w, right: 5.w, bottom: 2.w),
                          child: Text(
                            "تفاصيل المنتج",
                            style: GoogleFonts.tajawal(
                                fontSize: 3.w,
                                color: LightMode.registerButtonBorder,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        divider(.3.w),
                        SizedBox(
                          // height: controller.productInfo!.details!.length > 5
                          //     ? 55.h
                          //     : 30.h,
                          width: 70.w,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.productInfo!.details!.length,
                            itemBuilder: (context, index) => keyValueWidget(
                                controller.productInfo!.details![index].key,
                                controller.productInfo!.details![index].value),
                          ),
                        ),
                        divider(.5.w),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 3.w, right: 5.w, bottom: 2.w),
                          child: Text(
                            "تفاصيل إضافية",
                            style: GoogleFonts.tajawal(
                                fontSize: 3.w,
                                color: LightMode.registerButtonBorder,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        divider(.3.w),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 3.w, right: 5.w, bottom: 2.w, left: 5.w),
                          child: Text(
                            //  "المنتج متوفر بألوان/مطبوعات متنوعة. الألوان/المطبوعات رهن بالتوافر وقد تختلف عن الصور المعروضة.",
                            controller.productInfo!.description!,
                            style: GoogleFonts.tajawal(
                                fontSize: 3.w,
                                color: LightMode.registerButtonBorder,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        divider(.5.w),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 3.w, right: 5.w, bottom: 2.w),
                          child: Text(
                            "مراجعة المستخدمين",
                            style: GoogleFonts.tajawal(
                                fontSize: 3.w,
                                color: LightMode.registerButtonBorder,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        ratingWidget(
                          controller.productInfo!.rating,
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ratingWidget(rating) {
    return Container(
      margin: EdgeInsets.only(right: 5.w, left: 5.w, bottom: 5.w),
      width: 45.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          rating == 0
              ? Row(
                  children: [
                    iconStar(LightMode.registerButtonBorder.withOpacity(.2)),
                    iconStar(LightMode.registerButtonBorder.withOpacity(.2)),
                    iconStar(LightMode.registerButtonBorder.withOpacity(.2)),
                    iconStar(LightMode.registerButtonBorder.withOpacity(.2)),
                    iconStar(LightMode.registerButtonBorder.withOpacity(.2)),
                  ],
                )
              : rating == 1
                  ? Row(
                      children: [
                        iconStar(
                            LightMode.registerButtonBorder.withOpacity(.2)),
                        iconStar(
                            LightMode.registerButtonBorder.withOpacity(.2)),
                        iconStar(
                            LightMode.registerButtonBorder.withOpacity(.2)),
                        iconStar(
                            LightMode.registerButtonBorder.withOpacity(.2)),
                        iconStar(LightMode.starColor),
                      ],
                    )
                  : rating == 2
                      ? Row(
                          children: [
                            iconStar(
                                LightMode.registerButtonBorder.withOpacity(.2)),
                            iconStar(
                                LightMode.registerButtonBorder.withOpacity(.2)),
                            iconStar(
                                LightMode.registerButtonBorder.withOpacity(.2)),
                            iconStar(LightMode.starColor),
                            iconStar(LightMode.starColor),
                          ],
                        )
                      : rating == 3
                          ? Row(
                              children: [
                                iconStar(LightMode.registerButtonBorder
                                    .withOpacity(.2)),
                                iconStar(LightMode.registerButtonBorder
                                    .withOpacity(.2)),
                                iconStar(LightMode.starColor),
                                iconStar(LightMode.starColor),
                                iconStar(LightMode.starColor),
                              ],
                            )
                          : rating == 4
                              ? Row(
                                  children: [
                                    iconStar(LightMode.registerButtonBorder
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
          Padding(
            padding: EdgeInsets.only(top: 1.w, right: 3.w),
            child: Text(
              "$rating من أصل 5 ",
              style:
                  GoogleFonts.tajawal(fontSize: 3.w, color: LightMode.splash),
            ),
          ),
        ],
      ),
    );
  }

  Widget keyValueWidget(key, value) {
    return Container(
      margin: EdgeInsets.only(right: 5.w, top: 3.w),
      width: 60.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: GoogleFonts.tajawal(
                fontSize: 3.5.w,
                color: LightMode.registerButtonBorder,
                fontWeight: FontWeight.w700),
          ),
          Text(
            value,
            style: GoogleFonts.tajawal(
                fontSize: 3.5.w,
                color: LightMode.registerButtonBorder,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget divider(thikness) {
    return Center(
      child: SizedBox(
        width: 90.w,
        child: Divider(
          color: LightMode.registerButtonBorder,
          thickness: thikness,
        ),
      ),
    );
  }

  Widget rowWithIcon(icon, text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 6.w,
          color: LightMode.registerButtonBorder,
        ),
        SizedBox(
          width: 2.w,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 1.w,
          ),
          child: Text(
            text,
            style: GoogleFonts.tajawal(
                fontSize: 3.w,
                color: LightMode.splash,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget cardOfItem(img, color, price, status, colorBorder) {
    return Container(
      margin: EdgeInsets.only(right: 3.w),
      width: 25.w,
      height: 15.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(color: colorBorder, width: 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          img,
          Text(
            color,
            textAlign: TextAlign.center,
            style: GoogleFonts.tajawal(
                fontSize: 3.5.w,
                color: LightMode.registerButtonBorder,
                fontWeight: FontWeight.w700),
          ),
          Text(
            price,
            textAlign: TextAlign.center,
            style: GoogleFonts.tajawal(
                fontSize: 3.w,
                color: LightMode.registerButtonBorder,
                fontWeight: FontWeight.w600),
          ),
          status == true
              ? Text(
                  "متوفر",
                  style: GoogleFonts.tajawal(
                      fontSize: 3.w,
                      color: LightMode.splash,
                      fontWeight: FontWeight.w700),
                )
              : Text(
                  "غير متوفر",
                  style: GoogleFonts.tajawal(
                      fontSize: 3.w,
                      color: LightMode.discountCollor,
                      fontWeight: FontWeight.w700),
                ),
        ],
      ),
    );
  }

  Widget topOfItemesInfoPage(controller, hintText, onChange, onPress, icon) {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
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
                  icon: const Icon(Icons.arrow_back_ios))),
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
      width: 75.w,
      height: 6.h,
      child: TextFormField(
        onChanged: onChange,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 5.w,
          ),
          suffixIcon: IconButton(
              onPressed: onPress,
              icon: Icon(
                icon,
                color: LightMode.splash,
                size: 5.w,
              )),
          contentPadding: EdgeInsets.only(top: 1.w),
          hintStyle: GoogleFonts.tajawal(
              color: LightMode.registerButtonBorder,
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

  Widget bodyInfoItemPage(
      listView, brand, discriptionItem, ratingPrecentage, rating, ratingCount) {
    return Container(
      margin: EdgeInsets.only(right: 4.w, left: 4.w, bottom: 2.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 50.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "العلامة التجارية : $brand",
                      style: GoogleFonts.tajawal(
                          fontSize: 3.5.w,
                          color: LightMode.splash,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      discriptionItem,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.tajawal(
                          fontSize: 2.5.w, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1.w),
                      child: Text(
                        "$ratingPrecentage",
                        style: GoogleFonts.tajawal(
                          fontSize: 3.w,
                        ),
                      ),
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
                    Padding(
                      padding: EdgeInsets.only(top: 1.w),
                      child: Text(
                        "$ratingCount",
                        style: GoogleFonts.tajawal(
                            fontSize: 3.w, color: LightMode.splash),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.w,
          ),
          listView,
          SizedBox(
            height: 5.w,
          ),
        ],
      ),
    );
  }

  Widget iconStar(color) {
    return Icon(
      Icons.star,
      size: 4.w,
      color: color,
    );
  }

  Widget infoAboutItem(
      onPressFav,
      onPressShare,
      priceWithDiscount,
      discountPrecntage,
      priceWithoutDiscount,
      freeDelivery,
      timeOfArrive,
      placeOfArrive,
      status) {
    return Container(
      margin: EdgeInsets.only(right: 4.w, top: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "-$discountPrecntage%",
                    style: GoogleFonts.tajawal(
                        color: LightMode.discountCollor,
                        fontSize: 4.w,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    "$priceWithDiscount دينار كويتي",
                    style: GoogleFonts.tajawal(
                        fontSize: 4.w, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 4.w),
              //   child: Row(
              //     children: [
              //       IconButton(
              //         onPressed: onPressFav,
              //         icon: Icon(
              //           Icons.favorite_border_outlined,
              //           size: 7.w,
              //         ),
              //       ),
              //       SizedBox(
              //         width: 3.w,
              //       ),
              //       IconButton(
              //           onPressed: onPressShare,
              //           icon: Icon(
              //             Icons.ios_share_outlined,
              //             size: 7.w,
              //           ))
              //     ],
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Text(
                "السعر بدون خصم :",
                style: GoogleFonts.tajawal(
                    fontSize: 3.w, fontWeight: FontWeight.w600),
              ),
              Text(
                "$priceWithoutDiscount",
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2,
                    fontSize: 3.w,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 2.w,
          ),
          Text(
            "الاسعار تشمل الضريبة",
            textAlign: TextAlign.right,
            style:
                GoogleFonts.tajawal(fontSize: 3.w, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 2.w,
          ),
          Row(
            children: [
              Text(
                freeDelivery,
                style: GoogleFonts.tajawal(
                    color: LightMode.splash,
                    fontSize: 3.w,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                timeOfArrive,
                style: TextStyle(fontSize: 3.w, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                color: LightMode.splash,
                size: 6.w,
              ),
              Text(
                placeOfArrive,
                style: GoogleFonts.tajawal(
                    color: LightMode.splash,
                    fontSize: 3.w,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(
            height: 1.w,
          ),
          // status == 1
          //     ? Text(
          //         "متوفر",
          //         style: GoogleFonts.tajawal(
          //             color: LightMode.splash,
          //             fontSize: 3.w,
          //             fontWeight: FontWeight.w700),
          //       )
          //     : Text(
          //         "غير متوفر",
          //         style: GoogleFonts.tajawal(
          //             color: LightMode.discountCollor,
          //             fontSize: 3.w,
          //             fontWeight: FontWeight.w700),
          //       ),
        ],
      ),
    );
  }

  Widget listOfQuantity(value, list, listQuantity, onChange) {
    return Container(
      height: 5.h,
      width: 100.w,
      margin: EdgeInsets.only(right: 4.w, left: 4.w, top: 3.w),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(2.w),
        ),
        color: LightMode.searchField,
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            style: GoogleFonts.tajawal(
                fontSize: 3.7.w,
                fontWeight: FontWeight.w500,
                color: LightMode.searchField),
            icon: const Icon(Icons.arrow_drop_down_sharp),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            iconDisabledColor: LightMode.registerButtonBorder,
            iconEnabledColor: LightMode.registerButtonBorder,
            menuMaxHeight: 20.h,
            hint: Text(
              "الكمية",
              textAlign: TextAlign.end,
              textDirection: TextDirection.rtl,
              style: GoogleFonts.tajawal(
                  fontSize: 3.7.w,
                  fontWeight: FontWeight.w500,
                  color: LightMode.registerButtonBorder),
            ),
            value: value,
            dropdownColor: LightMode.registerText,
            items: [
              ...List.generate(
                list,
                (index) => DropdownMenuItem(
                    value: listQuantity[index],
                    child: Text(listQuantity[index],
                        style: GoogleFonts.tajawal(
                            fontSize: 3.7.w,
                            fontWeight: FontWeight.w500,
                            color: LightMode.registerButtonBorder))),
              )
            ],
            onChanged: onChange,
          ),
        ),
      ),
    );
  }

  Widget onBtnClick(text, onPress, color) {
    return Container(
      margin: EdgeInsets.only(top: 2.h, right: 4.w, left: 4.w),
      width: 90.w,
      height: 6.h,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: color),
          onPressed: onPress,
          child: Text(
            text,
            style: GoogleFonts.tajawal(
                color: LightMode.registerButtonBorder,
                fontSize: 4.w,
                fontWeight: FontWeight.w500),
          )),
    );
  }

  Widget bottomPage(text1, text2) {
    return Container(
      margin: EdgeInsets.only(right: 4.w, top: 4.w, bottom: 4.w),
      width: 50.w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "يشحن من ",
                style: GoogleFonts.tajawal(
                    color: LightMode.registerButtonBorder,
                    fontSize: 3.w,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                text1,
                style: GoogleFonts.tajawal(
                    color: LightMode.registerButtonBorder,
                    fontSize: 3.w,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 2.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "يباع من ",
                style: GoogleFonts.tajawal(
                    color: LightMode.registerButtonBorder,
                    fontSize: 3.w,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                text2,
                style: GoogleFonts.tajawal(
                    color: LightMode.registerButtonBorder,
                    fontSize: 3.w,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ],
      ),
    );
  }
}

Widget cardItem(onTapBuy, priceWithoutDiscount, priceWithDiscount, discription,
    nameOfItem, img, onPress, rating) {
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
                          color: LightMode.registerButtonBorder,
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
                Text(
                  discription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.tajawal(
                      color: LightMode.registerButtonBorder,
                      fontSize: 2.5.w,
                      fontWeight: FontWeight.w600),
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
                                decorationColor: LightMode.registerButtonBorder,
                                color: LightMode.registerButtonBorder,
                                fontSize: 2.5.w,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 1.w,
                          ),
                          Text(
                            "$priceWithDiscount دينار",
                            style: GoogleFonts.tajawal(
                                color: LightMode.registerButtonBorder,
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
                              "شراء الأن",
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

Widget iconStar(color) {
  return Icon(
    Icons.star,
    size: 4.w,
    color: color,
  );
}
