import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = "triplea@gmail.com".obs;
  final password = "password!".obs;
  final isLoggingIn = false.obs;

  @override
  void update([List<Object>? ids, bool condition = true]) {
    super.update(ids, condition);
    Get.log("LoginController updated");
  }

  void setIsLoggingIn(bool value) {
    isLoggingIn.value = value;
  }

  void setEmail(String value) {
    email.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  Map<String, String> getLoginData() {
    return {
      "email": email.value,
      "password": password.value,
    };
  }
}
