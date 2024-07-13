import 'package:bm_app/config/theme.dart';
import 'package:bm_app/controllers/account_controller.dart';
import 'package:bm_app/models/subscriber.dart';
import 'package:bm_app/screens/widgets/bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriberListScreen extends StatefulWidget {
  const SubscriberListScreen({super.key});

  @override
  State<SubscriberListScreen> createState() => _SubscriberListScreenState();
}

class _SubscriberListScreenState extends State<SubscriberListScreen> {
  final TextEditingController _referenceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Scaffold(
          bottomNavigationBar: const BottomAppBarCustom(),
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Liste des abonnés',
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
              children: <Widget>[
                const Text(
                  'Informations sur les abonnés de votre au compte',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            context: context,
                            builder: (builder) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(
                                      thickness: 4,
                                      indent: 150,
                                      endIndent: 150,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Filtrer les résultats",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Row(
                                      children: [
                                        Text(
                                          "Toutes les factures",
                                        ),
                                        Spacer(),
                                        Checkbox(value: false, onChanged: null)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 48,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                          ),
                                        ),
                                        child: const Text(
                                          "Appliquer les filtres",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Annuler",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: const Icon(
                          Icons.filter_list_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Rechercher",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFFC4C4C4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ].reversed.toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(
                          () => accountController.subscribers.isEmpty
                              ? const Center(
                                  child: Text(
                                    'Aucun abonné n\'a été ajouté',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                )
                              : RefreshIndicator(
                                  onRefresh: accountController.getSubscribers,
                                  child: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics(),
                                    ),
                                    itemCount:
                                        accountController.subscribers.length,
                                    itemBuilder: (context, index) {
                                      return _buildSingleListItem(
                                        accountController.subscribers[index],
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: () => _openModalBottomSheet(context),
                          child: const Text(
                            'Ajouter un abonné',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _addSubscriber(StateSetter setState, String provider) async {
    if (_formKey.currentState!.validate()) {
      if (await accountController.addSubscriber(
          _referenceController.text, provider)) {
        Get.snackbar(
          'Succès',
          'Abonné ajouté avec succès',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: buildThemeData().colorScheme.primary,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Erreur',
          'Impossible d\'ajouter l\'abonné',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    }
  }

  void _openModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      thickness: 4,
                      indent: 120,
                      endIndent: 120,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _referenceController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 13) {
                          return "Veuillez entrer un numéro de compte valide.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Numéro de compte',
                        hintText: 'XXXXXXXXXXXXXHA',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              _addSubscriber(setState, "electricity"),
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.red),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child: const Text("SBEE"),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          onPressed: () => _addSubscriber(setState, "water"),
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.blue),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child: const Text("SONEB"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildSingleListItem(Subscriber subscriber) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Get.toNamed(
              '/bill-list',
              arguments: subscriber,
            );
          },
          leading: subscriber.provider! == "water"
              ? Image.asset("assets/images/soneb.png")
              : Image.asset("assets/images/sbee.png"),
          title: Text(subscriber.name!),
          subtitle: Text(subscriber.reference!),
        ),
        const Divider(
          height: 30,
          thickness: 1.2,
        ),
      ],
    );
  }
}
