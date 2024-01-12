// ignore_for_file: avoid_print

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workmate_01/utils/constants.dart';

import 'package:workmate_01/view/homePage.dart';
import 'package:workmate_01/view/verification_screen.dart';
import '../Provider/Api_provider.dart';

class AuthController extends GetxController {
  final isLoading = true.obs;
  var box = GetStorage();
  TextEditingController phoneController = TextEditingController();
  var password = "null";
  @override
  void onInit() {
     getDeviceId();
   // generateUUID();
    super.onInit();
  }

  loginUser() async {
    isLoading.value = false;
    print(box.read("token"));
    update();
    print("get login called");
    try {
      // You can use your logic to get the password
      print(password);
      if (phoneController.text.isEmpty || password == "null") {
        constToast("Mobile cannot be empty.");
        isLoading.value = true;
        update();
        return;
      }

      var data = {
        "username": phoneController.text,
        "password": password,
        "grant_type": "password",
        "devicetype": "M",
      };

      var res = await ApiProvider().postRequestToken(
          apiUrl: "http://14.99.179.131/wsnapi/token", data: data);
      print(res);
      if (res['error_uri'].toString() == "001") {
        Get.to(const VerificationUser());
      } else {
        box.write("token", res['access_token']);
        Get.offAll(const HomePageView());
      }
      isLoading.value = true;
      update();
    } catch (e) {
      isLoading.value = true;
      update();
      print(e.toString());
    }
  }

  userActivation() async {
    print("get userActivation called");
    try {
      // You can use your logic to get the password

      var data = {
        "UserName": phoneController.text,
        "Password": password,
        "DeviceType": "M"
      };

      var res = await ApiProvider().postRequestToken(
          apiUrl: "http://14.99.179.131/wsnapi/api/data/UserActivate",
          data: data);
      print(res);
      if (res['Status'] == true) {
        loginUser();
      }
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      print(e.toString());
    }
  }

  // void generateUUID() {
  //   var uuid = Uuid();
  //   password = uuid.v4();
  //   print('UUID: ${uuid.v4()}');
  // }

  Future<void> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      password = androidInfo.id;
      update();
      print('Device ID: ${androidInfo.id}');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Device ID: ${iosInfo.identifierForVendor}');
    }
  }
}
