import '../model/response/api_response.dart';

abstract class AppRepo {
  // AppRepo._();

  Future<ApiResponse> costumerRegister({required String phoneNumber});

  Future<ApiResponse> costumerVerifyCode({required String phoneNumber, required String verifyCode});
}
