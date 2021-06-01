import 'package:car_service/form_submission_status.dart';
import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String username;
  bool get isValidUsername => username.length > 3;

  final String email;
  bool get isValidEmail => email.contains('@');

  final String password;
  bool get isValidPassword => password.length > 6;

  final FormSubmissionStatus formStatus;

  SignUpState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  @override
  List<Object> get props => [];
}
