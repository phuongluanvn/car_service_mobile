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
  final String user;
  final String name;
  final String phone;
  final String email;
  final String password;

  SignUpButtonPressed({this.user,this.name,this.email,this.phone,this.password});
}
