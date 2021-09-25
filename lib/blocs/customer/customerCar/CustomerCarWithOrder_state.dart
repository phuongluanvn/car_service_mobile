import 'package:car_service/utils/model/VehicleForCusModel.dart';
import 'package:equatable/equatable.dart';
import '../../../utils/model/CarModel.dart';

enum CustomerCarWithOrderStatus {
  init,
  loading,
  loadedVehicleWithOrderSuccess,
  error,
}

class CustomerCarWithOrderState extends Equatable {
  final CustomerCarWithOrderStatus status;
  final List<VehicleForCusModel> orderLists;

  final String message;
  const CustomerCarWithOrderState({
    this.status: CustomerCarWithOrderStatus.init,
    this.orderLists: const [],
    this.message: '',
  });

  CustomerCarWithOrderState copyWith({
    CustomerCarWithOrderStatus status,
    List<VehicleForCusModel> orderLists,
    String message,
  }) =>
      CustomerCarWithOrderState(
        status: status ?? this.status,
        message: message ?? this.message,
        orderLists: orderLists ?? this.orderLists,
      );
  @override
  List<Object> get props => [
        status,
        orderLists,
        message,
      ];
}
