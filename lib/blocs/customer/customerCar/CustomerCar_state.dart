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
  // updateDetailSuccess,
  // deleteDetailSuccess
}

enum CustomerCarDeleteStatus { init, loading, error, deleteDetailSuccess }

enum CustomerCarUpdateDetailStatus {
  init,
  loading,
  error,
  updateDetailSuccess,
}

class CustomerCarState extends Equatable {
  final CustomerCarStatus status;
  final CustomerCarWithIdStatus withIdstatus;
  final CustomerCarDetailStatus detailStatus;
  final CustomerCarDeleteStatus deleteStatus;
  final CustomerCarUpdateDetailStatus updateDetailStatus;

  final List<VehicleModel> vehicleDetail;
  final List<VehicleModel> vehicleLists;

  final String message;
  const CustomerCarState({
    this.status: CustomerCarStatus.init,
    this.withIdstatus: CustomerCarWithIdStatus.init,
    this.detailStatus: CustomerCarDetailStatus.init,
    this.deleteStatus: CustomerCarDeleteStatus.init,
    this.updateDetailStatus: CustomerCarUpdateDetailStatus.init,
    this.vehicleDetail: const [],
    this.vehicleLists: const [],
    this.message: '',
  });

  CustomerCarState copyWith({
    CustomerCarStatus status,
    final CustomerCarWithIdStatus withIdstatus,
     CustomerCarDeleteStatus deleteStatus,
     CustomerCarUpdateDetailStatus updateDetailStatus,
    CustomerCarDetailStatus detailStatus,
    List<VehicleModel> vehicleDetail,
    List<VehicleModel> vehicleLists,
    String message,
  }) =>
      CustomerCarState(
        status: status ?? this.status,
        withIdstatus: withIdstatus ?? this.withIdstatus,
        detailStatus: detailStatus ?? this.detailStatus,
        deleteStatus: deleteStatus ?? this.deleteStatus,
        updateDetailStatus: updateDetailStatus ?? this.updateDetailStatus,
        vehicleDetail: vehicleDetail ?? this.vehicleDetail,
        message: message ?? this.message,
        vehicleLists: vehicleLists ?? this.vehicleLists,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        deleteStatus,
        updateDetailStatus,
        vehicleDetail,
        vehicleLists,
        message,
      ];
}
