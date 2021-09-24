import 'package:equatable/equatable.dart';

class StaffModel {
  String username;
  String role;
  String fullname;
  String phoneNumber;
  String email;
  String address;
  String dateOfBirth;
  String status;
  List<Notifications> notifications;
  List<Absences> absences;

  StaffModel(
      {this.username,
      this.role,
      this.fullname,
      this.phoneNumber,
      this.email,
      this.address,
      this.dateOfBirth,
      this.status,
      this.notifications,
      this.absences});

  StaffModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'];
    fullname = json['fullname'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    dateOfBirth = json['dateOfBirth'];
    status = json['status'];
    if (json['notifications'] != null) {
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
    if (json['absences'] != null) {
      absences = new List<Absences>();
      json['absences'].forEach((v) {
        absences.add(new Absences.fromJson(v));
      });
    }
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
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    if (this.absences != null) {
      data['absences'] = this.absences.map((v) => v.toJson()).toList();
    }
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

class Absences extends Equatable{
  String id;
  String timeStart;
  String timeEnd;
  String noteEmp;
  String noteAdmin;
  bool isApproved;

  Absences(
      {this.id,
      this.timeStart,
      this.timeEnd,
      this.noteEmp,
      this.noteAdmin,
      this.isApproved});

  Absences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeStart = json['timeStart'];
    timeEnd = json['timeEnd'];
    noteEmp = json['noteEmp'];
    noteAdmin = json['noteAdmin'];
    isApproved = json['isApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['timeStart'] = this.timeStart;
    data['timeEnd'] = this.timeEnd;
    data['noteEmp'] = this.noteEmp;
    data['noteAdmin'] = this.noteAdmin;
    data['isApproved'] = this.isApproved;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}