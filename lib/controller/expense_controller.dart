// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workmate_01/model/conve_mode_model.dart';
import 'package:workmate_01/model/visit_plan_ex_mode.dart';
import 'package:http/http.dart' as http;
import 'package:workmate_01/model/visit_plan_model.dart';
import 'package:workmate_01/utils/local_data.dart';

import '../Provider/Api_provider.dart';
import '../utils/constants.dart';

class ExpenseController extends GetxController {
  final TextEditingController fromdistanse = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController todistanse = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController locationDistanceController =
      TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController visitPurposeController = TextEditingController();
  final isLoading = true.obs;
  final isSubmit = true.obs;
  final unplaned = true.obs;
  final expModeIdText = "ExpModeId".obs;
  String? convModeString;
  VisitPlanModel? visitPlanModel;
  VisitPlanExpModel? visitPlanExpModel;
  ConvModeModel? convModeModel;
  String? selectedLocation = ' ';
  final seleExpLocation = ''.obs;
  List<String> visits = [];
  List<String> convMode = [];
  List<String> convExpMode = [];
  String? expenseId;
  int? convModeId = 1;
  int? expModeId;
  File? capturedImage;

  @override
  void onInit() {
    super.onInit();

    getVisitPlans();
    // getMstConvMode();
    getMstExpMode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    fromdistanse.dispose();
    todistanse.dispose();
    rateController.dispose();
    locationDistanceController.dispose();
    amountController.dispose();
    remarksController.dispose();
    visitPurposeController.dispose();
    super.dispose();
  }

  openGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      capturedImage = File(pickedFile.path);
      update();
    }
  }

  openCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      capturedImage = File(pickedFile.path);
      update();
    }
  }

  openSheet(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_enhance),
                title: const Text('Camera'),
                onTap: () {
                  openCamera();
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.file_copy),
                title: const Text('Gallery'),
                onTap: () {
                  openGallery();
                  Get.back();
                },
              ),
            ],
          );
        });
  }

  getVisitPlans() async {
    isLoading.value = true;
    visits.clear();
    print("get visits called");
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "https://7dd1-2409-4089-8507-d651-c5fe-347a-9173-f439.ngrok-free.app/v1/application/attendence/get-visit-for-attendence?EMPCode=${LocalData().getEmpCode()}");

      visitPlanModel = visitPlanModelFromJson(res);
      print(visitPlanModel);
      for (var i = 0; i < visitPlanModel!.dataCount; i++) {
        print(visitPlanModel!.data.visitPlan[i].visitLocation);
        if (visitPlanModel!.data.visitPlan[i].visitLocation != "Un-planned") {
          visits
              .add(visitPlanModel!.data.visitPlan[i].visitLocation.toString());
          selectedLocation = visitPlanModel!.data.visitPlan[i].visitLocation;
          update();
        }
        update();
      }

      update();
      isLoading.value = false;
      update();
      getVisitLocation();
    } catch (e) {
      print(e.toString());
    }
  }

  getMstConvMode() async {
    isLoading.value = true;

    print("get leave called");
    try {
      var res = await ApiProvider().getRequest(apiUrl: "Claim/MstConvMode");
      // print(jsonDecode(res));
      convModeModel = convModeModelFromJson(res);
      for (var i = 0; i < convModeModel!.dataCount; i++) {
        convMode.add(convModeModel!.data.visitPlan[i].convModeDesc);
        update();
      }

      isLoading.value = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getMstExpMode() async {
    print("get leave called");
    try {
      var res = await ApiProvider().getRequest(
          apiUrl:
              "https://7dd1-2409-4089-8507-d651-c5fe-347a-9173-f439.ngrok-free.app/v1/application/expense/exp-mst-mode");
      // print(jsonDecode(res));
      visitPlanExpModel = visitPlanExpModelFromJson(res);
      print(visitPlanExpModel);
      for (var i = 0; i < visitPlanExpModel!.data!.visitPlan!.length; i++) {
        convExpMode
            .add(visitPlanExpModel!.data!.visitPlan![i].ddlDesc.toString());
        update();
      }

      update();
    } catch (e) {
      print(e.toString());
    }
  }

  expIdGet() {
    for (var i = 0; i < visitPlanExpModel!.data!.visitPlan!.length; i++) {
      if (seleExpLocation.value ==
          visitPlanExpModel!.data!.visitPlan![i].ddlDesc) {
        expModeId = visitPlanExpModel!.data!.visitPlan![i].ddlId;
        update();
      }
    }
    print(expModeId);
  }

  calculateAmount() {
    print("object");
    for (var i = 0; i < convModeModel!.dataCount; i++) {
      if (convModeString == convModeModel!.data.visitPlan[i].convModeDesc) {
        rateController.text = convModeModel!.data.visitPlan[i].rate.toString();
        convModeId = convModeModel!.data.visitPlan[i].convModeId;
        update();
      }
    }
  }

  getVisitLocation() {
    print("object");
    for (var i = 0; i < visitPlanModel!.dataCount; i++) {
      if (selectedLocation ==
          visitPlanModel!.data.visitPlan[i].visitLocation.toString()) {
        dateController.text = visitPlanModel!.data.visitPlan[i].visitDate;
        expenseId = visitPlanModel!.data.visitPlan[i].expenseId;
        if (visitPlanModel!.data.visitPlan[i].visitLocation == "Un-planned") {
          print("fff");
          fromdistanse.clear();
          todistanse.clear();
          unplaned.value = true;
        } else {
          List<String> citiesSeparated =
              visitPlanModel!.data.visitPlan[i].visitLocation.split('-');
          fromdistanse.text = citiesSeparated[0];
          todistanse.text = citiesSeparated[1];
          unplaned.value = false;
          print(citiesSeparated);
        }
        update();
      }
    }
  }

  addClaim() async {
    isSubmit.value = false;
    print("apply leave called");
    try {
      // if (capturedImage == null) {
      //   isSubmit.value = true;
      //   update();
      //   constToast("Please Select file");
      //   return;
      // }
      if (rateController.text.isEmpty) {
        rateController.text = "00";
        locationDistanceController.text = "00";
        convModeId = 0;
        update();
      }
      var token = GetStorage().read("token");

      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://7dd1-2409-4089-8507-d651-c5fe-347a-9173-f439.ngrok-free.app/v1/application/expense/create-expense'));
      request.fields.addAll({
        "EMPCode": "IT002",
        "expensemodeid": expModeId.toString(),
        "ConvModeId": convModeId.toString(),
        "VisitSummaryId": expenseId.toString(),
        "Rate": rateController.text,
        "LocationDistance": locationDistanceController.text,
        "amount": amountController.text,
        "ClaimDoc": "test",
        "Remarks": rateController.text,
        "Reason": "stay"
        // 'Value':
        //     '{"ExpenseId": ${expenseId.toString()},"ExpModeId":${expModeId.toString()},"ConvModeId": ${convModeId.toString()},"Rate": ${rateController.text},"LocationDistance":${locationDistanceController.text},"Amount": ${amountController.text},"ClaimDoc":"test","Remarks": "${remarksController.text}","VisitPurpose": "${visitPurposeController.text}"}'
      });
      print(request.fields);
      // request.files
      //     .add(await http.MultipartFile.fromPath('Image', capturedImage!.path));
      request.headers.addAll({'Authorization': 'Bearer $token'});
      print(request.fields);
      http.StreamedResponse response = await request.send();
      var dec = jsonDecode(await response.stream.bytesToString());
      print(dec);
      // print(data);
      // var res = await ApiProvider().postRequestToken(
      //     apiUrl: "http://14.99.179.131/wsnapi/api/Claim/AddClaim", data: data);
      // print(jsonDecode(res));

      if (dec['message'] == "Claim create successfully") {
        isSubmit.value = true;
        constToast(dec['message']);
        // fromdistanse.clear();
        // todistanse.clear();
        capturedImage = null;
        locationDistanceController.clear();
        rateController.clear();
        remarksController.clear();
        visitPurposeController.clear();
      } else {
        constToast(dec['message']);
      }

      isSubmit.value = true;
      update();
    } catch (e) {
      isSubmit.value = true;
      print(e.toString());
    }
  }
}
