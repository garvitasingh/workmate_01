// To parse this JSON data, do
//
//     final attendanceLogModel = attendanceLogModelFromJson(jsonString);

import 'dart:convert';

AttendanceLogModel attendanceLogModelFromJson(String str) => AttendanceLogModel.fromJson(json.decode(str));

String attendanceLogModelToJson(AttendanceLogModel data) => json.encode(data.toJson());

class AttendanceLogModel {
    final String? responseMessage;
    final bool? status;
    final int? dataCount;
    final Data? data;
    final String? responseCode;
    final bool? confirmationbox;

    AttendanceLogModel({
        this.responseMessage,
        this.status,
        this.dataCount,
        this.data,
        this.responseCode,
        this.confirmationbox,
    });

    factory AttendanceLogModel.fromJson(Map<String, dynamic> json) => AttendanceLogModel(
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
    final List<Attendancelog>? attendancelog;

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
    final String? empCode;
    final int? visitId;
    final String? visitLoc;
    final String? lat;
    final String? long;
    final String? address;
    final DateTime? presentTimeIn;
    final DateTime? presentTimeOut;
    final int? checkIn;
    final int? checkOut;

    Attendancelog({
        this.empCode,
        this.visitId,
        this.visitLoc,
        this.lat,
        this.long,
        this.address,
        this.presentTimeIn,
        this.presentTimeOut,
        this.checkIn,
        this.checkOut,
    });

    factory Attendancelog.fromJson(Map<String, dynamic> json) => Attendancelog(
        empCode: json["EMPCode"],
        visitId: json["VisitId"],
        visitLoc: json["VisitLoc"],
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
        "VisitId": visitId,
        "VisitLoc": visitLoc,
        "Lat": lat,
        "Long": long,
        "Address": address,
        "PresentTimeIn": presentTimeIn?.toIso8601String(),
        "PresentTimeOut": presentTimeOut?.toIso8601String(),
        "CheckIn": checkIn,
        "CheckOut": checkOut,
    };
}
