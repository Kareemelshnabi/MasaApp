import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/on_boarding_controller.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/core/constant/images.dart';
import 'package:mas_app/main.dart';
import 'package:mas_app/view/screens/register/main_register.dart';
import 'package:screen_go/extensions/responsive_nums.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingController());

    return Scaffold(
      body: GetBuilder<OnBoardingController>(
        builder: (controller) => Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(controller.x == 0
                      ? onBoard[0]["image"]
                      : onBoard[1]["image"]),
                  fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: LightMode.onBoardOneCircle, shape: BoxShape.circle),
                padding: EdgeInsets.only(right: 2.w, top: .5.w, bottom: .5.w),
                margin: EdgeInsets.only(top: 4.h, right: 5.w),
                child: controller.x == 1
                    ? IconButton(
                        onPressed: () {
                          controller.changOnboard(0);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 6.w,
                          color: LightMode.onBoardOneIcon,
                        ))
                    : null,
              ),
              Container(
                height: 45.h,
                width: 100.w,
                margin: EdgeInsets.only(top: 40.h),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: LightMode.onBoardOneContainer),
                child: Column(
                  children: [
                    controller.x == 0
                        ? Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 7.w, left: 5.w, right: 5.w),
                              child: Text(
                                onBoard[0]["title"],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.tajawal(
                                    color: LightMode.onBoardOneText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 4.w),
                              ),
                            ),
                          )
                        : Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: 3.w, top: 7.w, left: 5.w, right: 5.w),
                              child: Text(
                                onBoard[1]["title"],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.tajawal(
                                    color: LightMode.onBoardOneText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 4.w),
                              ),
                            ),
                          ),
                    controller.x == 0
                        ? Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 5.w, left: 5.w, right: 5.w),
                              child: Text(
                                onBoard[0]["body"],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.tajawal(
                                    color: LightMode.onBoardOneText,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 3.w),
                              ),
                            ),
                          )
                        : Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 5.w, left: 5.w, right: 5.w),
                              child: Text(
                                onBoard[1]["body"],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.tajawal(
                                    color: LightMode.onBoardOneText,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 3.w),
                              ),
                            ),
                          ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        width: 20.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: controller.x == 0
                                ? Border(
                                    bottom: BorderSide(
                                        color: LightMode.onBoardOneCircle,
                                        width: 3),
                                  )
                                : Border.all(
                                    color: LightMode.onBoardOneCircle,
                                    width: 3)),
                        child: InkWell(
                          onTap: () {
                            if (controller.x == 0) {
                              controller.changOnboard(1);
                            } else {
                              sharedPreferences!.setString("local", "ar");
                              sharedPreferences!
                                  .setString("pageStart", "typeOfUser");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainRegister(),
                                  ));
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: LightMode.onBoardOneCircle,
                            child: Icon(
                              Icons.arrow_back_outlined,
                              color: LightMode.onBoardOneIcon,
                              size: 7.w,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List onBoard = [
    {
      "image": ImagesLink.onBoardingOneImage,
      "title":
          "يمكنك الوصول إلى جمهورك والارتقاء بأعمالك من خلال الإعلانات الإستراتيجية.",
      "body":
          "مع فريق الخبراء لدينا، سنقوم بإنشاء حملة تسويقية جذابة وفعالة تصل إلى جمهورك المستهدف وتدفع عملك إلى آفاق جديدة. دعنا نساعدك على الإدلاء ببيان في السوق."
    },
    {
      "image": ImagesLink.onBoardingTwoImage,
      "title":
          "التقط اللحظة، واصنع الذكرى باستخدام التصوير الفوتوغرافي المذهل.",
      "body":
          "سواء كنت بحاجة إلى صور فوتوغرافية أو تغطية للحدث، سيقوم المصورون ذوو الخبرة لدينا بالتقاط لحظاتك الخاصة بأجمل الطرق وأكثرها جاذبية."
    },
  ];
}
