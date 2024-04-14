// To parse this JSON data, do
//
//     final claimsModel = claimsModelFromJson(jsonString);

import 'dart:convert';

ClaimsModel claimsModelFromJson(String str) => ClaimsModel.fromJson(json.decode(str));

String claimsModelToJson(ClaimsModel data) => json.encode(data.toJson());

class ClaimsModel {
    String? responseMessage;
    bool? status;
    int? dataCount;
    Data? data;
    String? responseCode;
    bool? confirmationbox;

    ClaimsModel({
        this.responseMessage,
        this.status,
        this.dataCount,
        this.data,
        this.responseCode,
        this.confirmationbox,
    });

    factory ClaimsModel.fromJson(Map<String, dynamic> json) => ClaimsModel(
        responseMessage: json["ResponseMessage"],
        status: json["Status"],
        dataCount: json["DataCount"],
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
        responseCode: json["ResponseCode"],
        confirmationbox: json["confirmationbox"],
    );

    Map<String, dynamic> toJson() => {
        "ResponseMessage": responseMessage,
        "Status": status,
        "DataCount": dataCount,
        "Data": data?.toJson(),
        "ResponseCode": responseCode,
        "confirmationbox": confirmationbox,
    };
}

class Data {
    List<ClaimDetail>? claimDetails;

    Data({
        this.claimDetails,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        claimDetails: json["ClaimDetails"] == null ? [] : List<ClaimDetail>.from(json["ClaimDetails"]!.map((x) => ClaimDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ClaimDetails": claimDetails == null ? [] : List<dynamic>.from(claimDetails!.map((x) => x.toJson())),
    };
}

class ClaimDetail {
    String? expenseReqId;
    String? expenseDoc;
    String? amount;
    DateTime? createdAt;
    String? expModeDesc;
    String? rate;
    DateTime? updatedAt;
    String? visitFrom;
    String? visitTo;
    String? visitPurpose;
    dynamic convModeDesc;
    String? description;
    dynamic approvedBy;
    dynamic checkedBy;

    ClaimDetail({
        this.expenseReqId,
        this.expenseDoc,
        this.amount,
        this.createdAt,
        this.expModeDesc,
        this.rate,
        this.updatedAt,
        this.visitFrom,
        this.visitTo,
        this.visitPurpose,
        this.convModeDesc,
        this.description,
        this.approvedBy,
        this.checkedBy,
    });

    factory ClaimDetail.fromJson(Map<String, dynamic> json) => ClaimDetail(
        expenseReqId: json["ExpenseReqId"],
        expenseDoc: json["expense_doc"],
        amount: json["Amount"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        expModeDesc: json["ExpModeDesc"],
        rate: json["Rate"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        visitFrom: json["VisitFrom"],
        visitTo: json["VisitTo"],
        visitPurpose: json["VisitPurpose"],
        convModeDesc: json["ConvModeDesc"],
        description: json["Description"],
        approvedBy: json["ApprovedBy"],
        checkedBy: json["CheckedBy"],
    );

    Map<String, dynamic> toJson() => {
        "ExpenseReqId": expenseReqId,
        "expense_doc": expenseDoc,
        "Amount": amount,
        "createdAt": createdAt?.toIso8601String(),
        "ExpModeDesc": expModeDesc,
        "Rate": rate,
        "updatedAt": updatedAt?.toIso8601String(),
        "VisitFrom": visitFrom,
        "VisitTo": visitTo,
        "VisitPurpose": visitPurpose,
        "ConvModeDesc": convModeDesc,
        "Description": description,
        "ApprovedBy": approvedBy,
        "CheckedBy": checkedBy,
    };
}
