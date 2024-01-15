import 'package:get/get.dart';
import 'package:workmate_01/model/attendance_log.dart';
import 'package:workmate_01/model/attendance_model.dart';
import 'package:workmate_01/utils/local_data.dart';

import '../Provider/Api_provider.dart';

class AttendanceController extends GetxController {
  AttendanceModel? attendanceData;
  final isLoading = true.obs;
  AttendanceLogModel? attendanceLogModel;

  @override
  void onInit() {
    super.onInit();
    getAttendance();
    getAttendanceLogs();
  }

  getAttendance() async {
    isLoading.value = true;
    print("get attendance called");
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "Attendance/GetAttendanceSummary?EmpCode=${LocalData().getEmpCode()}");
      // print(jsonDecode(res));

      attendanceData = attendanceModelFromJson(res);
      print(attendanceData!.data.claimDetails[0].present);
      isLoading.value = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getAttendanceLogs() async {
    isLoading.value = true;
    print("get attendance called");
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "Attendance/GetAttendancelog?EmpCode=${LocalData().getEmpCode()}&VisitId=1");
      attendanceLogModel = attendanceLogModelFromJson(res);
      isLoading.value = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}