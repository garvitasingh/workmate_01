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
  String image = '';
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
  String? convModeId = '';
  int? expModeId;
  File? capturedImage;

  @override
  void onInit() {
    super.onInit();

    getVisitPlans();
    getMstConvMode();
    getMstExpMode();
  }

  @override
  void dispose() {
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
      storeImage();
    }
  }

  storeImage() async {
    image = await ApiProvider().uploadImage(file: capturedImage);
    update();
  }

  openCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      capturedImage = File(pickedFile.path);
      update();
      storeImage();
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
              "$BASEURL/v1/application/attendence/get-visit-for-attendence");

      visitPlanModel = visitPlanModelFromJson(res);
      print(visitPlanModel);
      for (var i = 0; i < visitPlanModel!.dataCount; i++) {
        if (visitPlanModel?.data.visitPlan[i].visitLocation != "Un-planned") {
          visits.add(visitPlanModel?.data.visitPlan[i].visitLocation ?? '');
          selectedLocation = visitPlanModel?.data.visitPlan[i].visitLocation;
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
      var res = await ApiProvider()
          .getRequest(apiUrl: "$BASEURL/v1/application/expense/mst-con-mode");
      // print(jsonDecode(res));
      convModeModel = convModeModelFromJson(res);
      for (var i = 0; i < convModeModel!.dataCount!; i++) {
        convMode.add(convModeModel?.data?[i].convModeDesc ?? '');
        update();
      }

      isLoading.value = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getMstExpMode() async {
    print("get eeee called");
    try {
      var res = await ApiProvider()
          .getRequest(apiUrl: "$BASEURL/v1/application/expense/exp-mst-mode");
      print(jsonDecode(res));
      visitPlanExpModel = visitPlanExpModelFromJson(res);
      update();
      print(visitPlanExpModel);
      for (var i = 0; i < visitPlanExpModel!.data!.visitPlan!.length; i++) {
        convExpMode.add(visitPlanExpModel?.data?.visitPlan?[i].ddlDesc ?? '');
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
          visitPlanExpModel?.data?.visitPlan?[i].ddlDesc) {
        expModeId = visitPlanExpModel?.data?.visitPlan?[i].ddlId;
        update();
      }
    }
    print(convModeId);
  }

  calculateAmount() {
    print("object");
    for (var i = 0; i < convModeModel!.dataCount!; i++) {
      if (convModeString == convModeModel?.data?[i].convModeDesc) {
        rateController.text = convModeModel?.data?[i].rate.toString() ?? '';
        convModeId = convModeModel?.data?[i].convModeId.toString();
        update();
      }
    }
  }

  getVisitLocation() {
    print(expModeId);
    print(convModeId);
    for (var i = 0; i < visitPlanModel!.dataCount; i++) {
      if (selectedLocation ==
          visitPlanModel!.data.visitPlan[i].visitLocation.toString()) {
        dateController.text = visitPlanModel?.data.visitPlan[i].visitDate ?? '';
        expenseId = visitPlanModel?.data.visitPlan[i].expenseId;
        if (visitPlanModel?.data.visitPlan[i].visitLocation == "Un-planned") {
          fromdistanse.clear();
          todistanse.clear();
          unplaned.value = true;
        } else {
          List<String> citiesSeparated =
              visitPlanModel?.data.visitPlan[i].visitLocation.split('-') ?? [];
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
      if (capturedImage == null) {
        isSubmit.value = true;
        update();
        constToast("Please Select file");
        return;
      }
      if (rateController.text.isEmpty) {
        rateController.text = "00";
        locationDistanceController.text = "00";
        convModeId = '';
        update();
      }
      var token = GetStorage().read("token");
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var request = http.Request(
          'POST', Uri.parse('$BASEURL/v1/application/expense/create-expense'));
      request.body = json.encode({
        "ExpModeId": expModeId,
        "ConvModeId": convModeId,
        "VisitSummaryId": expenseId,
        "Rate": rateController.text,
        "LocationDistance": locationDistanceController.text,
        "Amount": amountController.text,
        "ClaimDoc": image,
        "Remarks": remarksController.text,
        "Reason": " "
      });
      print(request.body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var dec = jsonDecode(await response.stream.bytesToString());
      print(dec);
      if (dec['message'] == "Claim create successfully") {
        isSubmit.value = true;
        constToast(dec['message']);

        capturedImage = null;
        locationDistanceController.clear();
        rateController.clear();
        remarksController.clear();
        visitPurposeController.clear();
        amountController.clear();
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
