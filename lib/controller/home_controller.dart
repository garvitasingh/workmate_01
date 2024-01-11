import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Provider/Api_provider.dart';
import '../model/menu_model.dart';

class HomeController extends GetxController{
  final menuData = <MenuModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit(){
    super.onInit();
    getMenu();
  }

  getMenu() async {
    isLoading.value = true;
    menuData.clear();
    print("get menu called");
    try {
      var res = await ApiProvider().getRequest(apiUrl: "dashboard/GetMenu?p_devicetype=1");
      // print(jsonDecode(res));
      var data = jsonDecode(res);
      // print(data["Data"]["Menu"]);
      for (var i = 0; i < data["Data"]["Menu"].length; i++) {
        menuData.add(MenuModel.fromJson(data["Data"]["Menu"][i]));
        isLoading.value = false;
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}