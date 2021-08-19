import 'package:equatable/equatable.dart';

enum UpdateCarStatus {
  init,
  loading,
  error,
  updateDetailSuccess,
}

class UpdateCarState extends Equatable {
  final UpdateCarStatus updateStatus;
  final String message;
  const UpdateCarState({
    this.updateStatus: UpdateCarStatus.init,
    this.message: '',
  });

  UpdateCarState copyWith({
    UpdateCarStatus updateStatus,
    String message,
  }) =>
      UpdateCarState(
        updateStatus: updateStatus ?? this.updateStatus,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        updateStatus,
        message,
      ];
}
