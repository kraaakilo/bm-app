import 'package:get/get.dart';

class RegisterController extends GetxController {
  final email = "triplea@gmail.com".obs;
  final password = "password!".obs;
  final isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  void setEmail(String value) {
    email.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  Map<String, String> getRegisterData() {
    return {
      "email": email.value,
      "password": password.value,
    };
  }
}
