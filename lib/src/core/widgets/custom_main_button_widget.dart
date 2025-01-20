import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/app_colors.dart';

class CustomMainButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  const CustomMainButtonWidget({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50.h,
      elevation: 0,
      highlightElevation: 0,
      enableFeedback: !isLoading,
      color: AppColors.mainColor,
      disabledColor: AppColors.mainColor,
      onPressed: isLoading ? null : onPressed,
      minWidth: MediaQuery.of(context).size.width,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: isLoading
          ? SizedBox(
              width: 24.w,
              height: 24.h,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.5,
              ),
            )
          : Text(
              text,
              style: TextStyle(
                color: AppColors.c151515,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}
