// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:workmate_01/model/visit_model.dart';
import 'package:workmate_01/model/visit_plan_model.dart';
import 'package:workmate_01/utils/local_data.dart';

import '../Provider/Api_provider.dart';

class VisitController extends GetxController {
  final visitData = <VisitModel>[].obs;
  final isLoading = true.obs;
  VisitPlanModel? visitPlanModel;
  String? selectedLocation = ' ';
  List<String> visits = [];
  @override
  void onInit() {
    super.onInit();
    getVisit();
    getVisitPlans();
  }

  getVisit() async {
    isLoading.value = true;
    visitData.clear();
    print("get leave called");
    try {
      var res =
          await ApiProvider().getRequest(apiUrl: "Expense/GetVisitDetails");
      // print(jsonDecode(res));
      var data = jsonDecode(res);
      for (var i = 0; i < data["Data"]["VisitDetails"].length; i++) {
        visitData.add(VisitModel.fromJson(data["Data"]["VisitDetails"][i]));
        isLoading.value = false;
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getVisitPlans() async {
    isLoading.value = true;
    visitData.clear();
    print("get leave called");
    try {
      var res = await ApiProvider().getRequest(
          apiUrl: "Claim/GetVisitPlan?EmpCode=${LocalData().getEmpCode()}");
      // print(jsonDecode(res));
      visitPlanModel = visitPlanModelFromJson(res);
      for (var i = 0; i < visitPlanModel!.dataCount; i++) {
        visits.add(visitPlanModel!.data.visitPlan[i].visitLocation);
        update();
      }
      selectedLocation = visitPlanModel!.data.visitPlan[0].visitLocation;
      isLoading.value = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
