class CustomerModel {
  String username;
  String email;
  String fullname;
  String phoneNumber;
  String address;
  int accumulatedPoint;
  List<Vehicles> vehicles;

  CustomerModel(
      {this.username,
      this.email,
      this.fullname,
      this.phoneNumber,
      this.address,
      this.accumulatedPoint,
      this.vehicles});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    fullname = json['fullname'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    accumulatedPoint = json['accumulatedPoint'];
    if (json['vehicles'] != null) {
      vehicles = new List<Vehicles>();
      json['vehicles'].forEach((v) {
        vehicles.add(new Vehicles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['fullname'] = this.fullname;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['accumulatedPoint'] = this.accumulatedPoint;
    if (this.vehicles != null) {
      data['vehicles'] = this.vehicles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vehicles {
  String id;
  String manufacturer;
  String model;
  String licensePlate;
  String dateOfLastMaintenance;
  int millageCount;

  Vehicles(
      {this.id,
      this.manufacturer,
      this.model,
      this.licensePlate,
      this.dateOfLastMaintenance,
      this.millageCount});

  Vehicles.fromJson(Map<String, dynamic> json) {
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
