import 'package:flutter/material.dart';
import 'package:mas_app/core/constant/colors.dart';

class MyCardPage extends StatelessWidget {
  const MyCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LightMode.registerText,
      child: const Center(
        child: Text("..... Not Yet"),
      ),
    );
  }
}
