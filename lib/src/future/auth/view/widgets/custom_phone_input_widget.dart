import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';

import 'package:flutter/services.dart';

import '../../../../core/tools/assets.dart';

class CustomPhoneInputWidget extends StatelessWidget {
  final String validatorText;
  final TextEditingController textEditingController;
  final Function(bool) setFocus;
  final bool isFocused;

  const CustomPhoneInputWidget({
    super.key,
    required this.textEditingController,
    required this.validatorText,
    required this.setFocus,
    required this.isFocused,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onTap: () {
        setFocus(true);
      },
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
        if (textEditingController.text.isEmpty) {
          setFocus(false);
        } else {
          setFocus(true);
        }
      },
      onEditingComplete: () {
        if (textEditingController.text.isEmpty) {
          setFocus(false);
        } else {
          setFocus(true);
        }
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (value!.isNotEmpty && value.length == 12) {
          return null;
        } else {
          return validatorText;
        }
      },
      style: TextStyle(color: AppColors.black, fontSize: 16.sp),
      cursorColor: AppColors.c151515,
      keyboardType: TextInputType.number,
      maxLength: 12,
      inputFormatters: [PhoneNumberInputFormatter()],
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
        errorMaxLines: 1,
        hintText: "(_ _) _ _ _  _ _  _ _",
        hintStyle: TextStyle(color: AppColors.c5C697A, fontSize: 16.sp),
        counterText: "",
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            12.horizontalSpace,
            Image.asset(Assets.uzbFlagImg, width: 24, height: 24),
            10.horizontalSpace,
            Text(
              "+998 ",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: isFocused ? AppColors.black : AppColors.c5C697A,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(' ', ''); // Bo'shliqlarni olib tashlaymiz

    // Agar raqamlar soni 9 tadan ortiq bo'lsa, eski qiymatni qaytaring
    if (text.length > 9) {
      return oldValue;
    }

    // Raqamlarni formatlash
    if (text.length >= 3) {
      text = '${text.substring(0, 2)} ${text.substring(2)}'; // 94 864...
    }
    if (text.length >= 7) {
      text = '${text.substring(0, 6)} ${text.substring(6)}'; // 94 864 24...
    }
    if (text.length >= 10) {
      text = '${text.substring(0, 9)} ${text.substring(9)}'; // 94 864 24 24
    }

    // Kursor pozitsiyasini yangilash
    int selectionIndex = newValue.selection.end;
    selectionIndex += text.length > oldValue.text.length ? 1 : 0;

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: selectionIndex.clamp(0, text.length)),
    );
  }
}
