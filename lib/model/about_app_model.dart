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
    List<ClaimDetail> claimDetails;

    Data({
        required this.claimDetails,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        claimDetails: List<ClaimDetail>.from(json["ClaimDetails"].map((x) => ClaimDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ClaimDetails": List<dynamic>.from(claimDetails.map((x) => x.toJson())),
    };
}

class ClaimDetail {
    String clientName;
    String productName;
    String copyrightName;
    String appName;
    String productIcon;

    ClaimDetail({
        required this.clientName,
        required this.productName,
        required this.copyrightName,
        required this.appName,
        required this.productIcon,
    });

    factory ClaimDetail.fromJson(Map<String, dynamic> json) => ClaimDetail(
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
