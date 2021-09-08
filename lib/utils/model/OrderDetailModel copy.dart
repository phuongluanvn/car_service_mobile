import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

class OrderDetailModel extends Equatable {
  String id;
  String createdTime;
  String bookingTime;
  String checkinTime;
  String completeTime;
  String cancelTime;
  String note;
  String noteCustomer;
  String noteManager;
  String status;
  String imageUrl;
  Customer customer;
  Vehicle vehicle;
  Crew crew;
  List<Packages> packages;
  List<OrderDetails> orderDetails;
  List<Feedbacks> feedbacks;

  OrderDetailModel(
      {this.id,
      this.createdTime,
      this.bookingTime,
      this.checkinTime,
      this.completeTime,
      this.cancelTime,
      this.note,
      this.noteCustomer,
      this.noteManager,
      this.status,
      this.imageUrl,
      this.customer,
      this.vehicle,
      this.crew,
      this.packages,
      this.orderDetails,
      this.feedbacks});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdTime = json['createdTime'];
    bookingTime = json['bookingTime'];
    checkinTime = json['checkinTime'];
    completeTime = json['completeTime'];
    cancelTime = json['cancelTime'];
    note = json['note'];
    noteCustomer = json['noteCustomer'];
    noteManager = json['noteManager'];
    status = json['status'];
    imageUrl = json['imageUrl'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    vehicle =
        json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
    crew = json['crew'] != null ? new Crew.fromJson(json['crew']) : null;
    if (json['packages'] != null) {
      packages = new List<Packages>();
      json['packages'].forEach((v) {
        packages.add(new Packages.fromJson(v));
      });
    }
    if (json['orderDetails'] != null) {
      orderDetails = new List<OrderDetails>();
      json['orderDetails'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
    if (json['feedbacks'] != null) {
      feedbacks = new List<Feedbacks>();
      json['feedbacks'].forEach((v) {
        feedbacks.add(new Feedbacks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdTime'] = this.createdTime;
    data['bookingTime'] = this.bookingTime;
    data['checkinTime'] = this.checkinTime;
    data['completeTime'] = this.completeTime;
    data['cancelTime'] = this.cancelTime;
    data['note'] = this.note;
    data['noteCustomer'] = this.noteCustomer;
    data['noteManager'] = this.noteManager;
    data['status'] = this.status;
    data['imageUrl'] = this.imageUrl;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle.toJson();
    }
    if (this.crew != null) {
      data['crew'] = this.crew.toJson();
    }
    if (this.packages != null) {
      data['packages'] = this.packages.map((v) => v.toJson()).toList();
    }
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks.map((v) => v.toJson()).toList();
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
  bool isBanned;
  String vehicles;

  Customer(
      {this.username,
      this.email,
      this.fullname,
      this.phoneNumber,
      this.address,
      this.accumulatedPoint,
      this.isBanned,
      this.vehicles});

  Customer.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    fullname = json['fullname'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    accumulatedPoint = json['accumulatedPoint'];
    isBanned = json['isBanned'];
    vehicles = json['vehicles'];
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
    data['vehicles'] = this.vehicles;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Vehicle extends Equatable {
  String id;
  String manufacturer;
  String model;
  String licensePlate;
  String imageUrl;
  String dateOfLastMaintenance;
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

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Crew extends Equatable {
  String id;
  List<StaffModel> members;

  Crew({this.id, this.members});

  Crew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
  bool isLeader;

  Members(
      {this.username,
      this.role,
      this.fullname,
      this.phoneNumber,
      this.email,
      this.address,
      this.dateOfBirth,
      this.status,
      this.isLeader});

  Members.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'];
    fullname = json['fullname'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    dateOfBirth = json['dateOfBirth'];
    status = json['status'];
    isLeader = json['isLeader'];
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
    data['isLeader'] = this.isLeader;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Packages extends Equatable {
  String id;
  String name;
  String description;
  int price;
  List<OrderDetails> orderDetails;

  Packages(
      {this.id, this.name, this.description, this.price, this.orderDetails});

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
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
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
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
  String coupon;

  OrderDetails(
      {this.id,
      this.serviceId,
      this.accessoryId,
      this.name,
      this.quantity,
      this.price,
      this.isIncurred,
      this.isFinished,
      this.timeFinished,
      this.coupon});

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
    coupon = json['coupon'];
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
    data['coupon'] = this.coupon;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Feedbacks extends Equatable {
  String id;
  String orderId;
  int rating;
  String description;

  Feedbacks({this.id, this.orderId, this.rating, this.description});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    rating = json['rating'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderId'] = this.orderId;
    data['rating'] = this.rating;
    data['description'] = this.description;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}
