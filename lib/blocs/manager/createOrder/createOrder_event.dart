import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class CreateOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateOrderChanged extends CreateOrderEvent {
  final String order;

  CreateOrderChanged({this.order});
}

class CreateOrderModelChanged extends CreateOrderEvent {
  final String model;

  CreateOrderModelChanged({this.model});
}

class CreateOrderLicensePlateNumberChanged extends CreateOrderEvent {
  final String licensePlateNumber;

  CreateOrderLicensePlateNumberChanged({this.licensePlateNumber});
}

class CreateOrderButtonPressed extends CreateOrderEvent {
  final String manufacturer;
  
  final String licensePlateNumber;
  final String imageUrl;

  CreateOrderButtonPressed(
      {this.manufacturer, this.licensePlateNumber, this.imageUrl});
}

class OpenImagePicker extends CreateOrderEvent {
  final ImageSource imageSource;

  OpenImagePicker({this.imageSource});
}

class ProviderImagePath extends CreateOrderEvent {
  final String imageCarPath;
  ProviderImagePath({this.imageCarPath});
}

class ChangeImageCarRequest extends CreateOrderEvent{}