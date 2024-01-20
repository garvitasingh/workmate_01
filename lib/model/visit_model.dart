// ignore_for_file: prefer_collection_literals

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
    // ignore: unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VisitPurpose'] = visitPurpose;
    data['Date'] = date;
    data['Source'] = source;
    data['Destination'] = destination;
    return data;
  }
}
