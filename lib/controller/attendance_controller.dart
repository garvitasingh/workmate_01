import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:workmate_01/controller/home_controller.dart';
import 'package:workmate_01/model/attendance_log.dart';
import 'package:workmate_01/model/attendance_model.dart';
import 'package:workmate_01/model/visit_attendance_model.dart';
import 'package:workmate_01/model/visit_plan_model.dart';
import 'package:workmate_01/utils/constants.dart';
import 'package:workmate_01/utils/local_data.dart';
import 'package:http/http.dart' as http;

import '../Provider/Api_provider.dart';

class AttendanceController extends GetxController {
  AttendanceModel? attendanceData;
  // MonthlyAttendance? monthlyAttendance;
  final isLoading = true.obs;
  final isMark = true.obs;
  final dataPresent = false.obs;
  AttendanceLogModel? attendanceLogModel;
  final checkLog = false.obs;
  VisitAttendanceModel? visitAttendanceModel;
  List<String> visits = [];
  VisitPlanModel? visitPlanModel;
  String? selectedLocation = ' ';
  String? visitid;
  final unplaned = false.obs;
  bool attendancLoad = false;
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  TextEditingController visitPurpose = TextEditingController();
  final homeCo = Get.put(HomeController());
  String formatDateTime(DateTime dateTime) {
    return DateFormat('MM-dd-yyyy HH:mm').format(dateTime);
  }

  final List<DateTime> leaveDates = [];
  final List<DateTime> holidayDates = [];
  final List<DateTime> absentDates = [];

  //   List<DateTime> holidays = [
  //   DateTime.utc(2024, 3, 25),
  //   DateTime.utc(2024, 3, 26),

  // ];

  addholiday(date) {
    String presentDateString = date;
    DateTime presentDate = DateFormat("yyyy-MM-dd").parse(presentDateString);
    holidayDates.add(presentDate);
    update();
  }

  addAbsent(date) {
    String presentDateString = date;
    DateTime presentDate = DateFormat("yyyy-MM-dd").parse(presentDateString);
    absentDates.add(presentDate);
    update();
  }

  addLeave(date) {
    String presentDateString = date;
    DateTime presentDate = DateFormat("yyyy-MM-dd").parse(presentDateString);
    leaveDates.add(presentDate);
    update();
  }

  @override
  void onInit() {
    super.onInit();

    // getVisitPlans();
    getAttendanceMonthly();
    if (visitID != '') {
      selectedLocation = visitID;
      print(selectedLocation);
    }
    getVisitPlans();
    getAttendance();
    getAttendanceLogs();
    // Timer.periodic(const Duration(seconds: 1), (Timer timer) {
    //   // Check if the widget is still mounted before updating the state
    //   getAttendanceLogs();
    // });
  }

  // getall() {
  //   getAttendance();
  //   getAttendanceLogs();
  // }

  getAttendance() async {
    isLoading.value = true;
    update();
    if (kDebugMode) {
      print("get attendance called");
    }
    try {
      var res = await ApiProvider().getRequest(
          apiUrl: "$BASEURL/v1/application/attendence/my-attendance");
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
          apiUrl: "$BASEURL/v1/application/attendence/get-monthly-attendence");

      var decode = jsonDecode(res);

      for (var i = 0; i < decode['Dates'].length; i++) {
        if (decode['Dates'][i]['type'] == "leave") {
          String ab = decode['Dates'][i]['date'].toString();
          //print(ab);
          addLeave(ab);
        } else {
          String ab = decode['Dates'][i]['date'].toString();
          //print(ab);
          addholiday(ab);
        }
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
    attendancLoad = true;
    update();
    visitAttendanceModel = null;
    for (var i = 0; i < visitPlanModel!.dataCount; i++) {
      if (selectedLocation == visitPlanModel!.data.visitPlan[i].visitLocation) {
        visitid = visitPlanModel!.data.visitPlan[i].expenseId;
      }
    }
    visitID = '';
    if (selectedLocation == "Un-planned") {
      unplaned.value = true;
      visitid = "1";
      update();
    } else {
      getVisitAttendance(visitid);
      unplaned.value = false;
      update();
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
              "$BASEURL/v1/application/attendence/attendance-logs?EMPCode=${LocalData().getEmpCode()}&VisitId=0");
      // print(res);
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
          apiUrl:
              "$BASEURL/v1/application/attendence/get-visit-for-attendence?EMPCode=${LocalData().getEmpCode()}");
      visitPlanModel = visitPlanModelFromJson(res);
      for (var i = 0; i < visitPlanModel!.dataCount; i++) {
        visits.add(visitPlanModel!.data.visitPlan[i].visitLocation);
        //  visits.add(visitPlanModel!.data.visitPlan[1].visitLocation);

        update();
      }
      if (visitID != '') {
        selectedLocation = visitID;
        update();
      } else {
        selectedLocation = visitPlanModel!.data.visitPlan[0].visitLocation;
      }
      update();
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
    print(id);
    update();
    if (kDebugMode) {
      print("get visit attendance called");
    }
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "$BASEURL/v1/application/attendence/get-attendance?VisitId=$visitid");
      visitAttendanceModel = visitAttendanceModelFromJson(res);
      print(res);
      attendancLoad = false;
      update();
      dataPresent.value = true;
      isLoading.value = false;
      if (visitAttendanceModel!.dataCount == 0) {
        dataPresent.value = false;
        isLoading.value = false;
        update();
      }
      update();
    } catch (e) {
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
    String? img,
  }) async {
    isMark.value = false;

    if (unplaned.isTrue) {
      visitid = "1";
      update();
    }
    if (img == '') {
      constToast("Please Punch Image");
      return;
    }

    if (unplaned.isTrue) {
      if (from.text.isEmpty || to.text.isEmpty || visitPurpose.text.isEmpty) {
        constToast("Fields Are Required!");
        isMark.value = true;
        update();
        return;
      }
    }

    var token = GetStorage().read("token");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST',
        Uri.parse('$BASEURL/v1/application/attendence/mark-attendence'));

    request.body = json.encode({
      "Latitude": lat.toString(),
      "Longitude": log.toString(),
      "isPlanned": unplaned.isTrue ? false : true,
      "VisitFrom": unplaned.isTrue ? from.text : "",
      "VisitTo": unplaned.isTrue ? to.text : "",
      "place_image": img,
      "visit_purpose": unplaned.isTrue ? visitPurpose.text : "",
      "visit_address": add.toString(),
      "VisitSummaryId": unplaned.isTrue ? "" : visitid
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      var dec = jsonDecode(await response.stream.bytesToString());
      print(dec);
      AudioPlayer().play(AssetSource('audios/wrong_ans.mp3'));
      constToast("Attendance Marked!");
      homeCo.getlastCheckina();

      update();
      if (unplaned.isTrue) {
        updatevisits();
        update();
      } else {
        getVisitAttendance(visitid);
      }

      getAttendanceLogs();
      isMark.value = true;
      unplaned.value = false;
      update();
    } else {
      unplaned.value = false;
      isMark.value = true;
      update();
      print(response.reasonPhrase);
    }
  }

  updatevisits() {
    String newVisit = "${from.text}-${to.text}";
    getVisitPlans();
    for (var i = 0; i < visitPlanModel!.data.visitPlan.length; i++) {
      if (newVisit == visitPlanModel!.data.visitPlan[i].visitLocation) {
        visitid = visitPlanModel!.data.visitPlan[i].expenseId;
      }
    }
    getVisitAttendance(visitid);
    // visits.add(newVisit);
    update();
    from.clear();
    to.clear();
    visitPurpose.clear();
  }
}
