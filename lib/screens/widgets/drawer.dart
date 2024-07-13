import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

Drawer buildAppDrawer({required BuildContext context}) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: const Text(
            'BillManager',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          title: const Text('Accueil'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Déconnexion'),
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove("token");
            Get.offAllNamed("/login");
          },
        ),
      ],
    ),
  );
}
