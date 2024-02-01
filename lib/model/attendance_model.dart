// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) =>
    AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) =>
    json.encode(data.toJson());

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

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
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
        claimDetails: List<ClaimDetail>.from(
            json["ClaimDetails"].map((x) => ClaimDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ClaimDetails": List<dynamic>.from(claimDetails.map((x) => x.toJson())),
      };
}

class ClaimDetail {
  int totalDays;
  int workingDays;
  int present;
  int absent;
  int leave;
  int holiday;

  ClaimDetail(
      {required this.totalDays,
      required this.workingDays,
      required this.present,
      required this.absent,
      required this.leave,
      required this.holiday});

  factory ClaimDetail.fromJson(Map<String, dynamic> json) => ClaimDetail(
      totalDays: json["TotalDays"],
      workingDays: json["WorkingDays"],
      present: json["Present"],
      absent: json["Absent"],
      leave: json["Leave"],
      holiday: json['HolidayCount']);

  Map<String, dynamic> toJson() => {
        "TotalDays": totalDays,
        "WorkingDays": workingDays,
        "Present": present,
        "Absent": absent,
        "Leave": leave,
        "HolidayCount": holiday
      };
}
