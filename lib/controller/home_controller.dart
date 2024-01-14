// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workmate_01/model/user_model.dart';

import '../Provider/Api_provider.dart';
import '../model/menu_model.dart';

class HomeController extends GetxController {
  final menuData = <MenuModel>[].obs;
  final isLoading = true.obs;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  @override
  void onInit() {
    super.onInit();
    getMenu();
    getUser();
  }

  getMenu() async {
    isLoading.value = true;
    menuData.clear();
    print("get menu called");
    try {
      var res = await ApiProvider()
          .getRequest(apiUrl: "dashboard/GetMenu?p_devicetype=1");
      print("object");
      print(jsonDecode(res));
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

  getUser() async {
    isLoading.value = true;
    menuData.clear();
    print("get User called");
    try {
      var res = await ApiProvider().getRequest(apiUrl: "data/authenticate");
      final userData = userDataFromJson(res);
      await GetStorage().write("username", userData.data.userName.toString());
      await GetStorage().write("code", userData.data.empCode.toString());
      await GetStorage().write("mobile", userData.data.mobileNo.toString());
      isLoading.value = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
