import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/chat/my_orders_chat_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/main.dart';
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
      backgroundColor: sharedPreferences!.getBool("darkMode") == false
          ? LightMode.registerText
          : DarkMode.darkModeSplash,
      body: GetBuilder<MyOrdersChatController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              appBarMyOrders(context),
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
                                    controller
                                        .chats[index].lastMessage!.content,
                                    controller
                                        .chats[index].lastMessage!.createdAt!
                                        .substring(
                                            0,
                                            controller.chats[index].lastMessage!
                                                .createdAt!
                                                .indexOf(" ")),
                                    controller.chats[index].lastMessage!.sender,
                                    controller.chats[index].lastMessage!.type)),
                            itemCount: controller.chats.length,
                            shrinkWrap: true,
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget chat(name, message, date, sender, type) {
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
                    fontSize: 3.5.w,
                    fontWeight: FontWeight.bold,
                    color: sharedPreferences!.getBool("darkMode") == false
                        ? null
                        : DarkMode.whiteDarkColor),
              ),
              if (sender == "user" && type == "text")
                Text(
                  "أنت:$message",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.tajawal(
                      fontSize: 3.w,
                      fontWeight: FontWeight.w500,
                      color: sharedPreferences!.getBool("darkMode") == false
                          ? null
                          : DarkMode.blackColor_1),
                ),
              if (sender == "user" && type == "file")
                Text(
                  "أنت: صورة",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.tajawal(
                    fontSize: 3.w,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (sender == "user" && type == "voice")
                Text(
                  "أنت: رسالة صوتية",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.tajawal(
                    fontSize: 3.w,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (sender != "user" && type == "text")
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.tajawal(
                    fontSize: 3.w,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (sender != "user" && type == "file")
                Text(
                  "صورة",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.tajawal(
                    fontSize: 3.w,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
                      ? null
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
              "طلباتي",
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
