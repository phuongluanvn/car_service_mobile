import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/model/ServiceModel.dart';
import 'package:equatable/equatable.dart';

enum CreateBookingStatus {
  init,
  loading,
  createBookingOrderSuccess,
  error,
}

// ignore: must_be_immutable
class CreateBookingState extends Equatable {
  final CreateBookingStatus status;
  final String message;

  List<CarModel> listCars;
  List<ServiceModel> listServices;

  CreateBookingState(
      {this.status: CreateBookingStatus.init,
      this.listCars: const [],
      this.listServices: const [],
      this.message: ''});

  CreateBookingState copyWith({
    CreateBookingStatus status,
    String message,
  }) =>
      CreateBookingState(
        status: status ?? this.status,
        listCars: listCars ?? this.listCars,
        listServices: listServices ?? this.listServices,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [status, listCars, listServices, message];
}
