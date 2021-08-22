import 'package:equatable/equatable.dart';

abstract class UpdateCarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateCarButtonPressed extends UpdateCarEvent {
  final String carId;
  final String manufacturer;
  final String model;
  final String licensePlateNumber;

  UpdateCarButtonPressed(
      {this.carId,
      this.manufacturer,
      this.model,
      this.licensePlateNumber,
     });
}
