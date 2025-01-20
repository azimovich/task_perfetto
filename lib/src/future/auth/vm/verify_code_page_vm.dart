import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../data/repository/app_repository_impl.dart';

class VerifyCodePageVm extends ChangeNotifier {
  String? errorMessage;
  String? validateMessage;
  bool isLoading = false;
  bool isCodeWrong = false;
  TextEditingController codeC = TextEditingController();

  Timer? _timer;
  int remainingSeconds = 120;
  String verificationCode = "";

  final AppRepositoryImpl _appRepositoryImpl = AppRepositoryImpl();

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setInputValue(String value) {
    verificationCode = value;
    log('Verify Code : $verificationCode');
    isCodeWrong = false;
    validateMessage = null;
    notifyListeners();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        notifyListeners();
      } else {
        isCodeWrong = true;
        timer.cancel();
        notifyListeners();
      }
    });
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  Future<bool> verifyCodeConsumer({required String phoneNumber}) async {
    if (verificationCode.length < 5) {
      validateMessage = "Tasdiqlash kodi noto'g'ri!";
      isCodeWrong = true;
      notifyListeners();
      return false;
    }

    errorMessage = null;
    _setLoading(true);

    try {
      if (remainingSeconds == 0) {
        errorMessage = 'Verifikatsiya uchun eskirdi kodni qayta yuboring';
        return false;
      }
      log(verificationCode);
      final response = await _appRepositoryImpl.costumerVerifyCode(phoneNumber: phoneNumber, verifyCode: verificationCode);

      // case if status code 200 || 201
      if (response.statusCode == 200 || response.statusCode == 201) {
        errorMessage = null;

        return true;
      }

      // case if status code 400
      else if (response.statusCode == 400) {
        validateMessage = "Tasdiqlash kodi xato kiritildi!";
        isCodeWrong = true;
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

  Future<bool> resendCode({required String phoneNumber}) async {
    errorMessage = null;
    _setLoading(true);

    try {
      final response = await _appRepositoryImpl.costumerRegister(phoneNumber: phoneNumber);

      // case if status code 200 || 201
      if (response.statusCode == 200 || response.statusCode == 201) {
        errorMessage = null;
        remainingSeconds = 120;
        isCodeWrong = false;
        codeC.text = "";
        startTimer();
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
    _timer?.cancel();
    codeC.dispose();
    super.dispose();
  }
}
