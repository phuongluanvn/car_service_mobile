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

class VerifyBookingTabPressed extends VerifyBookingEvent {}
