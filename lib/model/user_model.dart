// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    String responseMessage;
    bool status;
    int dataCount;
    Data data;
    String responseCode;
    bool confirmationbox;

    UserData({
        required this.responseMessage,
        required this.status,
        required this.dataCount,
        required this.data,
        required this.responseCode,
        required this.confirmationbox,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
    String name;
    String userName;
    String empCode;
    String mobileNo;

    Data({
        required this.name,
        required this.userName,
        required this.empCode,
        required this.mobileNo,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["Name"],
        userName: json["UserName"],
        empCode: json["EmpCode"],
        mobileNo: json["MobileNo"],
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "UserName": userName,
        "EmpCode": empCode,
        "MobileNo": mobileNo,
    };
}
