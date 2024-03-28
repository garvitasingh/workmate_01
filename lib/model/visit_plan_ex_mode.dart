// To parse this JSON data, do
//
//     final visitPlanExpModel = visitPlanExpModelFromJson(jsonString);

import 'dart:convert';

VisitPlanExpModel visitPlanExpModelFromJson(String str) => VisitPlanExpModel.fromJson(json.decode(str));

String visitPlanExpModelToJson(VisitPlanExpModel data) => json.encode(data.toJson());

class VisitPlanExpModel {
    String? responseMessage;
    bool? status;
    int? dataCount;
    Data? data;
    String? responseCode;
    bool? confirmationbox;

    VisitPlanExpModel({
        this.responseMessage,
        this.status,
        this.dataCount,
        this.data,
        this.responseCode,
        this.confirmationbox,
    });

    factory VisitPlanExpModel.fromJson(Map<String, dynamic> json) => VisitPlanExpModel(
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
    List<VisitPlan>? visitPlan;

    Data({
        this.visitPlan,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        visitPlan: json["MstExpMode"] == null ? [] : List<VisitPlan>.from(json["MstExpMode"]!.map((x) => VisitPlan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "MstExpMode": visitPlan == null ? [] : List<dynamic>.from(visitPlan!.map((x) => x.toJson())),
    };
}

class VisitPlan {
    int? ddlId;
    String? ddlDesc;

    VisitPlan({
        this.ddlId,
        this.ddlDesc,
    });

    factory VisitPlan.fromJson(Map<String, dynamic> json) => VisitPlan(
        ddlId: json["ddlId"],
        ddlDesc: json["ddlDesc"],
    );

    Map<String, dynamic> toJson() => {
        "ddlId": ddlId,
        "ddlDesc": ddlDesc,
    };
}
