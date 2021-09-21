import 'package:equatable/equatable.dart';

enum EditProfileStatus {
  init,
  loading,
  editSuccess,
  error,
}


class ManagerEditProfileState extends Equatable {
  final EditProfileStatus status;
  final String message;
  ManagerEditProfileState({this.status: EditProfileStatus.init, this.message: ''});

  ManagerEditProfileState copyWith({
    EditProfileStatus status,
    String message,
  }) =>
      ManagerEditProfileState(
        status: status ?? this.status,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [status, message];
}

// class SignUpInitState extends EditProfileState {}

// class SignUpLoadingState extends EditProfileState {}

// class CustomerSignUpSuccessState extends EditProfileState {}

// class SignUpErrorState extends EditProfileState {
//   final String message;
//   SignUpErrorState({this.message});
// }
