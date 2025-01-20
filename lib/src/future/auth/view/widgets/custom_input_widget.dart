import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';

class CustomInputWidget extends StatelessWidget {
  final String validatorText;
  final TextEditingController textEditingController;

  const CustomInputWidget({super.key, required this.textEditingController, required this.validatorText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },

      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return validatorText;
        }
      },
      // style: TextStyle(color: AppColors.black, fontSize: 16.sp),
      cursorColor: AppColors.c151515,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 12.sp, color: AppColors.cFF1E39),
        contentPadding: REdgeInsets.only(top: 8, bottom: 8, left: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.cE0E0E0),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.c9CBEF6),
          borderRadius: BorderRadius.circular(8.r),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.cE0E0E0),
          borderRadius: BorderRadius.circular(8.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.cFF1E39),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.c9CBEF6),
          borderRadius: BorderRadius.circular(8.r),
        ),
        hintText: "Mohinur Qo'ziboyeva",
        hintStyle: TextStyle(color: AppColors.c5C697A, fontSize: 16.sp),
      ),
    );
  }
}
