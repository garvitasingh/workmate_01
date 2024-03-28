// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) => AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) => json.encode(data.toJson());

class AttendanceModel {
    String responseMessage;
    bool status;
    int dataCount;
    Data data;
    String responseCode;
    bool confirmationbox;

    AttendanceModel({
        required this.responseMessage,
        required this.status,
        required this.dataCount,
        required this.data,
        required this.responseCode,
        required this.confirmationbox,
    });

    factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
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
    List<MyAttendance> myAttendance;

    Data({
        required this.myAttendance,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        myAttendance: List<MyAttendance>.from(json["MyAttendance"].map((x) => MyAttendance.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "MyAttendance": List<dynamic>.from(myAttendance.map((x) => x.toJson())),
    };
}

class MyAttendance {
    int totalDays;
    int workingDays;
    int present;
    int absent;
    int leave;
    int holidayCount;

    MyAttendance({
        required this.totalDays,
        required this.workingDays,
        required this.present,
        required this.absent,
        required this.leave,
        required this.holidayCount,
    });

    factory MyAttendance.fromJson(Map<String, dynamic> json) => MyAttendance(
        totalDays: json["TotalDays"],
        workingDays: json["WorkingDays"],
        present: json["Present"],
        absent: json["Absent"],
        leave: json["Leave"],
        holidayCount: json["HolidayCount"],
    );

    Map<String, dynamic> toJson() => {
        "TotalDays": totalDays,
        "WorkingDays": workingDays,
        "Present": present,
        "Absent": absent,
        "Leave": leave,
        "HolidayCount": holidayCount,
    };
}
