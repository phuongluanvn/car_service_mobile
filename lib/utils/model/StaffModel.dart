import 'package:equatable/equatable.dart';

class StaffModel extends Equatable {
  String username;
  String role;
  String fullname;
  String phoneNumber;
  String email;
  String address;
  String dateOfBirth;
  String status;

  StaffModel(
      {this.username,
      this.role,
      this.fullname,
      this.phoneNumber,
      this.email,
      this.address,
      this.dateOfBirth,
      this.status});

  StaffModel.fromJson(Map<String, dynamic> json) {
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
  List<Object> get props => [this.username];
}
