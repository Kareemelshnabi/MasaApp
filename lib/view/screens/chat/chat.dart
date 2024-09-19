import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/chat/chat_controller.dart';
import 'package:mas_app/core/class/status_request.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/main.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController controller = Get.put(ChatController());

    return StreamBuilder<List<dynamic>>(
        stream: controller.getChatByIdStream(),
        builder: (context, snapshot) {
          return Scaffold(
            body: GetBuilder<ChatController>(
              builder: (controller) => SingleChildScrollView(
                child: controller.statuesRequest == StatuesRequest.loading
                    ? SizedBox(
                        height: 50.h,
                        width: 100.w,
                        child: const Center(child: CircularProgressIndicator()))
                    : Column(
                        children: [
                          appBarChat(() {
                            Get.back();
                          },
                              controller.nameOfOrder,
                              ImagesLink.noProfileImage,
                              controller.typeIndex == 0
                                  ? () {
                                      controller.chatModel!.merchantAssigned ==
                                              true
                                          ? controller.firstMessage()
                                          : null;
                                    }
                                  : () {},
                              controller.typeIndex == 0
                                  ? LightMode.registerText
                                  : LightMode.blueColor),
                          Container(
                            margin: EdgeInsets.only(bottom: 3.w),
                            height: 75.h,
                            child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                height: 3.w,
                              ),
                              itemCount: controller.messages.length,
                              reverse: true,
                              itemBuilder: (context, index) {
                                print(controller.messages[index].sender);
                                return controller.messages[index].sender !=
                                        "user"
                                    ? chatPartFromMessage(
                                        ImagesLink.noProfileImage,
                                        controller.messages[index].content,
                                        controller.messages[index].type,
                                        controller.messages[index].attachment)
                                    : chatPartToMessage(
                                        controller.imageUser == null ||
                                                controller.imageUser == ""
                                            ? AssetImage(
                                                ImagesLink.noProfileImage)
                                            : CachedNetworkImageProvider(
                                                controller.imageUser!),
                                        controller.chatModel!.messages![index]
                                            .content,
                                        controller.messages[index].type,
                                        controller.messages[index].attachment);
                              },
                            ),
                          ),
                          if (controller.typeIndex == 0)
                            bottomBarChat(controller.messageController,
                                "انقر للكتابة ...", () {
                              controller.getImageFromGallery();
                            }, () {
                              controller.image == null
                                  ? controller.sendMessageText()
                                  : controller.sendMessageFile();
                            }),
                          if (controller.typeIndex == 1)
                            bottmBarChatWithText(" إتمام ", LightMode.btnGreen),
                          if (controller.typeIndex == 2)
                            bottmBarChatWithText(
                                " إلغاء ", LightMode.discountCollor),
                        ],
                      ),
              ),
            ),
          );
        });
  }
}

Widget chatPartToMessage(img, message, type, image) {
  return SizedBox(
    width: 100.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 9.w,
          width: 9.w,
          decoration: BoxDecoration(
            border: Border.all(color: LightMode.splash),
            shape: BoxShape.circle,
            image: DecorationImage(image: img, fit: BoxFit.fill),
            color: sharedPreferences!.getString("img") == null ||
                    sharedPreferences!.getString("img") == "null" ||
                    sharedPreferences!.getString("img") == ""
                ? LightMode.registerButtonBorder
                : null,
          ),
        ),
        Container(
          padding: EdgeInsets.all(3.w),
          width: 40.w,
          decoration: BoxDecoration(
            border: Border.all(color: LightMode.splash),
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: type == "file"
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.fill,
                )
              : Text(
                  maxLines: 5,
                  message,
                  style: GoogleFonts.tajawal(
                      fontSize: 3.w,
                      fontWeight: FontWeight.w600,
                      color: LightMode.registerButtonBorder),
                ),
        ),
      ],
    ),
  );
}

