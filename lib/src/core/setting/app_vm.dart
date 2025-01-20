import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../future/auth/vm/register_page_vm.dart';
import '../../future/auth/vm/verify_code_page_vm.dart';
import '../../future/choose_language/vm/choose_language_page_vm.dart';

final registerPageVm = ChangeNotifierProvider.autoDispose<RegisterPageVm>((ref) {
  return RegisterPageVm();
});

final verifyCodePageVm = ChangeNotifierProvider.autoDispose<VerifyCodePageVm>((ref) {
  return VerifyCodePageVm();
});

final chooseLanguagePageVm = ChangeNotifierProvider.autoDispose<ChooseLanguagePageVm>((ref) {
  return ChooseLanguagePageVm();
});
