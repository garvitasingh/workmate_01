import 'dart:convert';


import 'package:get/get.dart';
import 'package:workmate_01/model/leave_model.dart';

import '../Provider/Api_provider.dart';

class LeaveController extends GetxController{
  final leaveData = <LeaveModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit(){
    super.onInit();
    getLeave();
  }

  getLeave() async {
    isLoading.value = true;
    leaveData.clear();
    print("get leave called");
    try {
      var res = await ApiProvider().getRequest(apiUrl: "Leave/GetLeave");
      // print(jsonDecode(res));
      var data = jsonDecode(res);
      print(data["Data"]["LeaveDetails"]);
      for (var i = 0; i < data["Data"]["LeaveDetails"].length; i++) {
        leaveData.add(LeaveModel.fromJson(data["Data"]["LeaveDetails"][i]));
        isLoading.value = false;
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}