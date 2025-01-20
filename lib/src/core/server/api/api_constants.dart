final class ApiConst {
  const ApiConst._();

  static const Duration connectionTimeout = Duration(minutes: 5);
  static const Duration sendTimeout = Duration(minutes: 5);
  static const Duration receiveTimeout = Duration(minutes: 5);

  static const String baseUrl = "http://45.138.158.239:7868";

  static const String apiCustomerSendVerificationCode = "/api/Customer/send-verification-code";
  static const String apiCustomerSendVerifyCode = "/api/Customer/verify-code";
}

final class ApiParams {
  const ApiParams._();

  static Map<String, dynamic> pageParams({required int page}) => <String, dynamic>{
        "page": page,
      };

  static Map<String, dynamic> emptyParams() => <String, dynamic>{};
}
