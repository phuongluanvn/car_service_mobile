class OrderDetailModel {
  String id;
  String note;
  String status;
  String createdTime;
  String bookingTime;
  Null checkinTime;
  Customer customer;
  Vehicle vehicle;
  Package package;
  List<OrderDetails> orderDetails;

  OrderDetailModel(
      {this.id,
      this.note,
      this.status,
      this.createdTime,
      this.bookingTime,
      this.checkinTime,
      this.customer,
      this.vehicle,
      this.package,
      this.orderDetails});

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
    package =
        json['package'] != null ? new Package.fromJson(json['package']) : null;
    if (json['orderDetails'] != null) {
      orderDetails = new List<OrderDetails>();
      json['orderDetails'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
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
    if (this.package != null) {
      data['package'] = this.package.toJson();
    }
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
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

class Package {
  String id;
  String name;
  String description;
  int price;

  Package({this.id, this.name, this.description, this.price});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    return data;
  }
}

class OrderDetails {
  String id;
  String serviceId;
  Null accessoryId;
  String name;
  int price;
  bool isIncurred;
  bool isFinished;
  Null timeFinished;

  OrderDetails(
      {this.id,
      this.serviceId,
      this.accessoryId,
      this.name,
      this.price,
      this.isIncurred,
      this.isFinished,
      this.timeFinished});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['serviceId'];
    accessoryId = json['accessoryId'];
    name = json['name'];
    price = json['price'];
    isIncurred = json['isIncurred'];
    isFinished = json['isFinished'];
    timeFinished = json['timeFinished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceId'] = this.serviceId;
    data['accessoryId'] = this.accessoryId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['isIncurred'] = this.isIncurred;
    data['isFinished'] = this.isFinished;
    data['timeFinished'] = this.timeFinished;
    return data;
  }
}
