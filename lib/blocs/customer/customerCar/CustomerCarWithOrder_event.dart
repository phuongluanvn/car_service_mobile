import 'package:equatable/equatable.dart';

abstract class CustomerCarWithOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoCarListEvent extends CustomerCarWithOrderEvent {}

class DoVehicleListWithIdEvent extends CustomerCarWithOrderEvent {
  final String vehicleId;
  DoVehicleListWithIdEvent({this.vehicleId});
  @override
  List<Object> get props => [vehicleId];
}
