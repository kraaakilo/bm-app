import 'package:dio/dio.dart';
import 'package:bm_app/config/api.dart';
import 'package:bm_app/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Connexion",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  Text(
                    'BillManager',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  const Text(
                    'Connectez-vous pour accéder à vos factures d’électricité.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Email"),
                        TextFormField(
                          initialValue: controller.email.value,
                          onChanged: (value) {
                            controller.email.value = value;
                          },
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.isEmail) {
                              return 'Veuillez une adresse email.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'triplea@gmail.com',
                            suffixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(
                          height: 42,
                        ),
                        const Text("Mot de passe"),
                        TextFormField(
                          onChanged: (value) {
                            controller.password.value = value;
                          },
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 8) {
                              return 'Veuillez entrer un mot de passe valide.';
                            }
                            return null;
                          },
                          initialValue: controller.password.value,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: '********',
                            suffixIcon: Icon(Icons.lock),
                          ),
                        ),
                        const SizedBox(
                          height: 42,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: Obx(
                                () => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                  onPressed: controller.isLoggingIn.value
                                      ? null
                                      : _login,
                                  child: Text(
                                    controller.isLoggingIn.value
                                        ? "Connexion..."
                                        : "Se connecter",
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Aucun compte ?",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.offAllNamed("/register");
                              },
                              child: const Text("S'inscrire"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    controller.setIsLoggingIn(true);
    if (!formKey.currentState!.validate()) {
      controller.setIsLoggingIn(false);
      return;
    }
    try {
      var response = await dio.post(
        APIEndpoints.login,
        data: controller.getLoginData(),
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", response.data["token"]);
      dio.options.headers["Authorization"] = "Bearer ${response.data["token"]}";
      Get.offAndToNamed("/home");
    } on DioException catch (e) {
      if (e.response != null) {
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: Colors.black,
            message: "Mauvais identifiants.",
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: Colors.black,
            message: "Oups, une erreur est survenue de notre côté.",
            duration: Duration(seconds: 2),
          ),
        );
      }
    } finally {
      controller.setIsLoggingIn(false);
    }
  }
}