Widget chatPartFromMessage(img, message, type, image) {
  return SizedBox(
    width: 100.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(3.w),
          width: 40.w,
          decoration: BoxDecoration(
            border: Border.all(color: LightMode.splash),
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: type == "file"
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.fill,
                )
              : Text(
                  message,
                  maxLines: 5,
                  style: GoogleFonts.tajawal(
                      fontSize: 3.w,
                      fontWeight: FontWeight.w600,
                      color: LightMode.registerButtonBorder),
                ),
        ),
        SizedBox(
          width: 3.w,
        ),
        Container(
          height: 9.w,
          width: 9.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                ImagesLink.noProfileImage,
              ),
            ),
            color: LightMode.registerButtonBorder,
          ),
        ),
      ],
    ),
  );
}

Widget bottmBarChatWithText(text, color) {
  return Container(
      width: 100.w,
      height: 10.h,
      padding: EdgeInsets.only(right: 5.w, left: 5.w, bottom: 5.w, top: 5.w),
      decoration: BoxDecoration(
        color: LightMode.splash,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7.w), topRight: Radius.circular(7.w)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "تم الانتهاء من هذه المحادثة و ",
            style: GoogleFonts.tajawal(
                fontSize: 3.5.w,
                fontWeight: FontWeight.w600,
                color: LightMode.registerText),
          ),
          Text(
            text,
            style: GoogleFonts.tajawal(
                fontSize: 3.5.w, fontWeight: FontWeight.w600, color: color),
          ),
          Text(
            "طلبك بنجاح",
            style: GoogleFonts.tajawal(
                fontSize: 3.5.w,
                fontWeight: FontWeight.w600,
                color: LightMode.registerText),
          ),
        ],
      ));
}

Widget bottomBarChat(controller, text, onPressFile, onPressSend) {
  return Container(
    width: 100.w,
    height: 10.h,
    padding: EdgeInsets.only(right: 5.w, left: 5.w, bottom: 5.w, top: 5.w),
    decoration: BoxDecoration(
      color: LightMode.splash,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(7.w), topRight: Radius.circular(7.w)),
    ),
    child: Row(
      children: [
        SizedBox(
          height: 10.h,
          width: 70.w,
          child: TextFormField(
            style: GoogleFonts.tajawal(
                color: LightMode.splash,
                fontSize: 3.w,
                fontWeight: FontWeight.w500),
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                bottom: 6.w,
                right: 2.w,
              ),
              filled: true,
              fillColor: LightMode.registerText,
              hintStyle: GoogleFonts.tajawal(
                  color: LightMode.splash,
                  fontSize: 4.w,
                  fontWeight: FontWeight.w500),
              hintText: text,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.w),
                  borderSide: BorderSide.none),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.w),
                  borderSide: BorderSide.none),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.w),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onPressFile,
              icon: Icon(
                Icons.insert_drive_file_outlined,
                color: LightMode.registerText,
                size: 5.w,
              )),
        ),
        SizedBox(
          width: 5.w,
        ),
        SizedBox(
          width: 10.w,
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onPressSend,
              icon: Icon(
                Icons.send_outlined,
                color: LightMode.registerText,
                size: 5.w,
              )),
        ),
      ],
    ),
  );
}

Widget appBarChat(onPress, name, img, onPressText, colorText) {
  return Container(
    width: 100.w,
    height: 15.h,
    padding: EdgeInsets.only(right: 5.w, left: 5.w, bottom: 2.w, top: 7.h),
    decoration: BoxDecoration(
      color: LightMode.splash,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(7.w), bottomRight: Radius.circular(7.w)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 60.w,
          child: Row(
            children: [
              SizedBox(
                width: 7.w,
                child: IconButton(
                    onPressed: onPress,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: LightMode.registerText,
                      size: 6.w,
                    )),
              ),
              SizedBox(
                width: 10.w,
                child: CircleAvatar(
                  backgroundColor: LightMode.splash,
                  maxRadius: 5.w,
                  child: Image.asset(
                    img,
                    color: LightMode.registerButtonBorder,
                    fit: BoxFit.fill,
                    width: 9.w,
                    height: 9.w,
                  ),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                name,
                style: GoogleFonts.tajawal(
                    color: LightMode.registerText,
                    fontSize: 3.5.w,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: onPressText,
          child: Text(
            "خيارات إضافية",
            style: TextStyle(
                color: colorText,
                fontSize: 3.5.w,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: colorText),
          ),
        )
      ],
    ),
  );
}
