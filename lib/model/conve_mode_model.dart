// To parse this JSON data, do
//
//     final convModeModel = convModeModelFromJson(jsonString);

import 'dart:convert';

ConvModeModel convModeModelFromJson(String str) => ConvModeModel.fromJson(json.decode(str));

String convModeModelToJson(ConvModeModel data) => json.encode(data.toJson());

class ConvModeModel {
    String responseMessage;
    bool status;
    int dataCount;
    Data data;
    String responseCode;
    bool confirmationbox;

    ConvModeModel({
        required this.responseMessage,
        required this.status,
        required this.dataCount,
        required this.data,
        required this.responseCode,
        required this.confirmationbox,
    });

    factory ConvModeModel.fromJson(Map<String, dynamic> json) => ConvModeModel(
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
        visitPlan: List<VisitPlan>.from(json["VisitPlan"].map((x) => VisitPlan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "VisitPlan": List<dynamic>.from(visitPlan.map((x) => x.toJson())),
    };
}

class VisitPlan {
    int convModeId;
    String convModeDesc;
    int rate;

    VisitPlan({
        required this.convModeId,
        required this.convModeDesc,
        required this.rate,
    });

    factory VisitPlan.fromJson(Map<String, dynamic> json) => VisitPlan(
        convModeId: json["ConvModeId"],
        convModeDesc: json["ConvModeDesc"],
        rate: json["Rate"],
    );

    Map<String, dynamic> toJson() => {
        "ConvModeId": convModeId,
        "ConvModeDesc": convModeDesc,
        "Rate": rate,
    };
}
