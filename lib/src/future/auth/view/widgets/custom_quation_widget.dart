import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';

class CustomQuationWidget extends StatelessWidget {
  final TapGestureRecognizer recognizer;
  const CustomQuationWidget({super.key, required this.recognizer});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.black),
        children: [
          TextSpan(text: "Hisobingiz mavjudmi? "),
          TextSpan(
            text: "Kirish",
            style: TextStyle(color: AppColors.c0068E1),
            recognizer: recognizer,
          ),
        ],
      ),
    );
  }
}
