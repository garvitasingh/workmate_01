// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/model/visit_model.dart';
import 'package:workmate_01/utils/constants.dart';
import 'package:workmate_01/utils/local_data.dart';
import '../Provider/Api_provider.dart';

class VisitController extends GetxController {
  var visitData = [];
  final isLoading = true.obs;
  TextEditingController remarkCo = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getVisit();
  }

  getVisit() async {
    isLoading.value = true;
    visitData.clear();
    print("get leave called");
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "Expense/GetVisitDetails?EmpCode=${LocalData().getEmpCode()}");
      // print(jsonDecode(res));
      var data = jsonDecode(res);
      // print(data["Data"]["VisitPlan"].length);
      for (var i = 0; i < data["Data"]["VisitPlan"].length; i++) {
        visitData.add(data["Data"]["VisitPlan"][i]);
        isLoading.value = false;
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  updateFeedback({int? id}) async {
    try {
      if (remarkCo.text.isEmpty) {
        constToast("Please Enter Remark");
        return;
      }
      print(id);
      var res = await ApiProvider().getRequest(
          apiUrl:
              "Expense/UpdateVisitFeedback?EmpCode=${LocalData().getEmpCode()}&ExpenseId=$id&VisitRemarks=${remarkCo.text} ");
      // print(jsonDecode(res));
      var data = jsonDecode(res);
      // print(data["Data"]["VisitPlan"].length);
      print(data);
      getVisit();
      constToast("Update Visit Feedback successfully!!");
    } catch (e) {
      print(e.toString());
    }
  }
}
