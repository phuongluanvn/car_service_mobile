class TestOrderModel {
  String id;
  String bookingTime;
  Null checkinTime;
  String note;
  String status;
  String timeAdded;
  Vehicle vehicle;
  Customer customer;

  TestOrderModel(
      {this.id,
      this.bookingTime,
      this.checkinTime,
      this.note,
      this.status,
      this.timeAdded,
      this.vehicle,
      this.customer});

  TestOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingTime = json['bookingTime'];
    checkinTime = json['checkinTime'];
    note = json['note'];
    status = json['status'];
    timeAdded = json['timeAdded'];
    vehicle =
        json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bookingTime'] = this.bookingTime;
    data['checkinTime'] = this.checkinTime;
    data['note'] = this.note;
    data['status'] = this.status;
    data['timeAdded'] = this.timeAdded;
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
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
