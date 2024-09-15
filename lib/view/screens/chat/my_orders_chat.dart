import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/chat/my_orders_chat_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/view/screens/chat/chat.dart';
import 'package:mas_app/view/screens/home/home.dart';
import 'package:mas_app/view/widget/no_data.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class MyOrdersChat extends StatelessWidget {
  const MyOrdersChat({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyOrdersChatController());
    return Scaffold(
      body: GetBuilder<MyOrdersChatController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              appBarMyOrders(context),
              // rowOfTitles(
              //     () {
              //       controller.changIndex(0);
              //     },
              //     "الحالية",
              //     controller.index == 0
              //         ? LightMode.splash
              //         : LightMode.registerButtonBorder,
              //     () {
              //       controller.changIndex(1);
              //     },
              //     "السابقة",
              //     controller.index == 1
              //         ? LightMode.splash
              //         : LightMode.registerButtonBorder,
              //     () {
              //       controller.changIndex(2);
              //     },
              //     "الملغاة",
              //     controller.index == 2
              //         ? LightMode.splash
              //         : LightMode.registerButtonBorder),
              // divider(),
              //  if (controller.index == 0)
              controller.statuesRequest == StatuesRequest.loading
                  ? SizedBox(
                      height: 88.h,
                      width: 100.w,
                      child: const Center(child: CircularProgressIndicator()))
                  : controller.chats.isEmpty
                      ? noData("لا يوجد محادثات بعد")
                      : SizedBox(
                          width: 100.w,
                          height: 78.h,
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 4.w),
                            itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Get.to(() => const ChatPage(), arguments: {
                                    "chatId": controller.chats[index].id,
                                    "nameOfOrder": controller.chats[index].name,
                                    "imageUser":
                                        controller.chats[index].client!.image,
                                  });
                                },
                                child: chat(
                                    controller.chats[index].name,
                                    controller.chats[index].lastMessage!
                                                .sender ==
                                            "merchant"
                                        ? controller
                                            .chats[index].lastMessage!.content
                                        : "أنت : ${controller.chats[index].lastMessage!.content}",
                                    controller
                                        .chats[index].lastMessage!.createdAt!
                                        .substring(
                                            0,
                                            controller.chats[index].lastMessage!
                                                .createdAt!
                                                .indexOf(" ")))),
                            itemCount: controller.chats.length,
                            shrinkWrap: true,
                          ),
                        ),
              // if (controller.index == 1)
              //   SizedBox(
              //     width: 100.w,
              //     height: 78.h,
              //     child: ListView.builder(
              //       padding: EdgeInsets.only(top: 4.w),
              //       itemBuilder: (context, index) => InkWell(
              //           onTap: () {
              //             Get.to(() => const ChatPage(),
              //                 arguments: {"type": controller.index});
              //           },
              //           child: chat(
              //               "ختم",
              //               "أنت : مرحبا أريد أن أسأل عن ختم الدول العربية",
              //               "19/7/2024")),
              //       itemCount: 8,
              //       shrinkWrap: true,
              //     ),
              //   ),
              // if (controller.index == 2)
              //   SizedBox(
              //     width: 100.w,
              //     height: 78.h,
              //     child: ListView.builder(
              //       padding: EdgeInsets.only(top: 4.w),
              //       itemBuilder: (context, index) => InkWell(
              //           onTap: () {
              //             Get.to(() => const ChatPage(),
              //                 arguments: {"type": controller.index});
              //           },
              //           child: chat(
              //               "ختم",
              //               "أنت : مرحبا أريد أن أسأل عن ختم الدول العربية",
              //               "19/7/2024")),
              //       itemCount: 8,
              //       shrinkWrap: true,
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget chat(name, message, date) {
  return Container(
    width: 100.w,
    margin: EdgeInsets.only(top: 5.w, right: 5.w, left: 5.w),
    child: Row(
      children: [
        Container(
          height: 12.w,
          width: 12.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: LightMode.splash, width: 2),
              image: DecorationImage(
                  image: AssetImage(
                ImagesLink.noProfileImage,
              )),
              color: LightMode.registerButtonBorder),
        ),
        Container(
          width: 45.w,
          height: 6.h,
          margin: EdgeInsets.only(right: 5.w, left: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: GoogleFonts.tajawal(
                    fontSize: 3.5.w, fontWeight: FontWeight.bold),
              ),
              Text(
                message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.tajawal(
                  fontSize: 3.w,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Text(
          date,
          style:
              GoogleFonts.tajawal(fontSize: 3.w, fontWeight: FontWeight.w500),
        ),
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

Widget rowOfTitles(
    onPress1, text1, color1, onPress2, text2, color2, onPress3, text3, color3) {
  return Container(
    width: 100.w,
    margin: EdgeInsets.only(top: 3.w, right: 4.w, left: 4.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textClick(onPress1, text1, color1),
        textClick(onPress2, text2, color2),
        textClick(onPress3, text3, color3)
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
