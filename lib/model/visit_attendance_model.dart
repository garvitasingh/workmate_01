// To parse this JSON data, do
//
//     final visitAttendanceModel = visitAttendanceModelFromJson(jsonString);

import 'dart:convert';

VisitAttendanceModel visitAttendanceModelFromJson(String str) => VisitAttendanceModel.fromJson(json.decode(str));

String visitAttendanceModelToJson(VisitAttendanceModel data) => json.encode(data.toJson());

class VisitAttendanceModel {
    String? responseMessage;
    bool? status;
    int? dataCount;
    Data? data;
    String? responseCode;
    bool? confirmationbox;

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
    List<VisitAttendance>? visitAttendance;

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
    String? empCode;
    String? visitId;
    DateTime? attendanceDate;
    int? checkIn;
    int? checkOut;
    DateTime? presentTimeIn;
    DateTime? presentTimeOut;
    String? checkInAddress;
    String? checkInAddressImage;
    String? checkOutAddress;
    String? checkOutAddressImage;

    VisitAttendance({
        this.empCode,
        this.visitId,
        this.attendanceDate,
        this.checkIn,
        this.checkOut,
        this.presentTimeIn,
        this.presentTimeOut,
        this.checkInAddress,
        this.checkInAddressImage,
        this.checkOutAddress,
        this.checkOutAddressImage,
    });

    factory VisitAttendance.fromJson(Map<String, dynamic> json) => VisitAttendance(
        empCode: json["EMPCode"],
        visitId: json["VisitId"],
        attendanceDate: json["AttendanceDate"] == null ? null : DateTime.parse(json["AttendanceDate"]),
        checkIn: json["CheckIn"],
        checkOut: json["CheckOut"],
        presentTimeIn: json["PresentTimeIn"] == null ? null : DateTime.parse(json["PresentTimeIn"]),
        presentTimeOut: json["PresentTimeOut"] == null ? null : DateTime.parse(json["PresentTimeOut"]),
        checkInAddress: json["CheckInAddress"],
        checkInAddressImage: json["CheckInAddressImage"],
        checkOutAddress: json["CheckOutAddress"],
        checkOutAddressImage: json["CheckOutAddressImage"],
    );

    Map<String, dynamic> toJson() => {
        "EMPCode": empCode,
        "VisitId": visitId,
        "AttendanceDate": attendanceDate?.toIso8601String(),
        "CheckIn": checkIn,
        "CheckOut": checkOut,
        "PresentTimeIn": presentTimeIn?.toIso8601String(),
        "PresentTimeOut": presentTimeOut?.toIso8601String(),
        "CheckInAddress": checkInAddress,
        "CheckInAddressImage": checkInAddressImage,
        "CheckOutAddress": checkOutAddress,
        "CheckOutAddressImage": checkOutAddressImage,
    };
}
