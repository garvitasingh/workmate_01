class AttendanceModel {
  int? present;
  int? absent;
  int? leave;
  int? workingDay;

  AttendanceModel({this.present, this.absent, this.leave, this.workingDay});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    present = json['Present'];
    absent = json['Absent'];
    leave = json['Leave'];
    workingDay = json['WorkingDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Present'] = this.present;
    data['Absent'] = this.absent;
    data['Leave'] = this.leave;
    data['WorkingDay'] = this.workingDay;
    return data;
  }
}
