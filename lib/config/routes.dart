import 'package:bm_app/controllers/bill_controller.dart';
import 'package:bm_app/controllers/login_controller.dart';
import 'package:bm_app/controllers/register_controller.dart';
import 'package:bm_app/screens/auth/bill_list_screen.dart';
import 'package:bm_app/screens/auth/home_screen.dart';
import 'package:bm_app/screens/auth/subscriber_list.dart';
import 'package:bm_app/screens/login_screen.dart';
import 'package:bm_app/screens/register_screen.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

List<GetPage> pages = [
  GetPage(
    name: "/login",
    page: () => LoginScreen(),
    binding: BindingsBuilder(() {
      Get.put(() => LoginController());
    }),
  ),
  GetPage(
    name: "/register",
    page: () => RegisterScreen(),
    transition: Transition.downToUp,
    binding: BindingsBuilder(() {
      Get.lazyPut(() => RegisterController());
    }),
  ),
  GetPage(
    name: "/home",
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: "/subscribers-list",
    page: () => const SubscriberListScreen(),
  ),
  GetPage(
    name: "/bill-list",
    page: () => const BillListScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => BillController());
    }),
  ),
];
