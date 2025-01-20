import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_route_names.dart';
import '../../../../core/setting/app_vm.dart';
import '../../../../core/setting/setup.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/tools/assets.dart';
import '../../../../core/widgets/custom_body_widget.dart';
import '../../../../core/widgets/custom_main_button_widget.dart';
import '../../../../core/widgets/custom_top_widget.dart';
import '../../vm/choose_language_page_vm.dart';

class ChooseLanguagePage extends ConsumerWidget {
  const ChooseLanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChooseLanguagePageVm vm = ref.watch(chooseLanguagePageVm);
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomTopWidget(),
            Expanded(
              child: CustomBodyWidget(
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      Text(
                        "Tilni tanlang",
                        style: TextStyle(
                          color: AppColors.c151515,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          // fontFamily: FontStyles.SFProMedium.name,
                        ),
                      ),
                      28.verticalSpace,

                      CustomLabguageButtonWidget(
                        iconPath: Assets.enFlagSvg,
                        text: "English",
                        onPressed: () {
                          vm.changeLanguage('en');
                        },
                        border: vm.languageCode == 'en' ? BorderSide(color: AppColors.c0068E1) : BorderSide.none,
                      ),
                      12.verticalSpace,

                      CustomLabguageButtonWidget(
                        iconPath: Assets.ruFlagSvg,
                        text: "Русский",
                        onPressed: () {
                          vm.changeLanguage('ru');
                        },
                        border: vm.languageCode == 'ru' ? BorderSide(color: AppColors.c0068E1) : BorderSide.none,
                      ),
                      12.verticalSpace,
                      CustomLabguageButtonWidget(
                        iconPath: Assets.uzFlagSvg,
                        text: "O'zbek",
                        onPressed: () {
                          vm.changeLanguage('uz');
                        },
                        border: vm.languageCode == 'uz' ? BorderSide(color: AppColors.c0068E1) : BorderSide.none,
                      ),

                      Spacer(),
                      CustomMainButtonWidget(
                        text: "Davom etish",
                        isLoading: false,
                        onPressed: () {
                          if (accessToken == null) {
                            context.go(AppRouteNames.registerPage);
                          } else {
                            context.go('/');
                          }
                        },
                      ),
                      16.verticalSpace,
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomLabguageButtonWidget extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback onPressed;
  final BorderSide border;
  const CustomLabguageButtonWidget({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onPressed,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 56.h,
      elevation: 0,
      highlightElevation: 0,
      onPressed: onPressed,
      color: AppColors.cF3F3F3,
      minWidth: MediaQuery.of(context).size.width,
      padding: REdgeInsets.symmetric(horizontal: 10, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r), side: border),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            height: 32,
            width: 32,
          ),
          10.horizontalSpace,
          Text(
            text,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              // fontFamily: FontStyles.SFProMedium.name,
            ),
          )
        ],
      ),
    );
  }
}
