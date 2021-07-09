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

enum CustomerCarDetailStatus{
  init,
  loading,
  success,
  error,
}

class CustomerCarState extends Equatable {
  final CustomerCarStatus status;
  final CustomerCarDetailStatus detailStatus;
  final List<CarModel> carLists;
  final List<CarModel> carDetail;
  final List<VehicleModel> vehicleLists;
  final String message;
  const CustomerCarState({
    this.status: CustomerCarStatus.init,
    this.detailStatus:CustomerCarDetailStatus.init,
    this.carDetail:const [],
    this.carLists:const [],
    this.vehicleLists:const[],
    this.message:'',
  });

  CustomerCarState copyWith({
    CustomerCarStatus status,
    CustomerCarDetailStatus detailStatus,
    List<CarModel> carLists,
    List<CarModel> carDetail,
    List<VehicleModel> vehicleLists,
    String message,
  }) =>
      CustomerCarState(
        status: status ?? this.status,
        detailStatus: detailStatus??this.detailStatus,
        carLists: carLists ?? this.carLists,
        carDetail: carDetail ?? this.carDetail,
        message: message??this.message,
        vehicleLists: vehicleLists ?? this.vehicleLists,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        carLists,
        carDetail,
        vehicleLists,
        message,
      ];
}