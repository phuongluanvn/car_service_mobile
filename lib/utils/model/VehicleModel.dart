class VehicleModel {
  String id;
  String manufacturer;
  String model;
  String licensePlate;
  Null dateOfLastMaintenance;
  int millageCount;

  VehicleModel(
      {this.id,
      this.manufacturer,
      this.model,
      this.licensePlate,
      this.dateOfLastMaintenance,
      this.millageCount});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    manufacturer = json['manufacturer'];
    model = json['model'];
    licensePlate = json['licensePlate'];
    dateOfLastMaintenance = json['dateOfLastMaintenance'];
    millageCount = json['millageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['manufacturer'] = this.manufacturer;
    data['model'] = this.model;
    data['licensePlate'] = this.licensePlate;
    data['dateOfLastMaintenance'] = this.dateOfLastMaintenance;
    data['millageCount'] = this.millageCount;
    return data;
  }
}
