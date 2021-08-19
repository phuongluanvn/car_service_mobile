import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpUsernameChanged extends SignUpEvent {
  final String username;

  SignUpUsernameChanged({this.username});
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged({this.email});
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged({this.password});
}

class SignUpButtonPressed extends SignUpEvent {
  final String username;
  final String password;
  final String phoneNumber;
  final String email;
  final String address;
  final String fullname;

  SignUpButtonPressed(
      {this.username, this.password, this.email, this.phoneNumber, this.address, this.fullname});
}
