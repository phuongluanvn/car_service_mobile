class ManufacturerModel {
  String id;
  String name;
  String imageUrl;
  List<VehicleModels> vehicleModels;

  ManufacturerModel({this.id, this.name, this.imageUrl, this.vehicleModels});

  ManufacturerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    if (json['vehicleModels'] != null) {
      vehicleModels = new List<VehicleModels>();
      json['vehicleModels'].forEach((v) {
        vehicleModels.add(new VehicleModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    if (this.vehicleModels != null) {
      data['vehicleModels'] =
          this.vehicleModels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleModels {
  String id;
  String name;
  String imageUrl;

  VehicleModels({this.id, this.name, this.imageUrl});

  VehicleModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
