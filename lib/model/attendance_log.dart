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
    List<Attendancelog>? attendancelog;

    Data({
        this.attendancelog,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        attendancelog: json["Attendancelog"] == null ? [] : List<Attendancelog>.from(json["Attendancelog"]!.map((x) => Attendancelog.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Attendancelog": attendancelog == null ? [] : List<dynamic>.from(attendancelog!.map((x) => x.toJson())),
    };
}

class Attendancelog {
    String? empCode;
    String? visitLoc;
    String? visitId;
    String? lat;
    String? long;
    String? checkInAddress;
    DateTime? presentTimeIn;
    DateTime? presentTimeOut;
    int? checkIn;
    int? checkOut;

    Attendancelog({
        this.empCode,
        this.visitLoc,
        this.visitId,
        this.lat,
        this.long,
        this.checkInAddress,
        this.presentTimeIn,
        this.presentTimeOut,
        this.checkIn,
        this.checkOut,
    });

    factory Attendancelog.fromJson(Map<String, dynamic> json) => Attendancelog(
        empCode: json["EMPCode"],
        visitLoc: json["VisitLoc"],
        visitId: json["VisitId"],
        lat: json["Lat"],
        long: json["Long"],
        checkInAddress: json["CheckInAddress"],
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
        "CheckInAddress": checkInAddress,
        "PresentTimeIn": presentTimeIn?.toIso8601String(),
        "PresentTimeOut": presentTimeOut?.toIso8601String(),
        "CheckIn": checkIn,
        "CheckOut": checkOut,
    };
}
