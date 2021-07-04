import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class CreateBookingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// 1. chọn xe
// 2. chọn thời gian
// 3. chọn dịch vụ
// 4. Nhấn xác nhận đặt lịch

class CreateBookingSelectedCarChanged extends CreateBookingEvent {
  final String carId;

  CreateBookingSelectedCarChanged({this.carId});
}

class CreateBookingTimeChanged extends CreateBookingEvent {
  final String timeBooking;

  CreateBookingTimeChanged({this.timeBooking});
}

class CreateBookingServiceChanged extends CreateBookingEvent {
  final String serviceId;

  CreateBookingServiceChanged({this.serviceId});
}

class CreateBookingButtonPressed extends CreateBookingEvent {
  final String carId;
  final String timeBooking;
  final String serviceId;
  // final String imageUrl;

  CreateBookingButtonPressed({this.carId, this.timeBooking, this.serviceId});
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