// To parse this JSON data, do
//
//     final lastCheckInModel = lastCheckInModelFromJson(jsonString);

import 'dart:convert';

LastCheckInModel lastCheckInModelFromJson(String str) => LastCheckInModel.fromJson(json.decode(str));

String lastCheckInModelToJson(LastCheckInModel data) => json.encode(data.toJson());

class LastCheckInModel {
    String? responseMessage;
    bool? status;
    int? dataCount;
    Data? data;
    String? responseCode;
    bool? confirmationbox;

    LastCheckInModel({
        this.responseMessage,
        this.status,
        this.dataCount,
        this.data,
        this.responseCode,
        this.confirmationbox,
    });

    factory LastCheckInModel.fromJson(Map<String, dynamic> json) => LastCheckInModel(
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
    List<LastVisitAttendance>? lastVisitAttendance;

    Data({
        this.lastVisitAttendance,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        lastVisitAttendance: json["LastVisitAttendance"] == null ? [] : List<LastVisitAttendance>.from(json["LastVisitAttendance"]!.map((x) => LastVisitAttendance.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "LastVisitAttendance": lastVisitAttendance == null ? [] : List<dynamic>.from(lastVisitAttendance!.map((x) => x.toJson())),
    };
}

class LastVisitAttendance {
    DateTime? visitDate;
    DateTime? fromDate;
    DateTime? toDate;
    String? visitPurpose;
    String? visitFrom;
    String? visitTo;
    String? empCode;
    String? visitId;
    DateTime? attendanceDate;
    int? checkIn;
    int? checkOut;
    DateTime? presentTimeIn;
    dynamic presentTimeOut;
    String? checkInAddress;
    String? checkInAddressImage;
    dynamic checkOutAddress;
    dynamic checkOutAddressImage;

    LastVisitAttendance({
        this.visitDate,
        this.fromDate,
        this.toDate,
        this.visitPurpose,
        this.visitFrom,
        this.visitTo,
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

    factory LastVisitAttendance.fromJson(Map<String, dynamic> json) => LastVisitAttendance(
        visitDate: json["VisitDate"] == null ? null : DateTime.parse(json["VisitDate"]),
        fromDate: json["FromDate"] == null ? null : DateTime.parse(json["FromDate"]),
        toDate: json["ToDate"] == null ? null : DateTime.parse(json["ToDate"]),
        visitPurpose: json["VisitPurpose"],
        visitFrom: json["VisitFrom"],
        visitTo: json["VisitTo"],
        empCode: json["EMPCode"],
        visitId: json["VisitId"],
        attendanceDate: json["AttendanceDate"] == null ? null : DateTime.parse(json["AttendanceDate"]),
        checkIn: json["CheckIn"],
        checkOut: json["CheckOut"],
        presentTimeIn: json["PresentTimeIn"] == null ? null : DateTime.parse(json["PresentTimeIn"]),
        presentTimeOut: json["PresentTimeOut"],
        checkInAddress: json["CheckInAddress"],
        checkInAddressImage: json["CheckInAddressImage"],
        checkOutAddress: json["CheckOutAddress"],
        checkOutAddressImage: json["CheckOutAddressImage"],
    );

    Map<String, dynamic> toJson() => {
        "VisitDate": visitDate?.toIso8601String(),
        "FromDate": fromDate?.toIso8601String(),
        "ToDate": toDate?.toIso8601String(),
        "VisitPurpose": visitPurpose,
        "VisitFrom": visitFrom,
        "VisitTo": visitTo,
        "EMPCode": empCode,
        "VisitId": visitId,
        "AttendanceDate": attendanceDate?.toIso8601String(),
        "CheckIn": checkIn,
        "CheckOut": checkOut,
        "PresentTimeIn": presentTimeIn?.toIso8601String(),
        "PresentTimeOut": presentTimeOut,
        "CheckInAddress": checkInAddress,
        "CheckInAddressImage": checkInAddressImage,
        "CheckOutAddress": checkOutAddress,
        "CheckOutAddressImage": checkOutAddressImage,
    };
}
