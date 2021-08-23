import 'package:equatable/equatable.dart';

enum UpdateStatus {
  init,
  loading,
  updateStatusSuccess,
  updateStatusStartSuccess,
  updateStatusCheckinSuccess,
  updateStatusCheckingSuccess,
  updateStatusAbsentSuccess,
  updateStatusWorkingSuccess,
  updateStatusWaitConfirmSuccess,
  updateStatusConfirmAcceptedSuccess,
  updateStatusCancelSuccess,
  updateConfirmFromCustomerSuccess,
  error,
}

class UpdateStatusOrderState extends Equatable {
  final UpdateStatus status;
  final String message;
  UpdateStatusOrderState({this.status: UpdateStatus.init, this.message: ''});

  UpdateStatusOrderState copyWith({
    UpdateStatus status,
    String message,
  }) =>
      UpdateStatusOrderState(
        status: status ?? this.status,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [status, message];
}
