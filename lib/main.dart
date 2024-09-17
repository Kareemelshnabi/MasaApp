import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
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
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: false, // Enable in debug mode only
      builder: (context) => const MyApp(), // Your app widget
    ),
  );
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
          locale: sharedPreferences!.getString("local") == "ar"
              ? const Locale("ar")
              : sharedPreferences!.getString("local") == "en"
                  ? const Locale("en")
                  : const Locale("ar"),
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
//hello

//hi
// 1
// FirebaseAuth auth = FirebaseAuth.instance;

// await FirebaseAuth.instance.verifyPhoneNumber(
//   phoneNumber: '+44 7123 123 456',
//   verificationCompleted: (PhoneAuthCredential credential) {},
//   verificationFailed: (FirebaseAuthException e) {},
//   codeSent: (String verificationId, int? resendToken) {
//      String smsCode = 'xxxx';

//     // Create a PhoneAuthCredential with the code
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

//     // Sign the user in (or link) with the credential
//     await auth.signInWithCredential(credential);
//   },
//   codeAutoRetrievalTimeout: (String verificationId) {},
// );


  // final FirebaseAuth _auth = FirebaseAuth.instance;
// Future<void> verifyPhoneNumber() async {
//     await _auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       timeout: const Duration(seconds: 60),
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // Auto sign-in
//         await _auth.signInWithCredential(credential);
//         print('User signed in automatically');
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         if (e.code == 'invalid-phone-number') {
//           print('The provided phone number is not valid.');
//         } else {
//           print('Verification failed: ${e.message}');
//         }
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         setState(() {
//           this.verificationId = verificationId;
//         });
//         print('Code sent to $phoneNumber');
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         this.verificationId = verificationId;
//       },
//     );
//   }

//   // Step 2: Sign in with the verification code
//   Future<void> signInWithPhoneNumber() async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: smsCode,
//       );
//       await _auth.signInWithCredential(credential);
//       print('User signed in with phone number');
//     } catch (e) {
//       print('Failed to sign in: $e');
//     }
//   }
// }