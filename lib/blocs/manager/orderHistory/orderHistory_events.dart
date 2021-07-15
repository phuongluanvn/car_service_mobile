import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:equatable/equatable.dart';

abstract class OrderHistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListOrderHistoryEvent extends OrderHistoryEvent {}

class DoOrderHistoryDetailEvent extends OrderHistoryEvent {
  final String id;
  DoOrderHistoryDetailEvent({this.id});
  @override
  List<Object> get props => [id];
}

// class UpdateStatusButtonPressed extends VerifyBookingEvent {
//   final String id;
//   final String status;

//   UpdateStatusButtonPressed({this.id, this.status});
// }
