import 'package:equatable/equatable.dart';

enum CreateOrderStatus {
  init,
  loading,
  createOrderSuccess,
  error,
}

class CreateOrderState extends Equatable {
  final CreateOrderStatus status;
  final String message;
  CreateOrderState({this.status: CreateOrderStatus.init, this.message: ''});

  CreateOrderState copyWith({
    CreateOrderStatus status,
    String message,
  }) =>
      CreateOrderState(
        status: status ?? this.status,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [status, message];
}
