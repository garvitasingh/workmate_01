// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workmate_01/model/about_app_model.dart';
import 'package:workmate_01/model/last_check_in_model.dart';
import 'package:workmate_01/model/user_model.dart';
import 'package:workmate_01/utils/constants.dart';

import '../Provider/Api_provider.dart';

class HomeController extends GetxController {
  final menuData = [].obs;
  //final leaveController = Get.put(LeaveController());

  AboutAppModel? aboutapp;
  UserData? userData;
  LastCheckInModel? lastCheckInModel;
  final isLoading = true.obs;
  final ischeck = true.obs;
  String selectedValue = '';
  List<String> getLastVisits = [];
  @override
  void onInit() {
    super.onInit();
    getAboutapp();
    //leaveController.getLeave();
  }

  getUser() async {
    isLoading.value = true;
    print("get User called");
    try {
      var res = await ApiProvider()
          .getRequest(apiUrl: "$BASEURL/v1/application/user/getuser");
      userData = userDataFromJson(res);
      print(userData!.data!.mobileNo.toString());
      update();
      getMenu(userId: userData!.data!.empCode.toString());
      await GetStorage().write("username", userData?.data?.userName.toString());
      await GetStorage().write("code", userData?.data?.empCode.toString());
      await GetStorage().write("mobile", userData?.data?.mobileNo.toString());

      isLoading.value = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getAboutapp() async {
    isLoading.value = true;
    print("get AboutCall called");
    try {
      var res = await ApiProvider()
          .getRequest(apiUrl: "$BASEURL/v1/application/dashboard/app-info");
      print(aboutapp);
      aboutapp = aboutAppModelFromJson(res);
      await GetStorage()
          .write("productname", aboutapp?.data.info[0].productName);
      getlastCheckina();
      getUser();
      isLoading.value = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getlastCheckina() async {
    getLastVisits.clear();
    ischeck.value = true;
    isLoading.value = true;
    update();
    print("get last called");
    try {
      var res = await ApiProvider().getRequest(
          apiUrl: "$BASEURL/v1/application/attendence/get-last-check-in");
      lastCheckInModel = lastCheckInModelFromJson(res);
      for (var i = 0; i < lastCheckInModel!.dataCount!; i++) {
        String newVisit =
            "${lastCheckInModel?.data?.lastVisitAttendance?[i].visitFrom} -${lastCheckInModel?.data?.lastVisitAttendance?[i].visitTo}";
        getLastVisits.add(newVisit);
        selectedValue = newVisit;
        update();
      }
      ischeck.value = false;
      isLoading.value = false;

      update();
    } catch (e) {
      ischeck.value = false;
      isLoading.value = false;
      update();
      print(e.toString());
    }
  }

  List menuStatic = [
    "My Attendance",
    "Mark Attendance",
    "Visits",
    "Expense Management",
    "Leave",
    "Others"
  ];

  getMenu({userId}) async {
    isLoading.value = true;
    menuData.clear();
    print("get menu called");
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "$BASEURL/v1/application/dashboard/get-menu?Devicetype=M&EmpCode=$userId");
      print(jsonDecode(res));
      var data = jsonDecode(res);
      for (var i = 0; i < data["Data"]["Menu"].length; i++) {
        menuData.add(menuStatic[i]);
        isLoading.value = false;
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop(BuildContext context) async {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      // First time back pressed or exceeds 2 seconds, show a message.
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit.'),
          duration: Duration(seconds: 2),
        ),
      );
      return false; // Do not exit the app.
    } else {
      return true; // Exit the app.
    }
  }
}
