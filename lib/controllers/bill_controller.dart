import 'package:bm_app/config/api.dart';
import 'package:bm_app/models/subscriber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillController extends GetxController with StateMixin {
  var bills = [].obs;
  late Subscriber subscriber;

  @override
  void onInit() {
    super.onInit();
    subscriber = Get.arguments as Subscriber;
    getBills();
  }

  Future<void> getBills() async {
    List<Bill> results = [];
    change([], status: RxStatus.loading());
    try {
      var response =
          await dio.get("${APIEndpoints.bills}/${subscriber.reference}");
      // debugPrint(response.data.toString());
      results = [...response.data.map((bill) => Bill.fromJson(bill))];
      bills.assignAll(results);
      change(bills, status: RxStatus.success());
    } catch (e) {
      debugPrint("Error: $e");
      change(bills, status: RxStatus.error(e.toString()));
    }
  }
}
