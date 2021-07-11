class ManufacturerModel {
  String id;
  String name;
  List<String> vehicleModels;

  ManufacturerModel({this.id, this.name, this.vehicleModels});

  ManufacturerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    vehicleModels = json['vehicleModels'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['vehicleModels'] = this.vehicleModels;
    return data;
  }
}