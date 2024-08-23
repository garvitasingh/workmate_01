import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:get/get.dart';
import 'package:workmate_01/network/offline_view.dart';
import 'package:workmate_01/utils/constants.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final isOffline = false.obs;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivity.onConnectivityChanged.listen((result) {
      updateConnectionState(result);
    });
  }

  void updateConnectionState(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.vpn) {
      isOffline.value = false;
    } else {
      isOffline.value = true;
    }
    isOffline.refresh();
    if (isOffline.isTrue && !OfflineView.isVisible) {
      Get.to(const OfflineView());
    }
  }

  Future<void> initConnectivity() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    updateConnectionState(connectivityResult);
  }
}
