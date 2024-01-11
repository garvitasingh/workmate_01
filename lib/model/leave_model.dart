class LeaveModel {
  int? leaves;
  int? sL;
  int? cL;
  int? pL;
  int? pending;
  int? approved;
  int? rejected;

  LeaveModel(
      {this.leaves,
        this.sL,
        this.cL,
        this.pL,
        this.pending,
        this.approved,
        this.rejected});

  LeaveModel.fromJson(Map<String, dynamic> json) {
    leaves = json['Leaves'];
    sL = json['SL'];
    cL = json['CL'];
    pL = json['PL'];
    pending = json['Pending'];
    approved = json['Approved'];
    rejected = json['Rejected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Leaves'] = this.leaves;
    data['SL'] = this.sL;
    data['CL'] = this.cL;
    data['PL'] = this.pL;
    data['Pending'] = this.pending;
    data['Approved'] = this.approved;
    data['Rejected'] = this.rejected;
    return data;
  }
}
