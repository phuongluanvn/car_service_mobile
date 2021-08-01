import 'package:equatable/equatable.dart';

enum SignUpStatus {
  init,
  loading,
  signUpSuccess,
  error,
}

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String message;
  SignUpState({this.status: SignUpStatus.init, this.message: ''});

  SignUpState copyWith({
    SignUpStatus status,
    String message,
  }) =>
      SignUpState(
        status: status ?? this.status,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [status, message];
}

// class SignUpInitState extends SignUpState {}

// class SignUpLoadingState extends SignUpState {}

// class CustomerSignUpSuccessState extends SignUpState {}

// class SignUpErrorState extends SignUpState {
//   final String message;
//   SignUpErrorState({this.message});
// }
