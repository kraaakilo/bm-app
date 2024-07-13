import 'package:dio/dio.dart';
import 'package:bm_app/config/api.dart';
import 'package:bm_app/models/statistic.dart';
import 'package:bm_app/models/subscriber.dart';
import 'package:bm_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AccountController extends GetxController with StateMixin {
  var subscribers = [].obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
    getStatistics();
    getSubscribers();
  }

  final user = User().obs;
  final statistic = Statistic().obs;

  void getUserData() async {
    try {
      final response = await dio.get(APIEndpoints.me);
      user.value = User.fromJson(response.data);
    } on DioException {
      Get.snackbar(
        "Erreur",
        "Impossible de récupérer les données de l'utilisateur",
      );
    }
  }

  Future<void> getStatistics() async {
    await Future.delayed(const Duration(seconds: 5));
    change(null, status: RxStatus.loading());
    try {
      final response = await dio.get(APIEndpoints.statistics);
      statistic.value = Statistic.fromJson(response.data);
      change(null, status: RxStatus.success());
    } on DioException {
      Get.snackbar(
        "Erreur",
        "Impossible de récupérer les statistiques",
      );
      change(null, status: RxStatus.error());
    }
  }

  Future<bool> addSubscriber(String reference, String provider) async {
    try {
      debugPrint(provider);
      await dio.post(
        APIEndpoints.subscribers,
        data: {"reference": reference, "subscriberType": provider},
      );
      getSubscribers();
      return true;
    } on DioException {
      return false;
    }
  }

  Future<void> getSubscribers() async {
    try {
      final response = await dio.get(APIEndpoints.subscribers);
      subscribers.value = response.data
          .map(
            (subscriber) => Subscriber.fromJson(subscriber),
          )
          .toList();
    } on DioException {
      subscribers.value = [];
    }
  }
}
