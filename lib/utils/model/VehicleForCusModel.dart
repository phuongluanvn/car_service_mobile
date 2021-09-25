import 'package:equatable/equatable.dart';

class VehicleForCusModel extends Equatable{
  String id;
  String manufacturer;
  String model;
  String licensePlate;
  String imageUrl;
  String dateOfLastMaintenance;
  num millageCount;
  List<Orders> orders;

  VehicleForCusModel(
      {this.id,
      this.manufacturer,
      this.model,
      this.licensePlate,
      this.imageUrl,
      this.dateOfLastMaintenance,
      this.millageCount,
      this.orders});

  VehicleForCusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    manufacturer = json['manufacturer'];
    model = json['model'];
    licensePlate = json['licensePlate'];
    imageUrl = json['imageUrl'];
    dateOfLastMaintenance = json['dateOfLastMaintenance'];
    millageCount = json['millageCount'];
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
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
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Orders extends Equatable{
  String id;
  String createdTime;
  String bookingTime;
  String checkinTime;
  String completeTime;
  String cancelTime;
  String note;
  String noteCustomer;
  String noteManager;
  List<OrderDetails> orderDetails;
  List<Crews> crews;

  Orders(
      {this.id,
      this.createdTime,
      this.bookingTime,
      this.checkinTime,
      this.completeTime,
      this.cancelTime,
      this.note,
      this.noteCustomer,
      this.noteManager,
      this.orderDetails,
      this.crews});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdTime = json['createdTime'];
    bookingTime = json['bookingTime'];
    checkinTime = json['checkinTime'];
    completeTime = json['completeTime'];
    cancelTime = json['cancelTime'];
    note = json['note'];
    noteCustomer = json['noteCustomer'];
    noteManager = json['noteManager'];
    if (json['orderDetails'] != null) {
      orderDetails = new List<OrderDetails>();
      json['orderDetails'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
    if (json['crews'] != null) {
      crews = new List<Crews>();
      json['crews'].forEach((v) {
        crews.add(new Crews.fromJson(v));
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
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    if (this.crews != null) {
      data['crews'] = this.crews.map((v) => v.toJson()).toList();
    }
    return data;
  }

   @override
  // TODO: implement props
  List<Object> get props => [];
}

class OrderDetails extends Equatable{
  String id;
  String name;
  double quantity;
  num price;

  OrderDetails({this.id, this.name, this.quantity, this.price});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    return data;
  }

   @override
  // TODO: implement props
  List<Object> get props => [];
}

class Crews extends Equatable{
  String leaderFullname;
  List<Members> members;

  Crews({this.leaderFullname, this.members});

  Crews.fromJson(Map<String, dynamic> json) {
    leaderFullname = json['leaderFullname'];
    if (json['members'] != null) {
      members = new List<Members>();
      json['members'].forEach((v) {
        members.add(new Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leaderFullname'] = this.leaderFullname;
    if (this.members != null) {
      data['members'] = this.members.map((v) => v.toJson()).toList();
    }
    return data;
  }

   @override
  // TODO: implement props
  List<Object> get props => [];
}

class Members extends Equatable{
  String username;
  String role;
  String fullname;
  String phoneNumber;
  String email;
  String address;
  String dateOfBirth;
  bool isLeader;

  Members(
      {this.username,
      this.role,
      this.fullname,
      this.phoneNumber,
      this.email,
      this.address,
      this.dateOfBirth,
      this.isLeader});

  Members.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'];
    fullname = json['fullname'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    dateOfBirth = json['dateOfBirth'];
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
    data['isLeader'] = this.isLeader;
    return data;
  }

   @override
  // TODO: implement props
  List<Object> get props => [];
}