class VisitModel {
  String? visitPurpose;
  String? date;
  String? source;
  String? destination;

  VisitModel({this.visitPurpose, this.date, this.source, this.destination});

  VisitModel.fromJson(Map<String, dynamic> json) {
    visitPurpose = json['VisitPurpose'];
    date = json['Date'];
    source = json['Source'];
    destination = json['Destination'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VisitPurpose'] = this.visitPurpose;
    data['Date'] = this.date;
    data['Source'] = this.source;
    data['Destination'] = this.destination;
    return data;
  }
}
