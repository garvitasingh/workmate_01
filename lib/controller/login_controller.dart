import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workmate_01/utils/constants.dart';
import 'package:workmate_01/view/homePage.dart';
import 'package:workmate_01/view/login_view.dart';
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
      if (phoneController.text.isEmpty ||
          phoneController.text.length < 10 ||
          password == "null") {
        constToast("Mobile should be a 10-digit number.");
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
      box.write("deviceid", password);
      var res = await ApiProvider().postRequestToken(
          apiUrl:
              "https://7dd1-2409-4089-8507-d651-c5fe-347a-9173-f439.ngrok-free.app/v1/application/auth/token",
          data: data);

      if (res['error_uri'].toString() == "001") {
        Get.to(const VerificationUser());
      } else {
        box.write("token", res['access_token']);
        Get.offAll(const HomePageView());
      }
      isLoading.value = true;
      update();
    } catch (e) {
      constToast("Time Out");
      isLoading.value = true;
      update();
      print(e.toString());
    }
  }

  userActivation() async {
    print("get userActivation called");
    try {
      // You can use your logic to get the password
      isLoading.value = false;
      update();
      var data = {
        "UserName": phoneController.text,
        "Password": password,
      };

      var res = await ApiProvider().postRequestToken(
          apiUrl:
              "https://7dd1-2409-4089-8507-d651-c5fe-347a-9173-f439.ngrok-free.app/v1/application/auth/activate-user",
          data: data);
      if (res['responseData']['Status'] == true) {
        loginUser();
      } else {
        isLoading.value = true;
        update();
        constToast("Credentials Not Validate");
        Get.offAll(const LoginViewPage());
      }
      isLoading.value = true;
      update();
    } catch (e) {
      isLoading.value = true;
      update();
      print(e.toString());
    }
  }

  Future<void> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      //  password = 'UP1A.230620.001';
      password = "8EC1C5B9-0853-4E1D-9135-8C385E7E1A9C";
      update();
      print('Device ID: ${androidInfo.id}');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      password = "8EC1C5B9-0853-4E1D-9135-8C385E7E1A9C";
      update();
      print('Device ID: ${iosInfo.identifierForVendor}');
    }
  }
}
