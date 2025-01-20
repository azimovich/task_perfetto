import "app_repository.dart";
import "../../core/server/api/api.dart";
import "../model/response/api_response.dart";
import "../../core/server/api/api_constants.dart";

class AppRepositoryImpl implements AppRepo {
  const AppRepositoryImpl._();

  static final _inner = AppRepositoryImpl._();

  factory AppRepositoryImpl() => _inner;

  /// Customer Register method
  @override
  Future<ApiResponse> costumerRegister({required String phoneNumber}) async {
    try {
      final response = await ApiService.post(ApiConst.apiCustomerSendVerificationCode, {"phoneNumber": phoneNumber});

      return response;
    } catch (e) {
      return ApiResponse(statusCode: 500, data: {"message": "Unexpected error: ${e.toString()}"});
    }
  }

  @override
  Future<ApiResponse> costumerVerifyCode({required String phoneNumber, required String verifyCode}) async {
    try {
      final response = await ApiService.post(ApiConst.apiCustomerSendVerifyCode, {"phoneNumber": phoneNumber, "verifyCode" : verifyCode});

      return response;
    } catch (e) {
      return ApiResponse(statusCode: 500, data: {"message": "Unexpected error: ${e.toString()}"});
    }
  }
}
