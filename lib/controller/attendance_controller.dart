import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:workmate_01/controller/expense_controller.dart';
import 'package:workmate_01/model/attendance_log.dart';
import 'package:workmate_01/model/attendance_model.dart';
import 'package:workmate_01/model/monthl_attendance_model.dart';
import 'package:workmate_01/model/visit_attendance_model.dart';
import 'package:workmate_01/model/visit_plan_model.dart';
import 'package:workmate_01/utils/constants.dart';
import 'package:workmate_01/utils/local_data.dart';
import 'package:http/http.dart' as http;

import '../Provider/Api_provider.dart';

class AttendanceController extends GetxController {
  AttendanceModel? attendanceData;
  MonthlyAttendance? monthlyAttendance;
  final isLoading = true.obs;
  final isMark = true.obs;
  final dataPresent = false.obs;
  AttendanceLogModel? attendanceLogModel;
  final checkLog = false.obs;
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

  final List<DateTime> leaveDates = [];
  final List<DateTime> holidayDates = [];
  final List<DateTime> absentDates = [];

  //   List<DateTime> holidays = [
  //   DateTime.utc(2024, 1, 1),
  //   DateTime.utc(2024, 1, 5),
  // ];

  addholiday(date) {
    String presentDateString = date;
    DateTime presentDate = DateFormat("dd-MM-yyyy").parse(presentDateString);
    holidayDates.add(presentDate);
    update();
  }

  addAbsent(date) {
    String presentDateString = date;
    DateTime presentDate = DateFormat("dd-MM-yyyy").parse(presentDateString);
    absentDates.add(presentDate);
    update();
  }

  addLeave(date) {
    String presentDateString = date;
    DateTime presentDate = DateFormat("dd-MM-yyyy").parse(presentDateString);
    leaveDates.add(presentDate);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAttendance();
    getVisitPlans();
    getAttendanceMonthly();
    getAttendanceLogs();
  }

  getall() {
    getAttendance();
    getAttendanceLogs();
  }

  getAttendance() async {
    isLoading.value = true;
    update();
    if (kDebugMode) {
      print("get attendance called");
    }
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "Attendance/GetAttendanceSummary?EmpCode=${LocalData().getEmpCode()}");
      // print(jsonDecode(res));

      attendanceData = attendanceModelFromJson(res);
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  getAttendanceMonthly() async {
    isLoading.value = true;
    update();
    if (kDebugMode) {
      print("get attendance called");
    }
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "Attendance/MonthlyAttendance?EmpCode=${LocalData().getEmpCode()}");
      // print(jsonDecode(res));

