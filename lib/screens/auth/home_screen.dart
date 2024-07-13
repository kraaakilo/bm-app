import 'package:bm_app/controllers/account_controller.dart';
import 'package:bm_app/screens/widgets/circle_painter.dart';
import 'package:bm_app/screens/widgets/bottom_app_bar.dart';
import 'package:bm_app/screens/widgets/drawer.dart';
import 'package:bm_app/screens/widgets/shimmer_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<AccountController> {
  final double _radius = 68;

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildAppDrawer(context: context),
      appBar: AppBar(
        title: controller.obx(
          (state) => Text(
            (controller.user.value.email ?? ""),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          onLoading: const Text("Chargement..."),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: RefreshIndicator(
          onRefresh: controller.getStatistics,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Accueil",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Résumé global du compte"),
                  const SizedBox(
                    height: 48,
                  ),
                  controller.obx(
                    onLoading: const ShimmerHome(),
                    (state) => Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        CustomPaint(
                          painter: CirclePainter(
                            radius: _radius,
                            paidBills: controller.statistic.value.paidBills,
                            unpaidBills: controller.statistic.value.unpaidBills,
                            totalBills: controller.statistic.value.totalBills,
                          ),
                          child: SizedBox(
                            width: _radius * 2,
                            height: _radius * 2,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 24,
                                    width: 24,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                      color: Color(0xFF0AE1A0),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  controller.obx(
                                    (state) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Payé"),
                                        Text(
                                          "${controller.statistic.value.paidBills.toInt()} FCFA",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 24,
                                    width: 24,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  controller.obx(
                                    (state) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("En instance"),
                                        Text(
                                          "${controller.statistic.value.unpaidBills.toInt()} FCFA",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    children: [
                      const Text("Activités récentes"),
                      const Spacer(),
                      Text(
                        "Voir tout",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      const ListTile(
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Color(0xFF0AE1A0),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Payé",
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFFC4C4C4),
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          "FA90909790709",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "330501007911HA",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "67 000 FCFA",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Décembre 2020",
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFFC4C4C4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed("/subscribers-list");
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          child: const Text("Voir les abonnés"),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBarCustom(),
    );
  }
}
