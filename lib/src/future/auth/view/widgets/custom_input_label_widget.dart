import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';

class CustomInputLabelWidget extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  const CustomInputLabelWidget({super.key, required this.text,  this.fontWeight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: AppColors.c151515, fontSize: 16.sp, fontWeight: fontWeight),
    );
  }
}
