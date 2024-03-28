// To parse this JSON data, do
//
//     final aboutAppModel = aboutAppModelFromJson(jsonString);

import 'dart:convert';

AboutAppModel aboutAppModelFromJson(String str) => AboutAppModel.fromJson(json.decode(str));

String aboutAppModelToJson(AboutAppModel data) => json.encode(data.toJson());

class AboutAppModel {
    String responseMessage;
    bool status;
    int dataCount;
    Data data;
    String responseCode;
    bool confirmationbox;

    AboutAppModel({
        required this.responseMessage,
        required this.status,
        required this.dataCount,
        required this.data,
        required this.responseCode,
        required this.confirmationbox,
    });

    factory AboutAppModel.fromJson(Map<String, dynamic> json) => AboutAppModel(
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
    List<Info> info;

    Data({
        required this.info,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        info: List<Info>.from(json["Info"].map((x) => Info.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Info": List<dynamic>.from(info.map((x) => x.toJson())),
    };
}

class Info {
    String clientName;
    String productName;
    String copyrightName;
    String appName;
    String productIcon;

    Info({
        required this.clientName,
        required this.productName,
        required this.copyrightName,
        required this.appName,
        required this.productIcon,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        clientName: json["ClientName"],
        productName: json["ProductName"],
        copyrightName: json["CopyrightName"],
        appName: json["AppName"],
        productIcon: json["ProductIcon"],
    );

    Map<String, dynamic> toJson() => {
        "ClientName": clientName,
        "ProductName": productName,
        "CopyrightName": copyrightName,
        "AppName": appName,
        "ProductIcon": productIcon,
    };
}
