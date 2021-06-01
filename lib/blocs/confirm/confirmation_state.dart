import 'package:car_service/form_submission_status.dart';
import 'package:equatable/equatable.dart';

class ConfirmState extends Equatable {
  final String code;

  bool get isValidCode => code.length == 6;

  final FormSubmissionStatus formStatus;

  ConfirmState({
    this.code = '',
    this.formStatus = const InitialFormStatus(),
  });

  ConfirmState copyWith({
    String code,
    FormSubmissionStatus formStatus,
  }) {
    return ConfirmState(
      code: code ?? this.code,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object> get props => [];
}
