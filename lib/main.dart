import 'package:bm_app/config/api.dart';
import 'package:bm_app/config/routes.dart';
import 'package:bm_app/config/theme.dart';
import 'package:bm_app/controllers/account_controller.dart';
import 'package:bm_app/controllers/bill_controller.dart';
import 'package:bm_app/controllers/login_controller.dart';
import 'package:bm_app/controllers/register_controller.dart';
import 'package:bm_app/screens/auth/home_screen.dart';
import 'package:bm_app/screens/login_screen.dart';
import 'package:bm_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  await AuthInterceptor.init();
  runApp(
    GetMaterialApp(
      title: 'BillManager',
      debugShowCheckedModeBanner: false,
      theme: buildThemeData(),
      initialBinding: BindingsBuilder(
        () {
          Get.lazyPut(() => AccountController(), fenix: true);
          Get.lazyPut(() => LoginController(), fenix: true);
          Get.lazyPut(() => RegisterController());
          Get.lazyPut(() => BillController());
        },
      ),
      home: const Application(),
      getPages: pages,
    ),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.authenticate(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
