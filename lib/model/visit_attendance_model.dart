// To parse this JSON data, do
//
//     final visitAttendanceModel = visitAttendanceModelFromJson(jsonString);

import 'dart:convert';

VisitAttendanceModel visitAttendanceModelFromJson(String str) => VisitAttendanceModel.fromJson(json.decode(str));

String visitAttendanceModelToJson(VisitAttendanceModel data) => json.encode(data.toJson());

class VisitAttendanceModel {
    String responseMessage;
    bool status;
    int dataCount;
    Data data;
    String responseCode;
    bool confirmationbox;

    VisitAttendanceModel({
        required this.responseMessage,
        required this.status,
        required this.dataCount,
        required this.data,
        required this.responseCode,
        required this.confirmationbox,
    });

    factory VisitAttendanceModel.fromJson(Map<String, dynamic> json) => VisitAttendanceModel(
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
    List<VisitAttendance> visitAttendance;

    Data({
        required this.visitAttendance,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        visitAttendance: List<VisitAttendance>.from(json["VisitAttendance"].map((x) => VisitAttendance.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "VisitAttendance": List<dynamic>.from(visitAttendance.map((x) => x.toJson())),
    };
}

class VisitAttendance {
    String empCode;
    int visitId;
    DateTime attendanceDate;
    int checkIn;
    int checkOut;
    String checkInTime;
    dynamic checkOutTime;

    VisitAttendance({
        required this.empCode,
        required this.visitId,
        required this.attendanceDate,
        required this.checkIn,
        required this.checkOut,
        required this.checkInTime,
        required this.checkOutTime,
    });

    factory VisitAttendance.fromJson(Map<String, dynamic> json) => VisitAttendance(
        empCode: json["EMPCode"],
        visitId: json["VisitId"],
        attendanceDate: DateTime.parse(json["AttendanceDate"]),
        checkIn: json["CheckIn"],
        checkOut: json["CheckOut"],
        checkInTime: json["CheckInTime"],
        checkOutTime: json["CheckOutTime"],
    );

    Map<String, dynamic> toJson() => {
        "EMPCode": empCode,
        "VisitId": visitId,
        "AttendanceDate": attendanceDate.toIso8601String(),
        "CheckIn": checkIn,
        "CheckOut": checkOut,
        "CheckInTime": checkInTime,
        "CheckOutTime": checkOutTime,
    };
}
