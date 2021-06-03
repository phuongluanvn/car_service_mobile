import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:equatable/equatable.dart';

abstract class VerifyBookingEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class DoListBookingEvent extends VerifyBookingEvent{
  
}

class VerifyBookingTabPressed extends VerifyBookingEvent {
  
  
}
