import 'package:car_service/utils/model/VehicleModel.dart';
import 'package:equatable/equatable.dart';
import '../../../utils/model/CarModel.dart';

enum CustomerCarStatus {
  init,
  loading,
  loadedCarSuccess,
  loadedCarDetailSuccess,
  loadedVehicleSuccess,
  error,
}

enum CustomerCarWithIdStatus {
  init,
  loading,
  loadedCarSuccess,
  loadedCarDetailSuccess,
  loadedVehicleSuccess,
  error,
}

enum CustomerCarDetailStatus {
  init,
  loading,
  success,
  error,
}

class CustomerCarState extends Equatable {
  final CustomerCarStatus status;
  final CustomerCarWithIdStatus withIdstatus;
  final CustomerCarDetailStatus detailStatus;
  final List<VehicleModel> vehicleDetail;
  final List<VehicleModel> vehicleLists;

  final String message;
  const CustomerCarState({
    this.status: CustomerCarStatus.init,
    this.withIdstatus: CustomerCarWithIdStatus.init,
    this.detailStatus: CustomerCarDetailStatus.init,
    this.vehicleDetail: const [],
    this.vehicleLists: const [],
    this.message: '',
  });

  CustomerCarState copyWith({
    CustomerCarStatus status,
    final CustomerCarWithIdStatus withIdstatus,
    CustomerCarDetailStatus detailStatus,
    List<VehicleModel> vehicleDetail,
    List<VehicleModel> vehicleLists,
    String message,
  }) =>
      CustomerCarState(
        status: status ?? this.status,
        withIdstatus: withIdstatus ?? this.withIdstatus,
        detailStatus: detailStatus ?? this.detailStatus,
        vehicleDetail: vehicleDetail ?? this.vehicleDetail,
        message: message ?? this.message,
        vehicleLists: vehicleLists ?? this.vehicleLists,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        vehicleDetail,
        vehicleLists,
        message,
      ];
}
