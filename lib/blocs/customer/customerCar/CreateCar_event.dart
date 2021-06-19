import 'package:equatable/equatable.dart';

abstract class CreateCarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateCarManufacturerChanged extends CreateCarEvent {
  final String manufacturer;

  CreateCarManufacturerChanged({this.manufacturer});
}

class CreateCarModelChanged extends CreateCarEvent {
  final String model;

  CreateCarModelChanged({this.model});
}

class CreateCarLicensePlateNumberChanged extends CreateCarEvent {
  final String licensePlateNumber;

  CreateCarLicensePlateNumberChanged({this.licensePlateNumber});
}

class CreateCarButtonPressed extends CreateCarEvent {
  final String manufacturer;
  final String model;
  final String licensePlateNumber;

  CreateCarButtonPressed({this.manufacturer,this.model,this.licensePlateNumber});
}
