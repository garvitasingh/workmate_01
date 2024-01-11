class MenuModel {
  int? id;
  String? name;
  String? icon;

  MenuModel({this.id, this.name, this.icon});

  MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    icon = json['Icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Icon'] = this.icon;
    return data;
  }
}
