import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpInitState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class CustomerSignUpSuccessState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String message;
  SignUpErrorState({this.message});
}