      monthlyAttendance = monthlyAttendanceFromJson(res);
      for (var i = 0;
          i < monthlyAttendance!.data!.visitAttendance!.absent!.length;
          i++) {
        String ab = monthlyAttendance!
            .data!.visitAttendance!.absent![i].absentDate
            .toString();
        //print(ab);
        addAbsent(ab);
      }
      for (var i = 0;
          i < monthlyAttendance!.data!.visitAttendance!.holiday!.length;
          i++) {
        String ab = monthlyAttendance!
            .data!.visitAttendance!.holiday![i].holidayDate
            .toString();
        //print(ab);
        addholiday(ab);
      }
      for (var i = 0;
          i < monthlyAttendance!.data!.visitAttendance!.leave!.length;
          i++) {
        String ab = monthlyAttendance!
            .data!.visitAttendance!.leave![i].leaveDate
            .toString();
        //print(ab);
        addLeave(ab);
      }
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      if (kDebugMode) {
        print(e.toString());
      }
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
      } else {
        if (kDebugMode) {
          print(unplaned.value);
        }
        unplaned.value = false;
        update();
      }
      getVisitAttendance(visitid);
    }
    getVisitAttendance(visitid);

    update();
  }

  getAttendanceLogs() async {
    //isLoading.value = true;
    update();
    if (kDebugMode) {
      print("get attendance called");
    }
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "Attendance/GetAttendancelog?EmpCode=${LocalData().getEmpCode()}&VisitId=0");

      attendanceLogModel = attendanceLogModelFromJson(res);

      checkLog.value = true;
      update();

      // isLoading.value = false;
      update();
    } catch (e) {
      checkLog.value = false;
      // isLoading.value = false;
      update();
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  getVisitPlans() async {
    isLoading.value = true;
    visits.clear();
    if (kDebugMode) {
      print("get visits called");
    }
    try {
      var res = await ApiProvider().getRequest(
          apiUrl: "Claim/GetVisitPlan?EmpCode=${LocalData().getEmpCode()}");
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
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  getVisitAttendance(id) async {
    isLoading.value = true;
    update();
    if (kDebugMode) {
      print("get visit attendance called");
    }
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "Attendance/GetVisitAttendance?EmpCode=${LocalData().getEmpCode()}&VisitId=$id");
      visitAttendanceModel = visitAttendanceModelFromJson(res);
      dataPresent.value = true;
      isLoading.value = false;
      update();
    } catch (e) {
      // visitAttendanceModel!.data.visitAttendance.add(VisitAttendance(
      //   empCode: "ABC123",
      //   visitId: 1,
      //   attendanceDate: DateTime.now(),
      //   checkIn: 1,
      //   checkOut: 0,
      //   checkInTime: "09:00 AM",
      //   checkOutTime: null,
      // ));

      // visitAttendanceModel!.data.visitAttendance[0].checkIn = 0;
      // visitAttendanceModel!.data.visitAttendance[0].checkIn = 1;
      // visitAttendanceModel!.data.visitAttendance[0].checkInTime = 'null';
      // visitAttendanceModel!.data.visitAttendance[0].checkOutTime = "null";
      // visitAttendanceModel!.data.visitAttendance[0].checkIn = 0;
      // visitAttendanceModel!.data.visitAttendance[0].checkOut = 0;
      dataPresent.value = false;
      isLoading.value = false;
      update();
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  markAttendance({
    String? lat,
    String? log,
    String? add,
    String? attType,
    File? img,
  }) async {
    isMark.value = false;
    if (kDebugMode) {
      print("apply mark called");
    }
    if (img == null) {
      constToast("Please Punch Image");
    }
    DateTime currentDateTime = DateTime.now();
    String formattedDateTime = formatDateTime(currentDateTime);
    if (kDebugMode) {
      print(formattedDateTime);
    }
    try {
      if (unplaned.isTrue) {
        if (from.text.isEmpty || to.text.isEmpty) {
          constToast("Fields Are Required!");
          isMark.value = true;
          update();
          return;
        }
      }

      var token = GetStorage().read("token");
      if (selectedLocation == "Un-planned") {
        visitid = 0;
        update();
      }
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://14.99.179.131/wsnapi/api/Attendance/MarkAttendance'));
      request.fields.addAll({
        'value':
            '{"EMPCode": "${LocalData().getEmpCode()}","CellEMIENo":"${LocalData().getdeviceid()}","Latitude": "${lat.toString()}","Longitude": "${log.toString()}","Address": "${add.toString()}","AttendanceType": "${attType.toString()}","AttendanceDate": "$formattedDateTime","VisitId":"${visitid.toString()}","FromVisit":"${unplaned.isTrue ? from.text : ""}","ToVisit":"${unplaned.isTrue ? to.text : ""}"\n}'
      });
      request.files.add(await http.MultipartFile.fromPath('Image', img!.path));
      request.headers.addAll({'Authorization': 'Bearer $token'});

      http.StreamedResponse response = await request.send();
      var dec = jsonDecode(await response.stream.bytesToString());
      print(dec);
      AudioPlayer().play(AssetSource('audios/wrong_ans.mp3'));
      constToast("Attendance Marked!");
       getAttendanceLogs();
      if (unplaned.isTrue) {
        updatevisits();
      } else {
        getVisitAttendance(visitid);
      }

      isMark.value = true;
      unplaned.value = false;
      update();
    } catch (e) {
      unplaned.value = false;
      isMark.value = true;
      update();
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  updatevisits() {
    String newVisit = "${from.text}-${to.text}";
    getVisitPlans();
    for (var i = 0; i < visitPlanModel!.data.visitPlan.length; i++) {
      if (newVisit == visitPlanModel!.data.visitPlan[i].visitLocation) {
        visitid = visitPlanModel!.data.visitPlan[i].expenseId;
        getVisitAttendance(visitPlanModel!.data.visitPlan[i].expenseId);
      }
    }
    // visits.add(newVisit);
    update();
    from.clear();
    to.clear();
  }
}
