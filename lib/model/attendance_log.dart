// To parse this JSON data, do
//
//     final attendanceLogModel = attendanceLogModelFromJson(jsonString);

import 'dart:convert';

AttendanceLogModel attendanceLogModelFromJson(String str) => AttendanceLogModel.fromJson(json.decode(str));

String attendanceLogModelToJson(AttendanceLogModel data) => json.encode(data.toJson());

class AttendanceLogModel {
    String responseMessage;
    bool status;
    int dataCount;
    Data data;
    String responseCode;
    bool confirmationbox;

    AttendanceLogModel({
        required this.responseMessage,
        required this.status,
        required this.dataCount,
        required this.data,
        required this.responseCode,
        required this.confirmationbox,
    });

    factory AttendanceLogModel.fromJson(Map<String, dynamic> json) => AttendanceLogModel(
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
    List<Attendancelog> attendancelog;

    Data({
        required this.attendancelog,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        attendancelog: List<Attendancelog>.from(json["Attendancelog"].map((x) => Attendancelog.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Attendancelog": List<dynamic>.from(attendancelog.map((x) => x.toJson())),
    };
}

class Attendancelog {
    String empCode;
    String visitLoc;
    String visitId;
    String lat;
    String long;
    String address;
    DateTime? presentTimeIn;
    DateTime? presentTimeOut;
    int checkIn;
    int checkOut;

    Attendancelog({
        required this.empCode,
        required this.visitLoc,
        required this.visitId,
        required this.lat,
        required this.long,
        required this.address,
        required this.presentTimeIn,
        required this.presentTimeOut,
        required this.checkIn,
        required this.checkOut,
    });

    factory Attendancelog.fromJson(Map<String, dynamic> json) => Attendancelog(
        empCode: json["EMPCode"],
        visitLoc: json["VisitLoc"],
        visitId: json["VisitId"],
        lat: json["Lat"],
        long: json["Long"],
        address: json["Address"],
        presentTimeIn: json["PresentTimeIn"] == null ? null : DateTime.parse(json["PresentTimeIn"]),
        presentTimeOut: json["PresentTimeOut"] == null ? null : DateTime.parse(json["PresentTimeOut"]),
        checkIn: json["CheckIn"],
        checkOut: json["CheckOut"],
    );

    Map<String, dynamic> toJson() => {
        "EMPCode": empCode,
        "VisitLoc": visitLoc,
        "VisitId": visitId,
        "Lat": lat,
        "Long": long,
        "Address": address,
        "PresentTimeIn": presentTimeIn?.toIso8601String(),
        "PresentTimeOut": presentTimeOut?.toIso8601String(),
        "CheckIn": checkIn,
        "CheckOut": checkOut,
    };
}
