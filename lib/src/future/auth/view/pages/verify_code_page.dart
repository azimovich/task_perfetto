import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import 'package:task_perfetto/src/core/style/app_colors.dart';
import 'package:task_perfetto/src/core/utils/utils.dart';
import 'package:task_perfetto/src/core/widgets/custom_main_button_widget.dart';
import 'package:task_perfetto/src/future/auth/view/widgets/custom_input_label_widget.dart';
import 'package:task_perfetto/src/future/auth/view/widgets/custom_quation_widget.dart';
import 'package:task_perfetto/src/future/auth/vm/verify_code_page_vm.dart';

import '../../../../core/setting/app_vm.dart';
import '../../../../core/widgets/custom_body_widget.dart';
import '../../../../core/widgets/custom_top_widget.dart';

class VerifyCodePage extends ConsumerStatefulWidget {
  final String phoneNumber;

  const VerifyCodePage({required this.phoneNumber, super.key});

  @override
  ConsumerState<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends ConsumerState<VerifyCodePage> {
  @override
  void initState() {
    super.initState();

    ref.read(verifyCodePageVm).startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final VerifyCodePageVm vm = ref.watch(verifyCodePageVm);
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      resizeToAvoidBottomInset: false,
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
                      // Title
                      Text(
                        "Tasdiqlash",
                        style: TextStyle(
                          color: AppColors.c151515,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      16.verticalSpace,

                      // context
                      CustomInputLabelWidget(
                        text: "+998 ${widget.phoneNumber} ga yuborilgan SMS kodni kiriting",
                        fontWeight: FontWeight.w500,
                      ),
                      16.verticalSpace,

                      // verify code input and timer
                      Row(
                        children: [
                          Pinput(
                            length: 5,
                            onChanged: (value) {
                              vm.setInputValue(value);
                            },
                            controller: vm.codeC,
                            forceErrorState: vm.isCodeWrong,
                            defaultPinTheme: PinTheme(
                              width: 44.w,
                              height: 52.w,
                              textStyle: TextStyle(
                                fontSize: 20.sp,
                                color: AppColors.c151515,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: AppColors.cE0E0E0),
                              ),
                            ),
                            errorPinTheme: PinTheme(
                              width: 44.w,
                              height: 52.w,
                              textStyle: TextStyle(
                                fontSize: 20.sp,
                                color: AppColors.c151515,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: AppColors.cF04438),
                              ),
                            ),
                          ),
                          16.horizontalSpace,
                          Text(
                            vm.formatTime(vm.remainingSeconds),
                            style: TextStyle(
                              color: !vm.isCodeWrong ? AppColors.c151515 : AppColors.cF04438,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      if (vm.isCodeWrong)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            10.verticalSpace,
                            Text(
                              vm.validateMessage ?? "Tasdiqlash kodi xato kiritildi!",
                              style: TextStyle(color: AppColors.cF04438, fontWeight: FontWeight.w500, fontSize: 16.sp),
                            ),
                          ],
                        ),

                      // quastion
                      28.verticalSpace,
                      CustomQuationWidget(recognizer: TapGestureRecognizer()),
                      const Spacer(),

                      // resend and verifyCode button
                      CustomMainButtonWidget(
                        text: vm.remainingSeconds > 0 ? "Tasdiqlash" : "Qayta yuborish",
                        isLoading: vm.isLoading,
                        onPressed: vm.remainingSeconds > 0
                            ? () async {
                                // verify code
                                final result = await vm.verifyCodeConsumer(phoneNumber: widget.phoneNumber);

                                // check result
                                if (result && context.mounted) {
                                  Utils.fireSnackBar("Siz ro'yxatdan o'tdingiz", AppColors.c28A745, context);
                                  context.go('/');
                                } else if (context.mounted) {
                                  if (!vm.isCodeWrong) {
                                    Utils.fireSnackBar(
                                        vm.errorMessage ?? "Kodni tekshirishda xatolik yuz berdi", AppColors.cF04438, context);
                                  }
                                }
                              }
                            : () async {
                                // reSend verification code
                                final result = await vm.resendCode(phoneNumber: widget.phoneNumber);

                                // check result
                                if (result && context.mounted) {
                                  Utils.fireSnackBar("Kod qayta jonatildi", AppColors.c28A745, context);
                                } else if (context.mounted) {
                                  Utils.fireSnackBar(
                                      vm.errorMessage ?? "Kodni qayta jo'natishda xatolik yuz berdi", AppColors.cF04438, context);
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
