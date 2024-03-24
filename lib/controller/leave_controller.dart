import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workmate_01/model/leave_model.dart';
import 'package:workmate_01/utils/constants.dart';
import 'package:workmate_01/utils/local_data.dart';

import '../Provider/Api_provider.dart';

class LeaveController extends GetxController {
  LeaveModel? leaveData;
  final isLoading = true.obs;

  TextEditingController employeeId = TextEditingController();
  TextEditingController leaveType = TextEditingController();
  TextEditingController formDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController remarks = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    employeeId.text = LocalData().getEmpCode();
    getLeave();
  }

  getLeave() async {
    isLoading.value = true;
    if (kDebugMode) {
      print("get leave called");
    }
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "Leave/GetLeave?Devicetype=M&EmpCode=${LocalData().getEmpCode()}");
      // print(jsonDecode(res));
      leaveData = leaveModelFromJson(res);
      isLoading.value = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  applyLeave({var fomData}) async {
    if (kDebugMode) {
      print("apply leave called");
    }
    try {
      var data = {
        "EMPCode": employeeId.text,
        "LeaveType": fomData['LeaveType'],
        "FromDate": DateFormat('yyyy-MM-dd').format(fomData['FromDate']),
        "ToDate": DateFormat('yyyy-MM-dd').format(fomData['ToDate']),
        "Remarks": fomData['Remarks'],
      };
      var res = await ApiProvider().postRequestToken(
          apiUrl: "http://14.99.179.131/wsnapi/api/Leave/ApplyLeave",
          data: data);
      // print(jsonDecode(res));
      if (kDebugMode) {
        print(res);
      }
      constToast("Leave applied successfully");
      isLoading.value = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
