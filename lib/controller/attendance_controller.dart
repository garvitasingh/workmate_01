import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workmate_01/model/attendance_log.dart';
import 'package:workmate_01/model/attendance_model.dart';
import 'package:workmate_01/model/visit_attendance_model.dart';
import 'package:workmate_01/model/visit_plan_model.dart';
import 'package:workmate_01/utils/constants.dart';
import 'package:workmate_01/utils/local_data.dart';

import '../Provider/Api_provider.dart';

class AttendanceController extends GetxController {
  AttendanceModel? attendanceData;
  final isLoading = true.obs;
  final isMark = true.obs;
  AttendanceLogModel? attendanceLogModel;
  VisitAttendanceModel? visitAttendanceModel;
  List<String> visits = [];
  VisitPlanModel? visitPlanModel;
  String? selectedLocation = ' ';
  int? visitid;
  final unplaned = false.obs;
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  String formatDateTime(DateTime dateTime) {
    return DateFormat('MM-dd-yyyy HH:mm').format(dateTime);
  }

  @override
  void onInit() {
    super.onInit();
    getAttendance();
    getAttendanceLogs();
    getVisitAttendance(1);
    getVisitPlans();
  }

  getall() {
    getAttendance();
    getAttendanceLogs();
  }

  getAttendance() async {
    isLoading.value = true;
    update();
    print("get attendance called");
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "Attendance/GetAttendanceSummary?EmpCode=${LocalData().getEmpCode()}");
      // print(jsonDecode(res));
      print(res);
      attendanceData = attendanceModelFromJson(res);
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      print(e.toString());
    }
  }

  getvisitId() {
    for (var i = 0; i < visitPlanModel!.dataCount; i++) {
      if (selectedLocation == visitPlanModel!.data.visitPlan[i].visitLocation) {
        visitid = visitPlanModel!.data.visitPlan[i].expenseId;
      }
      if (selectedLocation == "Un-planned") {
        unplaned.value = true;
        update();
        print(unplaned.value);
      } else {
        print(unplaned.value);
        unplaned.value = false;
        update();
      }
    }
    getVisitAttendance(visitid);
    update();
  }

  getAttendanceLogs() async {
    isLoading.value = true;
    update();
    print("get attendance called");
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "Attendance/GetAttendancelog?EmpCode=${LocalData().getEmpCode()}&VisitId=1");
      attendanceLogModel = attendanceLogModelFromJson(res);
      print(res);
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      print(e.toString());
    }
  }

  getVisitPlans() async {
    isLoading.value = true;
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
      getvisitId();
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      print(e.toString());
    }
  }

  getVisitAttendance(id) async {
    isLoading.value = true;
    update();
    print("get visit attendance called");
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "Attendance/GetVisitAttendance?EmpCode=${LocalData().getEmpCode()}&VisitId=$id");
      visitAttendanceModel = visitAttendanceModelFromJson(res);
      print(res);
      isLoading.value = false;
      update();
    } catch (e) {
      visitAttendanceModel!.data.visitAttendance[0].checkIn = 0;
      visitAttendanceModel!.data.visitAttendance[0].checkIn = 1;
      visitAttendanceModel!.data.visitAttendance[0].checkInTime = 'null';
      visitAttendanceModel!.data.visitAttendance[0].checkOutTime = "null";
      visitAttendanceModel!.data.visitAttendance[0].checkIn = 0;
      visitAttendanceModel!.data.visitAttendance[0].checkOut = 0;
      isLoading.value = false;
      update();
      print(e.toString());
    }
  }

  markAttendance({
    String? lat,
    String? log,
    String? add,
    String? attType,
  }) async {
    isMark.value = false;
    print("apply mark called");
    DateTime currentDateTime = DateTime.now();
    String formattedDateTime = formatDateTime(currentDateTime);
    print(formattedDateTime);
    try {
      if (unplaned.isTrue) {
        if (from.text.isEmpty || to.text.isEmpty) {
          constToast("Fields Are Required!");
          isMark.value = true;
          update();
          return;
        }
      }

      var data = {
        "EMPCode": LocalData().getEmpCode(),
        "CellEMIENo": LocalData().getdeviceid(),
        "Latitude": lat.toString(),
        "Longitude": log.toString(),
        "Address": add.toString(),
        "AddressImage": "Doe",
        "AttendanceType": attType.toString(),
        "AttendanceDate": formattedDateTime,
        "VisitId": visitid.toString(),
        "FromVisit": unplaned.isTrue ? from.text : "",
        "ToVisit": unplaned.isTrue ? to.text : "",
      };
      print(data);
      var res = await ApiProvider().postRequestToken(
          apiUrl: "http://14.99.179.131/wsnapi/api/Attendance/MarkAttendance",
          data: data);
      print(res);
      print(res);
      from.clear();
      to.clear();
      getVisitAttendance(visitid);
      isMark.value = true;
      update();
    } catch (e) {
      isMark.value = true;
      update();
      print(e.toString());
    }
  }
}
