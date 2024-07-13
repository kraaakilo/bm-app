import 'package:dio/dio.dart';
import 'package:bm_app/config/api.dart';
import 'package:get/get.dart';

class AuthService {
  static Future<dynamic> authenticate() async {
    try {
      await dio.get(APIEndpoints.me);
      return true;
    } on DioException catch (e) {
      Get.log("Authentification error: ${e.response?.data}");
    }
    return null;
  }
}
