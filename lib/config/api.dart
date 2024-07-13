import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final options = BaseOptions(
  baseUrl: 'http://192.168.1.30:8080/',
  connectTimeout: const Duration(seconds: 6),
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  },
  receiveTimeout: const Duration(seconds: 60),
);

final dio = Dio(options);

class AuthInterceptor {
  static init() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Get.log("REQUEST[${options.method}] => PATH: ${options.path}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          Get.log(
            "RESPONSE[${response.statusCode}] => MESSAGE: ${response.data} | PATH: ${response.requestOptions.path}",
          );
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            Get.offAllNamed("/login");
          }
          Get.log(
            "ERROR[${e.response?.statusCode}] => MESSAGE: ${e.response?.data} | PATH: ${e.requestOptions.path}",
          );
          return handler.next(e);
        },
      ),
    );
  }
}

class APIEndpoints {
  static const String login = "/api/v1/auth/login";
  static const String register = "/api/v1/auth/register";
  static const String me = "/api/v1/users/me";
  static const String subscribers = "/api/v1/subscribers";
  static const String bills = "/api/v1/bills";
  static const String statistics = "/api/v1/statistics";
}
