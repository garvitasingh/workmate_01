// To parse this JSON data, do
//
//     final monthlyAttendance = monthlyAttendanceFromJson(jsonString);

import 'dart:convert';

MonthlyAttendance monthlyAttendanceFromJson(String str) => MonthlyAttendance.fromJson(json.decode(str));

String monthlyAttendanceToJson(MonthlyAttendance data) => json.encode(data.toJson());

class MonthlyAttendance {
    String? responseMessage;
    bool? status;
    int? dataCount;
    Data? data;
    String? responseCode;
    bool? confirmationbox;

    MonthlyAttendance({
        this.responseMessage,
        this.status,
        this.dataCount,
        this.data,
        this.responseCode,
        this.confirmationbox,
    });

    factory MonthlyAttendance.fromJson(Map<String, dynamic> json) => MonthlyAttendance(
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
    VisitAttendance? visitAttendance;

    Data({
        this.visitAttendance,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        visitAttendance: json["VisitAttendance"] == null ? null : VisitAttendance.fromJson(json["VisitAttendance"]),
    );

    Map<String, dynamic> toJson() => {
        "VisitAttendance": visitAttendance?.toJson(),
    };
}

class VisitAttendance {
    List<Absent>? present;
    List<Absent>? leave;
    List<Absent>? absent;
    List<Absent>? holiday;

    VisitAttendance({
        this.present,
        this.leave,
        this.absent,
        this.holiday,
    });

    factory VisitAttendance.fromJson(Map<String, dynamic> json) => VisitAttendance(
        present: json["Present"] == null ? [] : List<Absent>.from(json["Present"]!.map((x) => Absent.fromJson(x))),
        leave: json["Leave"] == null ? [] : List<Absent>.from(json["Leave"]!.map((x) => Absent.fromJson(x))),
        absent: json["Absent"] == null ? [] : List<Absent>.from(json["Absent"]!.map((x) => Absent.fromJson(x))),
        holiday: json["Holiday"] == null ? [] : List<Absent>.from(json["Holiday"]!.map((x) => Absent.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Present": present == null ? [] : List<dynamic>.from(present!.map((x) => x.toJson())),
        "Leave": leave == null ? [] : List<dynamic>.from(leave!.map((x) => x.toJson())),
        "Absent": absent == null ? [] : List<dynamic>.from(absent!.map((x) => x.toJson())),
        "Holiday": holiday == null ? [] : List<dynamic>.from(holiday!.map((x) => x.toJson())),
    };
}

class Absent {
    int? id;
    String? absentDate;
    EmpCode? empCode;
    TableName? tableName;
    String? holidayDate;
    String? leaveDate;
    String? presentDate;

    Absent({
        this.id,
        this.absentDate,
        this.empCode,
        this.tableName,
        this.holidayDate,
        this.leaveDate,
        this.presentDate,
    });

    factory Absent.fromJson(Map<String, dynamic> json) => Absent(
        id: json["Id"],
        absentDate: json["AbsentDate"],
        empCode: empCodeValues.map[json["EMPCode"]]!,
        tableName: tableNameValues.map[json["TableName"]]!,
        holidayDate: json["HolidayDate"],
        leaveDate: json["LeaveDate"],
        presentDate: json["PresentDate"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "AbsentDate": absentDate,
        "EMPCode": empCodeValues.reverse[empCode],
        "TableName": tableNameValues.reverse[tableName],
        "HolidayDate": holidayDate,
        "LeaveDate": leaveDate,
        "PresentDate": presentDate,
    };
}

enum EmpCode {
    IT001
}

final empCodeValues = EnumValues({
    "IT001": EmpCode.IT001
});

enum TableName {
    ABSENT,
    HOLIDAY,
    LEAVE,
    PRESENT
}

final tableNameValues = EnumValues({
    "Absent": TableName.ABSENT,
    "Holiday": TableName.HOLIDAY,
    "Leave": TableName.LEAVE,
    "Present": TableName.PRESENT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
