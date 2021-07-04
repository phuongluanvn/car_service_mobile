class ServiceModel {
  String id;
  String name;
  int price;
  String type;

  ServiceModel({this.id, this.name, this.price, this.type});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['type'] = this.type;
    return data;
  }
}