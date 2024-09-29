import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:mas_app/controller/notification/handel_notification.dart';
import 'package:mas_app/firebase_options.dart';

import 'package:mas_app/generated/l10n.dart';
import 'package:mas_app/view/screens/splash_screen.dart';

import 'package:screen_go/screen_go.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    name: "untiteld-13a78",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: false, // Enable in debug mode only
      builder: (context) => const MyApp(), // Your app widget
    ),
  );
  FirebaseNotification().intilizeNotification();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenGo(
      materialApp: true,
      builder: (context, deviceInfo) => GetMaterialApp(
          builder: DevicePreview.appBuilder, // Add this line
          useInheritedMediaQuery: true, // Add this line
          //  useInheritedMediaQuery: true,
          locale: const Locale("ar"),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen()),
    );
  }
}
//https://github.com/firebase/firebase-ios-sdk
