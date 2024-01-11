import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/model/leave_model.dart';
import 'package:workmate_01/model/visit_model.dart';

import '../Provider/Api_provider.dart';

class VisitController extends GetxController{
  final visitData = <VisitModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit(){
    super.onInit();
    getVisit();
  }

  getVisit() async {
    isLoading.value = true;
    visitData.clear();
    print("get leave called");
    try {
      var res = await ApiProvider().getRequest(apiUrl: "Expense/GetVisitDetails");
      // print(jsonDecode(res));
      var data = jsonDecode(res);
      print(data["Data"]["VisitDetails"]);
      for (var i = 0; i < data["Data"]["VisitDetails"].length; i++) {
        visitData.add(VisitModel.fromJson(data["Data"]["VisitDetails"][i]));
        isLoading.value = false;
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}