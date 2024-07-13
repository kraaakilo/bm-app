import 'package:dio/dio.dart' show DioException;
import 'package:bm_app/config/api.dart';
import 'package:bm_app/config/theme.dart';
import 'package:bm_app/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends GetView<RegisterController> {
  RegisterScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                    'Créer un compte',
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
                    'Toutes vos factures d’électricité au même endroit.',
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
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Email"),
                        TextFormField(
                          initialValue: controller.email.value,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.isEmail) {
                              return "Veuillez entrer un email valide";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'johndoe@email.com',
                            suffixIcon: Icon(Icons.email),
                          ),
                          onChanged: (value) {
                            controller.setEmail(value);
                          },
                        ),
                        const SizedBox(
                          height: 42,
                        ),
                        const Text("Mot de passe"),
                        TextFormField(
                          initialValue: controller.password.value,
                          obscureText: true,
                          onChanged: (value) {
                            controller.setPassword(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty || value.length < 8) {
                              return "Veuillez entrer un mot de passe valide";
                            }
                            return null;
                          },
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
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : _register,
                                  child: controller.isLoading.value
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text('Créer un compte'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text("ou plus simplement"),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    side: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/google.png",
                                      width: 20,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text('Continuer avec Google'),
                                  ],
                                ),
                              ),
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
                              "Compte existant ?",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.offAndToNamed("/login");
                              },
                              child: const Text("Se connecter"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      controller.setLoading(true);
      await dio.post(APIEndpoints.register, data: controller.getRegisterData());
      final prefs = SharedPreferences.getInstance();
      prefs.then((value) async {
        Get.snackbar(
          "Succès",
          "Votre compte a été créé avec succès.",
          colorText: Colors.white,
          backgroundColor: buildThemeData().colorScheme.primary,
          duration: const Duration(seconds: 10),
        );
        Get.toNamed("/login");
      });
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          Map<String, dynamic> data = e.response!.data;
          for (var key in data.keys) {
            Get.showSnackbar(
              GetSnackBar(
                backgroundColor: Colors.black,
                message: data[key],
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }
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
      controller.setLoading(false);
    }
  }
}
