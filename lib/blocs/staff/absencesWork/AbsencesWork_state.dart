import 'package:equatable/equatable.dart';

enum AbsencesWorkStatus {
  init,
  loading,
  absencesWorkSuccess,
  error,
}

class AbsencesWorkState extends Equatable {
  final AbsencesWorkStatus status;
  final String message;
  AbsencesWorkState({this.status: AbsencesWorkStatus.init, this.message: ''});

  AbsencesWorkState copyWith({
    AbsencesWorkStatus status,
    String message,
  }) =>
      AbsencesWorkState(
        status: status ?? this.status,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [status, message];
}
