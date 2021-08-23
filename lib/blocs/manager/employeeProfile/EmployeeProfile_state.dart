import 'package:car_service/ui/Customer/CustomerProfile.dart';
import 'package:car_service/utils/model/CustomerProfileModel.dart';
import 'package:car_service/utils/model/EmployeeProfileModel.dart';
import 'package:equatable/equatable.dart';

enum EmpProfileStatus {
  init,
  loading,
  getProflieSuccess,
  error,
}

class EmployeeProfileState extends Equatable {
  final List<EmployeeProfileModel> empProfile;
  final EmpProfileStatus status;
  final String message;
  EmployeeProfileState(
      {this.status: EmpProfileStatus.init,
      this.message: '',
      this.empProfile: const []});

  EmployeeProfileState copyWith({
    List<EmployeeProfileModel> empProfile,
    EmpProfileStatus status,
    String message,
  }) =>
      EmployeeProfileState(
          status: status ?? this.status,
          message: message ?? this.message,
          empProfile: empProfile ?? this.empProfile);
  @override
  List<Object> get props => [status, message, empProfile];
}

// class SignUpInitState extends EmployeeProfileState {}

// class SignUpLoadingState extends EmployeeProfileState {}

// class CustomerSignUpSuccessState extends EmployeeProfileState {}

// class SignUpErrorState extends EmployeeProfileState {
//   final String message;
//   SignUpErrorState({this.message});
// }
