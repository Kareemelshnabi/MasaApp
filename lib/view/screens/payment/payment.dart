import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mas_app/controller/payment/payment_controller.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/view/screens/orders/my_order_info.dart';
import 'package:path/path.dart';
import 'package:screen_go/extensions/responsive_nums.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String redirecturl;
  const PaymentWebView({super.key, required this.redirecturl});

  @override
  State<PaymentWebView> createState() => _WebViewState();
}

class _WebViewState extends State<PaymentWebView> {
  late final WebViewController controller;
  int loading = 0;
  @override
  void initState() {
    controller = WebViewController()
      ..loadRequest(Uri.parse(widget.redirecturl == ""
          ? "https://www.google.com/"
          : widget.redirecturl));
    controller
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loading = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loading = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loading = 100;
          });
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        "snakeBar",
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context as BuildContext)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PaymentController paymentController = Get.put(PaymentController());

    return PopScope(
        canPop: false,
        onPopInvoked: (b) async {
          await paymentController.getOrderInfo();

          ///changreeeeeeeeeeee
          Get.offAll(() => const MyOrderInfo(), arguments: {
            "data": paymentController.orderModel!.toJson(),
            "page": "order"
          });
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: LightMode.splash,
            title: TextButton(
                onPressed: () async {
                  print(paymentController.paymentModel!.toJson());
                  await paymentController.getOrderInfo();

                  ///changreeeeeeeeeeee
                  Get.offAll(() => const MyOrderInfo(), arguments: {
                    "data": paymentController.orderModel!.toJson(),
                    "page": "order"
                  });
                },
                child: Text(
                  "إنهاء",
                  style: GoogleFonts.tajawal(
                    color: LightMode.registerText,
                    fontSize: 5.w,
                  ),
                )),
            actions: [
              IconButton(
                  onPressed: () async {
                    final mesanger = ScaffoldMessenger.of(context);
                    if (await controller.canGoBack()) {
                      await controller.goBack();
                    } else {
                      mesanger.showSnackBar(const SnackBar(
                          content: Text("No Back History Found")));
                    }
                    return;
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: LightMode.registerText,
                  )),
              IconButton(
                  onPressed: () async {
                    final mesanger = ScaffoldMessenger.of(context);
                    if (await controller.canGoForward()) {
                      await controller.goForward();
                    } else {
                      mesanger.showSnackBar(const SnackBar(
                          content: Text("No Forward History Found")));
                    }
                    return;
                  },
                  icon: Icon(Icons.arrow_forward_ios,
                      color: LightMode.registerText)),
              IconButton(
                  onPressed: () {
                    controller.reload();
                  },
                  icon: Icon(Icons.replay, color: LightMode.registerText))
            ],
          ),
          body: Stack(
            children: [
              WebViewWidget(controller: controller),
              if (loading < 100)
                LinearProgressIndicator(
                  value: loading / 100.0,
                )
            ],
          ),
        ));
  }
}
