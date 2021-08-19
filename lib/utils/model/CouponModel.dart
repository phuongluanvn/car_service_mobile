class CouponModel {
  String id;
  String name;
  String description;
  int value;
  int pointRequired;

  CouponModel(
      {this.id, this.name, this.description, this.value, this.pointRequired});

  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    value = json['value'];
    pointRequired = json['pointRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['value'] = this.value;
    data['pointRequired'] = this.pointRequired;
    return data;
  }
}
