import 'package:equatable/equatable.dart';

abstract class ManagerEditProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}



class EditManagerProfileButtonPressed extends ManagerEditProfileEvent {
  final String username;
  final String email;
  final String phoneNumber;
  final String address;
  final String fullname;

  EditManagerProfileButtonPressed(
      {this.username, this.fullname,  this.phoneNumber, this.email, this.address});
}
