class OrderDetailModel {
  String id;
  String note;
  String status;
  String createdTime;
  String bookingTime;
  String checkinTime;
  Customer customer;
  Vehicle vehicle;
  String package;

  OrderDetailModel(
      {this.id,
      this.note,
      this.status,
      this.createdTime,
      this.bookingTime,
      this.checkinTime,
      this.customer,
      this.vehicle,
      this.package});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    status = json['status'];
    createdTime = json['createdTime'];
    bookingTime = json['bookingTime'];
    checkinTime = json['checkinTime'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    vehicle =
        json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
    package = json['package'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['status'] = this.status;
    data['createdTime'] = this.createdTime;
    data['bookingTime'] = this.bookingTime;
    data['checkinTime'] = this.checkinTime;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle.toJson();
    }
    data['package'] = this.package;
    return data;
  }
}

class Customer {
  String username;
  String email;
  String fullname;
  String phoneNumber;
  String address;
  int accumulatedPoint;

  Customer(
      {this.username,
      this.email,
      this.fullname,
      this.phoneNumber,
      this.address,
      this.accumulatedPoint});

  Customer.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    fullname = json['fullname'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    accumulatedPoint = json['accumulatedPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['fullname'] = this.fullname;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['accumulatedPoint'] = this.accumulatedPoint;
    return data;
  }
}

class Vehicle {
  String id;
  String manufacturer;
  String model;
  String licensePlate;
  Null dateOfLastMaintenance;
  int millageCount;

  Vehicle(
      {this.id,
      this.manufacturer,
      this.model,
      this.licensePlate,
      this.dateOfLastMaintenance,
      this.millageCount});

  Vehicle.fromJson(Map<String, dynamic> json) {
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