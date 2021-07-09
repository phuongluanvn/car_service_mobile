import 'package:car_service/utils/model/CarModel.dart';

class ManufacturerModel {
  String id;
  String name;
  List<CarModel> vehicleModels;

  ManufacturerModel({this.id, this.name, this.vehicleModels});

  ManufacturerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['vehicleModels'] != null) {
      vehicleModels = new List<CarModel>();
      json['vehicleModels'].forEach((v) {
        vehicleModels.add(new CarModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.vehicleModels != null) {
      data['vehicleModels'] =
          this.vehicleModels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}