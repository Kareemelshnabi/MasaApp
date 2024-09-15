import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/orders/my_orders_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:mas_app/view/screens/orders/my_order_info.dart';
import 'package:mas_app/view/widget/no_data.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyOrdersController());
    return Scaffold(
      body: GetBuilder<MyOrdersController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              appBarMyOrders(context),
              rowOfTitles(
                  () {
                    controller.changIndex(0);
                  },
                  "الحالية",
                  controller.index == 0
                      ? LightMode.splash
                      : LightMode.registerButtonBorder,
                  () {
                    controller.changIndex(1);
                  },
                  "السابقة",
                  controller.index == 1
                      ? LightMode.splash
                      : LightMode.registerButtonBorder,
                  () {
                    controller.changIndex(2);
                  },
                  "الملغاة",
                  controller.index == 2
                      ? LightMode.splash
                      : LightMode.registerButtonBorder),
              divider(),
              controller.statuesRequest == StatuesRequest.loading
                  ? SizedBox(
                      height: 88.h,
                      width: 100.w,
                      child: const Center(child: CircularProgressIndicator()))
                  : controller.index == 0
                      ? controller.pendingOrdersList.isEmpty
                          ? noData("لا يوجد طلبات بعد")
                          : SizedBox(
                              width: 100.w,
                              height: 79.h,
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 4.w),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Get.to(() => const MyOrderInfo(),
                                        arguments: {
                                          "page":"order",
                                          "type": controller.index,
                                          "data": controller
                                              .pendingOrdersList[index]
                                              .toJson()
                                        });
                                  },
                                  child: cardOrder(
                                      controller
                                                  .pendingOrdersList[index]
                                                  .orderItems![0]
                                                  .item!
                                                  .specification ==
                                              null
                                          ? controller.pendingOrdersList[index]
                                              .orderItems![0].item!.name
                                          : controller
                                              .pendingOrdersList[index]
                                              .orderItems![0]
                                              .item!
                                              .specification!
                                              .title,
                                      "سارية",
                                      LightMode.btnYellow,
                                      controller.pendingOrdersList[index].total,
                                      controller
                                          .pendingOrdersList[index].createdAt),
                                ),
                                itemCount: controller.pendingOrdersList.length,
                                shrinkWrap: true,
                              ),
                            )
                      : controller.index == 1
                          ?controller.completedOrdersList.isEmpty? noData("لا يوجد طلبات "):
                           SizedBox(
                              width: 100.w,
                              height: 79.h,
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 4.w),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                   Get.to(() => const MyOrderInfo(),
                                                arguments: {
                                                  "page":"order",
                                                  "type": controller.index,
                                                  "data": controller
                                                      .canceledOrdersList[index]
                                                      .toJson()
                                                });
                                  },
                                  child: cardOrder(
                                      controller
                                                  .pendingOrdersList[index]
                                                  .orderItems![0]
                                                  .item!
                                                  .specification ==
                                              null
                                          ? controller.pendingOrdersList[index]
                                              .orderItems![0].item!.name
                                          : controller
                                              .pendingOrdersList[index]
                                              .orderItems![0]
                                              .item!
                                              .specification!
                                              .title,
                                      "نم التوصيل",
                                      LightMode.btnGreen,
                                      controller.pendingOrdersList[index].total,
                                      controller
                                          .pendingOrdersList[index].createdAt),
                                ),
                                itemCount: 8,
                                shrinkWrap: true,
                              ),
                            )
                          : controller.index == 2
                              ? controller.canceledOrdersList.isEmpty
                                  ? noData("لا يوجد طلبات ملغاة بعد")
                                  : SizedBox(
                                      width: 100.w,
                                      height: 79.h,
                                      child: ListView.builder(
                                        padding: EdgeInsets.only(top: 4.w),
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () {
                                            Get.to(() => const MyOrderInfo(),
                                                arguments: {
                                                  "page":"order",
                                                  "type": controller.index,
                                                  "data": controller
                                                      .canceledOrdersList[index]
                                                      .toJson()
                                                });
                                          },
                                          child: cardOrder(
                                              controller
                                                          .canceledOrdersList[
                                                              index]
                                                          .orderItems![0]
                                                          .item!
                                                          .specification ==
                                                      null
                                                  ? controller.canceledOrdersList[index].orderItems![0].item!.name
                                                  : controller
                                                      .canceledOrdersList[index]
                                                      .orderItems![0]
                                                      .item!
                                                      .specification!
                                                      .title,
                                              "ملغاة",
                                              LightMode.discountCollor,
                                              controller
                                                  .canceledOrdersList[index]
                                                  .total,
                                              controller
                                                  .canceledOrdersList[index]
                                                  .createdAt),
                                        ),
                                        itemCount: controller
                                            .canceledOrdersList.length,
                                        shrinkWrap: true,
                                      ),
                                    )
                              : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget cardOrder(nameOfItem, status, colorTextStatus, price, date) {
    return Container(
      width: 100.w,
      height: 15.h,
      padding: EdgeInsets.all(5.w),
      margin: EdgeInsets.only(right: 4.w, left: 4.w, bottom: 4.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(color: LightMode.registerButtonBorder, width: 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(nameOfItem,
                  style: GoogleFonts.tajawal(
                      color: LightMode.registerButtonBorder,
                      fontSize: 4.w,
                      fontWeight: FontWeight.bold)),
              Text(status,
                  style: GoogleFonts.tajawal(
                      color: colorTextStatus,
                      fontSize: 3.5.w,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            width: 100.w,
            height: 5.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("إجمالي المبلغ",
                        style: GoogleFonts.tajawal(
                          color: LightMode.registerButtonBorder,
                          fontSize: 3.w,
                          fontWeight: FontWeight.w500,
                        )),
                    Text("$price \$",
                        style: GoogleFonts.tajawal(
                            color: LightMode.registerButtonBorder,
                            fontSize: 3.w,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(
                  width: 7.w,
                ),
                SizedBox(
                    height: 4.h,
                    child: VerticalDivider(
                      color: LightMode.registerButtonBorder,
                      thickness: 1,
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("التاريخ",
                        style: GoogleFonts.tajawal(
                            color: LightMode.registerButtonBorder,
                            fontSize: 3.w,
                            fontWeight: FontWeight.w500)),
                    Text(date,
                        style: GoogleFonts.tajawal(
                            color: LightMode.registerButtonBorder,
                            fontSize: 3.w,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rowOfTitles(onPress1, text1, color1, onPress2, text2, color2, onPress3,
      text3, color3) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.only(top: 3.w, right: 4.w, left: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          textClick(onPress1, text1, color1),
          textClick(onPress2, text2, color2),
          textClick(onPress3, text3, color3)
        ],
      ),
    );
  }

  Widget divider() {
    return Container(
      margin: EdgeInsets.only(right: 4.w, left: 4.w),
      child: Divider(
        thickness: 2,
        color: LightMode.splash,
      ),
    );
  }

  Widget textClick(onPress, text, color) {
    return TextButton(
        onPressed: onPress,
        child: Text(
          text,
          style: GoogleFonts.tajawal(
              color: color, fontSize: 4.w, fontWeight: FontWeight.w500),
        ));
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
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(top: 6.5.h, bottom: 2.h, right: 22.w),
              child: Text(
                "طلباتي",
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
}
