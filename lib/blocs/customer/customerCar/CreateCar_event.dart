import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

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
  final String username;
  final String manufacturer;
  final String model;
  final String licensePlateNumber;
  final String imageUrl;

  CreateCarButtonPressed(
      {this.username, this.manufacturer, this.model, this.licensePlateNumber, this.imageUrl});
}

class OpenImagePicker extends CreateCarEvent {
  final ImageSource imageSource;

  OpenImagePicker({this.imageSource});
}

class ProviderImagePath extends CreateCarEvent {
  final String imageCarPath;
  ProviderImagePath({this.imageCarPath});
}

class ChangeImageCarRequest extends CreateCarEvent{}