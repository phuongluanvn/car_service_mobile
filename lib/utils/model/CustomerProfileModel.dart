class CustomerProfileModel {
  String username;
  String email;
  String fullname;
  String phoneNumber;
  String address;
  int accumulatedPoint;
  bool isBanned;
  List<Vehicles> vehicles;
  List<Notifications> notifications;

  CustomerProfileModel(
      {this.username,
      this.email,
      this.fullname,
      this.phoneNumber,
      this.address,
      this.accumulatedPoint,
      this.isBanned,
      this.vehicles,
      this.notifications});

  CustomerProfileModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    fullname = json['fullname'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    accumulatedPoint = json['accumulatedPoint'];
    isBanned = json['isBanned'];
    if (json['vehicles'] != null) {
      vehicles = new List<Vehicles>();
      json['vehicles'].forEach((v) {
        vehicles.add(new Vehicles.fromJson(v));
      });
    }
    if (json['notifications'] != null) {
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
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
    data['isBanned'] = this.isBanned;
    if (this.vehicles != null) {
      data['vehicles'] = this.vehicles.map((v) => v.toJson()).toList();
    }
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vehicles {
  String id;
  String manufacturer;
  String model;
  String licensePlate;
  String imageUrl;
  String dateOfLastMaintenance;
  int millageCount;

  Vehicles(
      {this.id,
      this.manufacturer,
      this.model,
      this.licensePlate,
      this.imageUrl,
      this.dateOfLastMaintenance,
      this.millageCount});

  Vehicles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    manufacturer = json['manufacturer'];
    model = json['model'];
    licensePlate = json['licensePlate'];
    imageUrl = json['imageUrl'];
    dateOfLastMaintenance = json['dateOfLastMaintenance'];
    millageCount = json['millageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['manufacturer'] = this.manufacturer;
    data['model'] = this.model;
    data['licensePlate'] = this.licensePlate;
    data['imageUrl'] = this.imageUrl;
    data['dateOfLastMaintenance'] = this.dateOfLastMaintenance;
    data['millageCount'] = this.millageCount;
    return data;
  }
}

class Notifications {
  String id;
  String title;
  String message;
  String createdAt;

  Notifications({this.id, this.title, this.message, this.createdAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    return data;
  }
}