import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../data/repository/app_repository_impl.dart';

class RegisterPageVm extends ChangeNotifier {
  late final TextEditingController phoneC;
  late final TextEditingController nameC;

  bool isLoading = false;
  bool isPhoneInputFucused = false;

  String? errorMessage;
  final formKey = GlobalKey<FormState>();
  final AppRepositoryImpl _appRepositoryImpl = AppRepositoryImpl();

  final recognizer = TapGestureRecognizer();

  RegisterPageVm() {
    initState();
  }

  void initState() {
    phoneC = TextEditingController();
    nameC = TextEditingController();

    recognizer.onTap = () {};
  }

  void setFocus(bool value) {
    isPhoneInputFucused = value;
    notifyListeners();
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  String numberFormatter() {
    return phoneC.text.trim().replaceAll(" ", "");
  }

  Future<bool> customerRegister() async {
    errorMessage = null;
    _setLoading(true);

    try {
      final response = await _appRepositoryImpl.costumerRegister(phoneNumber: phoneC.text.trim());

      // case if status code 200 || 201
      if (response.statusCode == 200 || response.statusCode == 201) {
        errorMessage = null;
        return true;
      }

      // case if status code 400
      else if (response.statusCode == 400) {
        errorMessage = "Sizning xatoyingiz";
        return false;
      }

      // case if status code hieght 400
      else {
        errorMessage = "Biz tomondan qandaydir muammo yuzaga keldi";
        return false;
      }
    } catch (internetConnectionError) {
      log("Internet Connection Error : $internetConnectionError");
      errorMessage = "Iltimos internet sifati yaxshi ekanligini tekshiring";
      return false;
    } finally {
      _setLoading(false);
    }
  }

  @override
  void dispose() {
    phoneC.dispose();
    nameC.dispose();
    super.dispose();
  }
}
