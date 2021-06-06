import 'package:car_service/utils/model/BookingModel.dart';
import 'package:equatable/equatable.dart';

class VerifyBookingState extends Equatable {
  @override
  List<Object> get props => [];
}

class VerifyBookingInitState extends VerifyBookingState {}

class VerifyBookingLoadingState extends VerifyBookingState {}

class VerifyBookingSuccessState extends VerifyBookingState {
  List<BookingModel> bookingList;
  VerifyBookingSuccessState({this.bookingList});
}

class VerifyBookingErrorState extends VerifyBookingState {
  final String message;
  VerifyBookingErrorState({this.message});
}
