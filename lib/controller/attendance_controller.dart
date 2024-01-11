import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/model/attendance_model.dart';

import '../Provider/Api_provider.dart';

class AttendanceController extends GetxController{
  final attendanceData = <AttendanceModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit(){
    super.onInit();
    getAttendance();
  }

  getAttendance() async {
    isLoading.value = true;
    attendanceData.clear();
    print("get attendance called");
    try {
      var res = await ApiProvider().getRequest(apiUrl: "Attendance/GetAttendance");
      // print(jsonDecode(res));
      var data = jsonDecode(res);
      print(data["Data"]["AttendanceDetails"]);
      for (var i = 0; i < data["Data"]["AttendanceDetails"].length; i++) {
        attendanceData.add(AttendanceModel.fromJson(data["Data"]["AttendanceDetails"][i]));
        isLoading.value = false;
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}