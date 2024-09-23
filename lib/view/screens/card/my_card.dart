import 'package:flutter/material.dart';
import 'package:mas_app/core/constant/colors.dart';
import 'package:mas_app/main.dart';

class MyCardPage extends StatelessWidget {
  const MyCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: sharedPreferences!.getBool("darkMode") == false
          ? LightMode.registerText
          : DarkMode.darkModeSplash,
      child: const Center(
        child: Text("..... Not Yet"),
      ),
    );
  }
}
