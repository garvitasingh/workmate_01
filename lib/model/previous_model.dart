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
    int? expenseId;
    String? visitFrom;
    String? visitTo;
    String? visitPurpose;
    String? expModeDesc;
    String? convModeDesc;
    double? rate;
    double? locationDistance;
    double? amount;
    String? remarks;
    String? description;
    dynamic checkedBy;
    dynamic approvedBy;
    dynamic modifiedOn;
    DateTime? submittedOn;

    ClaimDetail({
        this.expenseId,
        this.visitFrom,
        this.visitTo,
        this.visitPurpose,
        this.expModeDesc,
        this.convModeDesc,
        this.rate,
        this.locationDistance,
        this.amount,
        this.remarks,
        this.description,
        this.checkedBy,
        this.approvedBy,
        this.modifiedOn,
        this.submittedOn,
    });

    factory ClaimDetail.fromJson(Map<String, dynamic> json) => ClaimDetail(
        expenseId: json["ExpenseId"],
        visitFrom: json["VisitFrom"],
        visitTo: json["VisitTo"],
        visitPurpose: json["VisitPurpose"],
        expModeDesc: json["ExpModeDesc"],
        convModeDesc: json["ConvModeDesc"],
        rate: json["Rate"],
        locationDistance: json["LocationDistance"],
        amount: json["Amount"],
        remarks: json["Remarks"],
        description: json["Description"],
        checkedBy: json["CheckedBy"],
        approvedBy: json["ApprovedBy"],
        modifiedOn: json["ModifiedOn"],
        submittedOn: json["SubmittedOn"] == null ? null : DateTime.parse(json["SubmittedOn"]),
    );

    Map<String, dynamic> toJson() => {
        "ExpenseId": expenseId,
        "VisitFrom": visitFrom,
        "VisitTo": visitTo,
        "VisitPurpose": visitPurpose,
        "ExpModeDesc": expModeDesc,
        "ConvModeDesc": convModeDesc,
        "Rate": rate,
        "LocationDistance": locationDistance,
        "Amount": amount,
        "Remarks": remarks,
        "Description": description,
        "CheckedBy": checkedBy,
        "ApprovedBy": approvedBy,
        "ModifiedOn": modifiedOn,
        "SubmittedOn": submittedOn?.toIso8601String(),
    };
}
