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
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
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
      await GetStorage().write("username", userData!.data!.userName.toString());
      await GetStorage().write("code", userData!.data!.empCode.toString());
      await GetStorage().write("mobile", userData!.data!.mobileNo.toString());

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
          .write("productname", aboutapp!.data.info[0].productName);
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
    print("get last called");
    try {
      var res = await ApiProvider().getRequest(
          apiUrl: "$BASEURL/v1/application/attendence/get-last-check-in");
      lastCheckInModel = lastCheckInModelFromJson(res);
      for (var i = 0; i < lastCheckInModel!.dataCount!; i++) {
        String newVisit =
            "${lastCheckInModel!.data!.lastVisitAttendance![i].visitFrom} -${lastCheckInModel!.data!.lastVisitAttendance![i].visitTo}";
        getLastVisits.add(newVisit);
        selectedValue = newVisit;
        update();
      }
      ischeck.value = false;
      update();
    } catch (e) {
      ischeck.value = false;
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
      // print(data["Data"]["Menu"]);
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
