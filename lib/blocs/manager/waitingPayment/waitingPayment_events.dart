import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:equatable/equatable.dart';

abstract class WaitingPaymentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListWaitingPaymentEvent extends WaitingPaymentEvent {}

class DoWaitingPaymentDetailEvent extends WaitingPaymentEvent {
  final String id;
  DoWaitingPaymentDetailEvent({this.id});
  @override
  List<Object> get props => [id];
}

// class UpdateStatusButtonPressed extends VerifyBookingEvent {
//   final String id;
//   final String status;

//   UpdateStatusButtonPressed({this.id, this.status});
// }
