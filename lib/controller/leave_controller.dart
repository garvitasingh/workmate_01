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
      var res = await ApiProvider()
          .getRequest(apiUrl: "$BASEURL/v1/application/leave/get-leave");
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
        "EmployeeID": employeeId.text,
        "EMPCode": LocalData().getEmpCode(),
        "LeaveTypeId": fomData['LeaveType'],
        "StartDate": DateFormat('yyyy-MM-dd').format(fomData['FromDate']),
        "EndDate": DateFormat('yyyy-MM-dd').format(fomData['ToDate']),
        "Remarks": fomData['Remarks'],
        "Reason": ""
      };
      var res = await ApiProvider().postRequestToken(
          apiUrl: "$BASEURL/v1/application/leave/apply-leave", data: data);
      // print(jsonDecode(res));
      if (kDebugMode) {
        print(res);
      }
      if (res['message'] == "Leave application submitted successfully") {
        constToast("Leave applied successfully");
      } else {
        constToast(res);
      }

      isLoading.value = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
