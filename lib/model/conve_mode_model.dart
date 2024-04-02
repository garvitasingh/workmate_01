// To parse this JSON data, do
//
//     final convModeModel = convModeModelFromJson(jsonString);

import 'dart:convert';

ConvModeModel convModeModelFromJson(String str) => ConvModeModel.fromJson(json.decode(str));

String convModeModelToJson(ConvModeModel data) => json.encode(data.toJson());

class ConvModeModel {
    String? responseMessage;
    bool? status;
    int? dataCount;
    List<Datum>? data;
    String? responseCode;
    bool? confirmationbox;

    ConvModeModel({
        this.responseMessage,
        this.status,
        this.dataCount,
        this.data,
        this.responseCode,
        this.confirmationbox,
    });

    factory ConvModeModel.fromJson(Map<String, dynamic> json) => ConvModeModel(
        responseMessage: json["ResponseMessage"],
        status: json["Status"],
        dataCount: json["DataCount"],
        data: json["Data"] == null ? [] : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
        responseCode: json["ResponseCode"],
        confirmationbox: json["confirmationbox"],
    );

    Map<String, dynamic> toJson() => {
        "ResponseMessage": responseMessage,
        "Status": status,
        "DataCount": dataCount,
        "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "confirmationbox": confirmationbox,
    };
}

class Datum {
    int? convModeId;
    String? convModeDesc;
    int? rate;
    int? isActive;

    Datum({
        this.convModeId,
        this.convModeDesc,
        this.rate,
        this.isActive,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        convModeId: json["ConvModeId"],
        convModeDesc: json["ConvModeDesc"],
        rate: json["Rate"],
        isActive: json["IsActive"],
    );

    Map<String, dynamic> toJson() => {
        "ConvModeId": convModeId,
        "ConvModeDesc": convModeDesc,
        "Rate": rate,
        "IsActive": isActive,
    };
}
