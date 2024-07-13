import 'package:bm_app/controllers/bill_controller.dart';
import 'package:bm_app/models/subscriber.dart';
import 'package:bm_app/screens/widgets/bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BillListScreen extends GetView<BillController> {
  const BillListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Scaffold(
        bottomNavigationBar: const BottomAppBarCustom(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Liste des factures',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Trouvez votre facture',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Ici se retrouve la liste des factures relatives à "
                "l’abonné Kraaakilo dans le système."
                "(Cliquez pour télécharger la quittance si elle est payée)",
                style: TextStyle(
                  fontSize: 13.5,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Référence',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.filter_list_outlined),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer une référence';
                  }
                  return null;
                },
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Obx(
                        () => controller.bills.isEmpty
                            ? const Center(
                                child: Text(
                                  'Aucune facture trouvée',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: controller.getBills,
                                child: ListView.builder(
                                  physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics(),
                                  ),
                                  itemCount: controller.bills.length,
                                  itemBuilder: (context, index) {
                                    return _buildSingleListItem(
                                      controller.bills[index],
                                    );
                                  },
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSingleListItem(Bill bill) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            if (!bill.paid!) {
              ScaffoldMessenger.of(Get.context!).showSnackBar(
                SnackBar(
                  content: const Text(
                    "Cette facture n'est pas encore payée",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Theme.of(Get.context!).colorScheme.primary,
                ),
              );
              launchUrl(Uri.parse(
                "https://sbee.service-public.bj/postpaid",
              ));
            } else {
              _handleBillClick(bill.reference!);
            }
          },
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              bill.paid!
                  ? const Icon(
                      Icons.document_scanner,
                      color: Color(0xFF0AE1A0),
                    )
                  : const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
          title: Text(
            bill.reference!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            bill.paid! ? "Quittance disponible" : "Quittance non disponible",
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${bill.amount!.toInt()} FCFA",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                bill.getFormattedDueDate(),
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFFC4C4C4),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 30,
          thickness: 1.2,
        ),
      ],
    );
  }

  Future<void> _handleBillClick(String reference) async {
    Get.snackbar(
      'Facture payée',
      'Cette facture a été payée avec succès.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Theme.of(Get.context!).colorScheme.primary,
      colorText: Colors.white,
    );
  }
}
