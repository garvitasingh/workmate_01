// To parse this JSON data, do
//
//     final leaveModel = leaveModelFromJson(jsonString);


import 'dart:convert';

LeaveModel leaveModelFromJson(String str) => LeaveModel.fromJson(json.decode(str));

String leaveModelToJson(LeaveModel data) => json.encode(data.toJson());

class LeaveModel {
    String responseMessage;
    bool status;
    int dataCount;
    Data data;
    String responseCode;
    bool confirmationbox;

    LeaveModel({
        required this.responseMessage,
        required this.status,
        required this.dataCount,
        required this.data,
        required this.responseCode,
        required this.confirmationbox,
    });

    factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
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
    List<VisitPlan> visitPlan;

    Data({
        required this.visitPlan,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        visitPlan: List<VisitPlan>.from(json["VisitPlan"].map((x) => VisitPlan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "VisitPlan": List<dynamic>.from(visitPlan.map((x) => x.toJson())),
    };
}

class VisitPlan {
    int employeeId;
    String empCode;
    int totalLeave;
    int totalApproved;
    int totalBalance;
    int totalCl;
    int totalSl;
    int totalEl;
    int approvedCl;
    int approvedSl;
    int approvedEl;
    int balanceCl;
    int balanceSl;
    int balanceEl;
    int pending;
    int approved;
    int rejected;

    VisitPlan({
        required this.employeeId,
        required this.empCode,
        required this.totalLeave,
        required this.totalApproved,
        required this.totalBalance,
        required this.totalCl,
        required this.totalSl,
        required this.totalEl,
        required this.approvedCl,
        required this.approvedSl,
        required this.approvedEl,
        required this.balanceCl,
        required this.balanceSl,
        required this.balanceEl,
        required this.pending,
        required this.approved,
        required this.rejected,
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
