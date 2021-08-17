import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

class OrderDetailModel extends Equatable {
  String id;
  String note;
  String status;
  String imageUrl;
  String createdTime;
  String bookingTime;
  String checkinTime;
  Customer customer;
  Vehicle vehicle;
  Package package;
  Crew crew;
  List<OrderDetails> orderDetails;

  OrderDetailModel(
      {this.id,
      this.note,
      this.status,
      this.imageUrl,
      this.createdTime,
      this.bookingTime,
      this.checkinTime,
      this.customer,
      this.vehicle,
      this.package,
      this.crew,
      this.orderDetails});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    status = json['status'];
    imageUrl = json['imageUrl'];
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
    crew = json['crew'] != null ? new Crew.fromJson(json['crew']) : null;
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
    data['imageUrl'] = this.imageUrl;
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
    if (this.crew != null) {
      data['crew'] = this.crew.toJson();
    }
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Customer extends Equatable {
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

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Vehicle extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
  String id;
  String manufacturer;
  String model;
  String licensePlate;
  Null imageUrl;
  Null dateOfLastMaintenance;
  int millageCount;

  Vehicle(
      {this.id,
      this.manufacturer,
      this.model,
      this.licensePlate,
      this.imageUrl,
      this.dateOfLastMaintenance,
      this.millageCount});

  Vehicle.fromJson(Map<String, dynamic> json) {
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

class Package extends Equatable {
  String id;
  String name;
  String description;
  int price;
  Null services;

  Package({this.id, this.name, this.description, this.price, this.services});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    services = json['services'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['services'] = this.services;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Crew extends Equatable {
  String id;
  String timeAssigned;
  Null timeFinished;
  List<StaffModel> members;

  Crew({this.id, this.timeAssigned, this.timeFinished, this.members});

  Crew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeAssigned = json['timeAssigned'];
    timeFinished = json['timeFinished'];
    if (json['members'] != null) {
      members = new List<StaffModel>();
      json['members'].forEach((v) {
        members.add(new StaffModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['timeAssigned'] = this.timeAssigned;
    data['timeFinished'] = this.timeFinished;
    if (this.members != null) {
      data['members'] = this.members.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Members extends Equatable {
  String username;
  String role;
  String fullname;
  String phoneNumber;
  String email;
  String address;
  String dateOfBirth;
  String status;

  Members(
      {this.username,
      this.role,
      this.fullname,
      this.phoneNumber,
      this.email,
      this.address,
      this.dateOfBirth,
      this.status});

  Members.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'];
    fullname = json['fullname'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    dateOfBirth = json['dateOfBirth'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['role'] = this.role;
    data['fullname'] = this.fullname;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['dateOfBirth'] = this.dateOfBirth;
    data['status'] = this.status;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [this.fullname];
}

class OrderDetails extends Equatable {
  String id;
  String serviceId;
  String accessoryId;
  String name;
  int quantity;
  int price;
  bool isIncurred;
  bool isFinished;
  String timeFinished;

  OrderDetails(
      {this.id,
      this.serviceId,
      this.accessoryId,
      this.name,
      this.quantity,
      this.price,
      this.isIncurred,
      this.isFinished,
      this.timeFinished});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['serviceId'];
    accessoryId = json['accessoryId'];
    name = json['name'];
    quantity = json['quantity'];
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
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['isIncurred'] = this.isIncurred;
    data['isFinished'] = this.isFinished;
    data['timeFinished'] = this.timeFinished;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}
