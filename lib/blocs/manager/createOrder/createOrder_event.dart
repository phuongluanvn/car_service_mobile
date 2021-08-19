import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class CreateOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// 1. chọn xe
// 2. chọn thời gian
// 3. chọn dịch vụ
// 4. Nhấn xác nhận đặt lịch

class CreateOrderSelectedCustomerChanged extends CreateOrderEvent {
  final String cusId;

  CreateOrderSelectedCustomerChanged({this.cusId});
}

class CreateOrderSelectedCarChanged extends CreateOrderEvent {
  final String carId;

  CreateOrderSelectedCarChanged({this.carId});
}

class DoCreateOrderDetailEvent extends CreateOrderEvent {
  final String id;
  DoCreateOrderDetailEvent({this.id});
  @override
  List<Object> get props => [id];
}

class DoLicenseDetailEvent extends CreateOrderEvent {
  final String id;
  DoLicenseDetailEvent({this.id});
  @override
  List<Object> get props => [id];
}

class CreateOrderServiceChanged extends CreateOrderEvent {
  final String serviceId;

  CreateOrderServiceChanged({this.serviceId});
}

class CreateOrderNoteChanged extends CreateOrderEvent {
  final String note;

  CreateOrderNoteChanged({this.note});
}

class CreateOrderButtonPressed extends CreateOrderEvent {
  final String cusId;
  final String carId;
  final String serviceId;
  final String note;
  final String timeBooking;

  // final String imageUrl;

  CreateOrderButtonPressed(
      {this.cusId, this.carId, this.serviceId, this.note, this.timeBooking});
}

// class OpenImagePicker extends CreateBookingEvent {
//   final ImageSource imageSource;

//   OpenImagePicker({this.imageSource});
// }

// class ProviderImagePath extends CreateBookingEvent {
//   final String imageCarPath;
//   ProviderImagePath({this.imageCarPath});
// }

// class ChangeImageCarRequest extends CreateBookingEvent{}
