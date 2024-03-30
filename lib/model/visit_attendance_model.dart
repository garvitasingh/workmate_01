// To parse this JSON data, do
//
//     final visitAttendanceModel = visitAttendanceModelFromJson(jsonString);

import 'dart:convert';

VisitAttendanceModel visitAttendanceModelFromJson(String str) => VisitAttendanceModel.fromJson(json.decode(str));

String visitAttendanceModelToJson(VisitAttendanceModel data) => json.encode(data.toJson());

class VisitAttendanceModel {
    final String? responseMessage;
    final bool? status;
    final int? dataCount;
    final Data? data;
    final String? responseCode;
    final bool? confirmationbox;

    VisitAttendanceModel({
        this.responseMessage,
        this.status,
        this.dataCount,
        this.data,
        this.responseCode,
        this.confirmationbox,
    });

    factory VisitAttendanceModel.fromJson(Map<String, dynamic> json) => VisitAttendanceModel(
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
    final List<VisitAttendance>? visitAttendance;

    Data({
        this.visitAttendance,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        visitAttendance: json["VisitAttendance"] == null ? [] : List<VisitAttendance>.from(json["VisitAttendance"]!.map((x) => VisitAttendance.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "VisitAttendance": visitAttendance == null ? [] : List<dynamic>.from(visitAttendance!.map((x) => x.toJson())),
    };
}

class VisitAttendance {
    final String? empCode;
    final String? visitId;
    final DateTime? attendanceDate;
    final int? checkIn;
    final int? checkOut;
    final DateTime? checkInTime;
    final dynamic checkOutTime;
    final String? checkInAddress;
    final dynamic checkOutAddress;
    final String? checkInImage;
    final dynamic checkoutImage;

    VisitAttendance({
        this.empCode,
        this.visitId,
        this.attendanceDate,
        this.checkIn,
        this.checkOut,
        this.checkInTime,
        this.checkOutTime,
        this.checkInAddress,
        this.checkOutAddress,
        this.checkInImage,
        this.checkoutImage,
    });

    factory VisitAttendance.fromJson(Map<String, dynamic> json) => VisitAttendance(
        empCode: json["EMPCode"],
        visitId: json["VisitId"],
        attendanceDate: json["AttendanceDate"] == null ? null : DateTime.parse(json["AttendanceDate"]),
        checkIn: json["CheckIn"],
        checkOut: json["CheckOut"],
        checkInTime: json["CheckInTime"] == null ? null : DateTime.parse(json["CheckInTime"]),
        checkOutTime: json["CheckOutTime"],
        checkInAddress: json["CheckInAddress"],
        checkOutAddress: json["CheckOutAddress"],
        checkInImage: json["CheckInImage"],
        checkoutImage: json["CheckoutImage"],
    );

    Map<String, dynamic> toJson() => {
        "EMPCode": empCode,
        "VisitId": visitId,
        "AttendanceDate": attendanceDate?.toIso8601String(),
        "CheckIn": checkIn,
        "CheckOut": checkOut,
        "CheckInTime": checkInTime?.toIso8601String(),
        "CheckOutTime": checkOutTime,
        "CheckInAddress": checkInAddress,
        "CheckOutAddress": checkOutAddress,
        "CheckInImage": checkInImage,
        "CheckoutImage": checkoutImage,
    };
}
