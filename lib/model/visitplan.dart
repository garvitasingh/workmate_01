// // To parse this JSON data, do
// //
// //     final visitPlanModel = visitPlanModelFromJson(jsonString);

// import 'dart:convert';

// VisitPlanModel visitPlanModelFromJson(String str) => VisitPlanModel.fromJson(json.decode(str));

// String visitPlanModelToJson(VisitPlanModel data) => json.encode(data.toJson());

// class VisitPlanModel {
//     String? responseMessage;
//     bool? status;
//     int? dataCount;
//     Data? data;
//     String? responseCode;
//     bool? confirmationbox;

//     VisitPlanModel({
//         this.responseMessage,
//         this.status,
//         this.dataCount,
//         this.data,
//         this.responseCode,
//         this.confirmationbox,
//     });

//     factory VisitPlanModel.fromJson(Map<String, dynamic> json) => VisitPlanModel(
//         responseMessage: json["ResponseMessage"],
//         status: json["Status"],
//         dataCount: json["DataCount"],
//         data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
//         responseCode: json["ResponseCode"],
//         confirmationbox: json["confirmationbox"],
//     );

//     Map<String, dynamic> toJson() => {
//         "ResponseMessage": responseMessage,
//         "Status": status,
//         "DataCount": dataCount,
//         "Data": data?.toJson(),
//         "ResponseCode": responseCode,
//         "confirmationbox": confirmationbox,
//     };
// }

// class Data {
//     List<VisitPlan>? visitPlan;

//     Data({
//         this.visitPlan,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         visitPlan: json["VisitPlan"] == null ? [] : List<VisitPlan>.from(json["VisitPlan"]!.map((x) => VisitPlan.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "VisitPlan": visitPlan == null ? [] : List<dynamic>.from(visitPlan!.map((x) => x.toJson())),
//     };
// }

// class VisitPlan {
//     int? expenseId;
//     String? visitLocation;
//     String? visitDate;
//     String? visitFrom;
//     String? visitTo;
//     String? visitPurpose;
//     String? visitRemarks;
//     int? fillRemarks;

//     VisitPlan({
//         this.expenseId,
//         this.visitLocation,
//         this.visitDate,
//         this.visitFrom,
//         this.visitTo,
//         this.visitPurpose,
//         this.visitRemarks,
//         this.fillRemarks,
//     });

//     factory VisitPlan.fromJson(Map<String, dynamic> json) => VisitPlan(
//         expenseId: json["ExpenseId"],
//         visitLocation: json["VisitLocation"],
//         visitDate: json["VisitDate"],
//         visitFrom: json["VisitFrom"],
//         visitTo: json["VisitTo"],
//         visitPurpose: json["VisitPurpose"],
//         visitRemarks: json["VisitRemarks"],
//         fillRemarks: json["FillRemarks"],
//     );

//     Map<String, dynamic> toJson() => {
//         "ExpenseId": expenseId,
//         "VisitLocation": visitLocation,
//         "VisitDate": visitDate,
//         "VisitFrom": visitFrom,
//         "VisitTo": visitTo,
//         "VisitPurpose": visitPurpose,
//         "VisitRemarks": visitRemarks,
//         "FillRemarks": fillRemarks,
//     };
// }
