import 'package:car_service/ui/Customer/CustomerProfile.dart';
import 'package:car_service/utils/model/CustomerProfileModel.dart';
import 'package:equatable/equatable.dart';

enum ProfileStatus {
  init,
  loading,
  getProflieSuccess,
  error,
}

class ProfileState extends Equatable {
  final List<CustomerProfileModel> cusProfile;
  final ProfileStatus status;
  final String message;
  ProfileState(
      {this.status: ProfileStatus.init,
      this.message: '',
      this.cusProfile: const []});

  ProfileState copyWith({
    List<CustomerProfileModel> cusProfile,
    ProfileStatus status,
    String message,
  }) =>
      ProfileState(
          status: status ?? this.status,
          message: message ?? this.message,
          cusProfile: cusProfile ?? this.cusProfile);
  @override
  List<Object> get props => [status, message, cusProfile];
}

// class SignUpInitState extends ProfileState {}

// class SignUpLoadingState extends ProfileState {}

// class CustomerSignUpSuccessState extends ProfileState {}

// class SignUpErrorState extends ProfileState {
//   final String message;
//   SignUpErrorState({this.message});
// }
