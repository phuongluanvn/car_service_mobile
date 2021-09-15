class CrewModel {
  String id;
  String leaderFullname;
  List<Members> members;
  List<Orders> order;

  CrewModel({this.id, this.leaderFullname, this.members, this.order});

  CrewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaderFullname = json['leaderFullname'];
    if (json['members'] != null) {
      members = new List<Members>();
      json['members'].forEach((v) {
        members.add(new Members.fromJson(v));
      });
    }
    if (json['orders'] != null) {
      order = new List<Orders>();
      json['orders'].forEach((v) {
        order.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leaderFullname'] = this.leaderFullname;
    if (this.members != null) {
      data['members'] = this.members.map((v) => v.toJson()).toList();
    }
    if (this.order != null) {
      data['orders'] = this.order.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
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
}

class Orders {
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
  Vehicle vehicle;
  List<OrderDetails> orderDetails;

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
      this.status,
      this.imageUrl,
      this.vehicle,
      this.orderDetails});

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
    status = json['status'];
    imageUrl = json['imageUrl'];
    vehicle =
        json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
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
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle.toJson();
    }
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vehicle {
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
}

class OrderDetails {
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
}
