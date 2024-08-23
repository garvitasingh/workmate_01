// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/network/network_controller.dart';
import 'package:workmate_01/utils/constants.dart';

class OfflineView extends StatefulWidget {
  static var isVisible = false;
  const OfflineView({super.key});

  @override
  State<OfflineView> createState() => _OfflineViewState();
}

class _OfflineViewState extends State<OfflineView> {
  final networkController = Get.put(NetworkController(), permanent: true);

  Future<void> _checkConnectivity(BuildContext context) async {
    if (networkController.isOffline.isTrue) {
      constToast("please check your internet connection and try again");
    } else {
      OfflineView.isVisible = false;
      Get.back();
    }
  }

  @override
  void initState() {
    OfflineView.isVisible = true;
    networkController.isOffline.listen((p0) {
      if (!p0) {
        OfflineView.isVisible = false;
        Get.back();
      } else {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/offline.png",
              height: 150,
            ),
            const Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 24.0, color: Colors.red),
            ),
            const SizedBox(
              height: 12,
            ),
            // ignore: prefer_const_constructors
            Text(
              "please check your internet connection and try again",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            MaterialButton(
              minWidth: 200,
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.green,
              onPressed: () => _checkConnectivity(context),
              child: const Text(
                "Try Again",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      )),
    );
  }
}
