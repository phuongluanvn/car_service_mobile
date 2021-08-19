import 'package:equatable/equatable.dart';



enum LoginStatus {
  init,
  loading,
  managerSuccess,
  customerSuccess,
  staffSuccess,
  error,
}

class AuthState extends Equatable {
  final LoginStatus status;
  final String message;
  AuthState(
      {this.status: LoginStatus.init,
      this.message: ''});
  AuthState copyWith({
    LoginStatus status,
    
    String message,
  }) =>
      AuthState(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  List<Object> get props => [status, message];
}




// class AuthState extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class LoginInitState extends AuthState {}

// class LoginLoadingState extends AuthState {}

// class CustomerLoginSuccessState extends AuthState {}

// class ManagerLoginSuccessState extends AuthState {}

// class StaffLoginSuccessState extends AuthState {}

// class LoginErrorState extends AuthState {
//   final String message;
//   LoginErrorState({this.message});
// }
