// To parse this JSON data, do
//
//     final leaveModel = leaveModelFromJson(jsonString);

import 'dart:convert';

LeaveModel leaveModelFromJson(String str) => LeaveModel.fromJson(json.decode(str));

String leaveModelToJson(LeaveModel data) => json.encode(data.toJson());

class LeaveModel {
    final String? responseMessage;
    final bool? status;
    final int? dataCount;
    final Data? data;
    final String? responseCode;
    final bool? confirmationbox;

    LeaveModel({
        this.responseMessage,
        this.status,
        this.dataCount,
        this.data,
        this.responseCode,
        this.confirmationbox,
    });

    factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
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
    final List<VisitPlan>? visitPlan;

    Data({
        this.visitPlan,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        visitPlan: json["VisitPlan"] == null ? [] : List<VisitPlan>.from(json["VisitPlan"]!.map((x) => VisitPlan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "VisitPlan": visitPlan == null ? [] : List<dynamic>.from(visitPlan!.map((x) => x.toJson())),
    };
}

class VisitPlan {
    final int? employeeId;
    final String? empCode;
    final int? totalLeave;
    final int? totalApproved;
    final int? totalBalance;
    final int? totalCl;
    final int? totalSl;
    final int? totalEl;
    final int? approvedCl;
    final int? approvedSl;
    final int? approvedEl;
    final int? balanceCl;
    final int? balanceSl;
    final int? balanceEl;
    final dynamic pending;
    final dynamic approved;
    final dynamic rejected;

    VisitPlan({
        this.employeeId,
        this.empCode,
        this.totalLeave,
        this.totalApproved,
        this.totalBalance,
        this.totalCl,
        this.totalSl,
        this.totalEl,
        this.approvedCl,
        this.approvedSl,
        this.approvedEl,
        this.balanceCl,
        this.balanceSl,
        this.balanceEl,
        this.pending,
        this.approved,
        this.rejected,
    });

    factory VisitPlan.fromJson(Map<String, dynamic> json) => VisitPlan(
        employeeId: json["EmployeeID"],
        empCode: json["EMPCode"],
        totalLeave: json["Total_Leave"],
        totalApproved: json["Total_Approved"],
        totalBalance: json["Total_Balance"],
        totalCl: json["Total_CL"],
        totalSl: json["Total_SL"],
        totalEl: json["Total_EL"],
        approvedCl: json["Approved_CL"],
        approvedSl: json["Approved_SL"],
        approvedEl: json["Approved_EL"],
        balanceCl: json["Balance_CL"],
        balanceSl: json["Balance_SL"],
        balanceEl: json["Balance_EL"],
        pending: json["Pending"],
        approved: json["Approved"],
        rejected: json["Rejected"],
    );

    Map<String, dynamic> toJson() => {
        "EmployeeID": employeeId,
        "EMPCode": empCode,
        "Total_Leave": totalLeave,
        "Total_Approved": totalApproved,
        "Total_Balance": totalBalance,
        "Total_CL": totalCl,
        "Total_SL": totalSl,
        "Total_EL": totalEl,
        "Approved_CL": approvedCl,
        "Approved_SL": approvedSl,
        "Approved_EL": approvedEl,
        "Balance_CL": balanceCl,
        "Balance_SL": balanceSl,
        "Balance_EL": balanceEl,
        "Pending": pending,
        "Approved": approved,
        "Rejected": rejected,
    };
}
