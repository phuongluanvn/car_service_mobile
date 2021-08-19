import 'package:equatable/equatable.dart';

enum CreateCarStatus {
  init,
  loading,
  createCarSuccess,
  error,
}

class CreateCarState extends Equatable {
  final CreateCarStatus status;
  final String message;
  CreateCarState({this.status: CreateCarStatus.init, this.message: ''});

  CreateCarState copyWith({
    CreateCarStatus status,
    String message,
  }) =>
      CreateCarState(
        status: status ?? this.status,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [status, message];
}
