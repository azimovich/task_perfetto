import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_route_names.dart';
import '../../../../core/setting/app_vm.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/custom_body_widget.dart';
import '../../../../core/widgets/custom_main_button_widget.dart';
import '../../../../core/widgets/custom_top_widget.dart';
import '../../vm/register_page_vm.dart';
import '../widgets/custom_input_label_widget.dart';
import '../widgets/custom_input_widget.dart';
import '../widgets/custom_phone_input_widget.dart';
import '../widgets/custom_quation_widget.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterPageVm vm = ref.watch(registerPageVm);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showModalBottomSheet(
    //     context: context,
    //     isDismissible: false, // Yopilmasligi uchun
    //     enableDrag: false, // Drag orqali yopilmasligi uchun
    //     isScrollControlled: true, // To‘liq ekranni egallashi uchun
    //     backgroundColor: Colors.transparent,
    //     builder: (_) => const (),
    //   );
    // });

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: vm.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Logotip faqat o'z joyini egallaydi
              const CustomTopWidget(),

              // Body qismi qolgan joyni egallaydi
              Expanded(
                child: CustomBodyWidget(
                  child: Padding(
                    padding: REdgeInsets.symmetric(horizontal: 16, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title
                        Text(
                          "Ro'yxatdan o'tish",
                          style: TextStyle(
                            color: AppColors.c151515,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        16.verticalSpace,

                        // username and surname input
                        const CustomInputLabelWidget(text: "Ism familiya"),
                        8.verticalSpace,
                        CustomInputWidget(
                          textEditingController: vm.nameC,
                          validatorText: "Ism Familyani to'liq kiriting",
                        ),
                        12.verticalSpace,

                        // phone number input
                        const CustomInputLabelWidget(text: "Telefon raqam"),
                        8.verticalSpace,
                        CustomPhoneInputWidget(
                          textEditingController: vm.phoneC,
                          validatorText: "Telefon raqamni to'liq kiriting!",
                          setFocus: vm.setFocus,
                          isFocused: vm.isPhoneInputFucused,
                        ),
                        28.verticalSpace,

                        CustomQuationWidget(recognizer: vm.recognizer),

                        // register button
                        const Spacer(),
                        CustomMainButtonWidget(
                          text: "Ro'yxatdan o'tish",
                          isLoading: vm.isLoading,
                          onPressed: () async {
                            // Formani tekshirish
                            if (vm.formKey.currentState!.validate()) {
                              final result = await vm.customerRegister();
                              if (result && context.mounted) {
                                context.push("${AppRouteNames.registerPage}/${AppRouteNames.verifyCodePage}", extra: vm.numberFormatter());
                              } else if (context.mounted) {
                                Utils.fireSnackBar(
                                  vm.errorMessage ?? "Ro'yxatdan o'tishda xatolik yuz berdi",
                                  AppColors.cF04438,
                                  context,
                                );
                              }
                            }
                          },
                        ),
                        16.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
