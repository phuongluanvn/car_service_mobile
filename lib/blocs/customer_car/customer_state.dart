
import 'package:car_service/utils/model/CarModel.dart';
import 'package:equatable/equatable.dart';
// part of 'customer_cubit.dart';


abstract class CustomerCarState extends Equatable {
  const CustomerCarState();

  @override
  List<Object> get props => [];
}

class CarInitial extends CustomerCarState {}

class CarLoaded extends CustomerCarState {
  final List<CarModel> carModel;

  CarLoaded({
    this.carModel,
  });

  @override
  List<Object> get props => [carModel];
}

// ignore: must_be_immutable
// ignore: camel_case_types
class CarLoadedFailed extends CustomerCarState {
  final String message;

  CarLoadedFailed(
    {this.message}
  );
}
