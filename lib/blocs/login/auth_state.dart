import 'package:car_service/utils/model/StaffModel.dart';
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
  final List<StaffModel> staffProfile;

  AuthState(
      {this.status: LoginStatus.init,
      this.staffProfile: const [],
      this.message: ''});
      
  AuthState copyWith(
          {LoginStatus status, String message, List<StaffModel> staff}) =>
      AuthState(
        status: status ?? this.status,
        staffProfile: staffProfile ?? this.staffProfile,
        message: message ?? this.message,
      );

  @override
  List<Object> get props => [status, message, staffProfile];
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
