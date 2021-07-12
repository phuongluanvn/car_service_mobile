import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:equatable/equatable.dart';

abstract class VerifyBookingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListBookingEvent extends VerifyBookingEvent {}

class DoVerifyBookingDetailEvent extends VerifyBookingEvent {
  final String email;
  DoVerifyBookingDetailEvent({this.email});
  @override
  List<Object> get props => [email];
}

// class UpdateStatusButtonPressed extends VerifyBookingEvent {
//   final String id;
//   final String status;

//   UpdateStatusButtonPressed({this.id, this.status});
// }

class VerifyBookingTabPressed extends VerifyBookingEvent {}
