import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:equatable/equatable.dart';

abstract class TableCalendarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListTableCalendarEvent extends TableCalendarEvent {
   final String username;
  DoListTableCalendarEvent({this.username});
  @override
  List<Object> get props => [username];
}

class DoTableCalendarDetailEvent extends TableCalendarEvent {
  final String id;
  DoTableCalendarDetailEvent({this.id});
  @override
  List<Object> get props => [id];
}

// class UpdateStatusButtonPressed extends VerifyBookingEvent {
//   final String id;
//   final String status;

//   UpdateStatusButtonPressed({this.id, this.status});
// }
