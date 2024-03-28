// To parse this JSON data, do
//
//     final visitPlanModel = visitPlanModelFromJson(jsonString);

import 'dart:convert';

VisitPlanModel visitPlanModelFromJson(String str) =>
    VisitPlanModel.fromJson(json.decode(str));

String visitPlanModelToJson(VisitPlanModel data) => json.encode(data.toJson());

class VisitPlanModel {
  String responseMessage;
  bool status;
  int dataCount;
  Data data;
  String responseCode;
  bool confirmationbox;

  VisitPlanModel({
    required this.responseMessage,
    required this.status,
    required this.dataCount,
    required this.data,
    required this.responseCode,
    required this.confirmationbox,
  });

  factory VisitPlanModel.fromJson(Map<String, dynamic> json) => VisitPlanModel(
        responseMessage: json["ResponseMessage"],
        status: json["Status"],
        dataCount: json["DataCount"],
        data: Data.fromJson(json["Data"]),
        responseCode: json["ResponseCode"],
        confirmationbox: json["confirmationbox"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseMessage": responseMessage,
        "Status": status,
        "DataCount": dataCount,
        "Data": data.toJson(),
        "ResponseCode": responseCode,
        "confirmationbox": confirmationbox,
      };
}

class Data {
  List<VisitPlan> visitPlan;

  Data({
    required this.visitPlan,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        visitPlan: List<VisitPlan>.from(
            json["VisitPlan"].map((x) => VisitPlan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "VisitPlan": List<dynamic>.from(visitPlan.map((x) => x.toJson())),
      };
}

class VisitPlan {
  String expenseId;
  String visitLocation;
  String visitDate;

  VisitPlan({
    required this.expenseId,
    required this.visitLocation,
    required this.visitDate,
  });

  factory VisitPlan.fromJson(Map<String, dynamic> json) => VisitPlan(
        expenseId: json["VisitSummaryId"],
        visitLocation: json["VisitLocation"],
        visitDate: json["VisitDate"],
      );

  Map<String, dynamic> toJson() => {
        "VisitSummaryId": expenseId,
        "VisitLocation": visitLocation,
        "VisitDate": visitDate,
      };
}
