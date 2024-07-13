import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class BottomAppBarCustom extends StatelessWidget {
  const BottomAppBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: Get.currentRoute == '/HomeScreen'
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              size: 25,
            ),
            onPressed: () {
              Get.offAndToNamed("/home");
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: Get.currentRoute == '/SubscriberListScreen'
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              size: 25,
            ),
            onPressed: () {
              Get.toNamed("/subscribers-list");
            },
          ),
        ],
      ),
    );
  }
}
