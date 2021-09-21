
import 'package:car_service/utils/model/EmployeeProfileModel.dart';
import 'package:equatable/equatable.dart';

enum ProfileStatus {
  init,
  loading,
  getProflieSuccess,
  error,
}

class ManagerProfileState extends Equatable {
  final List<EmployeeProfileModel> managerProfile;
  final ProfileStatus status;
  final String message;
  ManagerProfileState(
      {this.status: ProfileStatus.init,
      this.message: '',
      this.managerProfile: const []});

  ManagerProfileState copyWith({
    List<EmployeeProfileModel> managerProfile,
    ProfileStatus status,
    String message,
  }) =>
      ManagerProfileState(
          status: status ?? this.status,
          message: message ?? this.message,
          managerProfile: managerProfile ?? this.managerProfile);
  @override
  List<Object> get props => [status, message, managerProfile];
}

// class SignUpInitState extends ProfileState {}

// class SignUpLoadingState extends ProfileState {}

// class CustomerSignUpSuccessState extends ProfileState {}

// class SignUpErrorState extends ProfileState {
//   final String message;
//   SignUpErrorState({this.message});
// }
