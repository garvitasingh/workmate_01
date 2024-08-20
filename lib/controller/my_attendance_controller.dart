import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:workmate_01/model/attendance_model.dart';
import 'package:workmate_01/utils/constants.dart';

import '../Provider/Api_provider.dart';

class MyAttendanceController extends GetxController {
  final isLoading = true.obs;
  AttendanceModel? attendanceData;
  String? selectedLocation = '';
  String? visitid;
  final unplaned = false.obs;
  bool attendancLoad = false;

  @override
  void onInit() {
    super.onInit();
    getAttendance();
  }

  getAttendance() async {
    isLoading.value = true;
    update();
    if (kDebugMode) {
      print("get attendance called");
    }
    try {
      var res = await ApiProvider().getRequest(
          apiUrl: "$BASEURL/v1/application/attendence/my-attendance");
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
}
