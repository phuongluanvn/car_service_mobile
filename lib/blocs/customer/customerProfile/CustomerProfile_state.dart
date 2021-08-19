import 'package:equatable/equatable.dart';

enum EditProfileStatus {
  init,
  loading,
  editSuccess,
  error,
}

class EditProfileState extends Equatable {
  final EditProfileStatus status;
  final String message;
  EditProfileState({this.status: EditProfileStatus.init, this.message: ''});

  EditProfileState copyWith({
    EditProfileStatus status,
    String message,
  }) =>
      EditProfileState(
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
