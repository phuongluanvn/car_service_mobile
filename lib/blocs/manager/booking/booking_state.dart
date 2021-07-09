import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/TestOrderModel.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/model/BookingModel.dart';
import '../../../utils/model/BookingModel.dart';

enum BookingStatus {
  init,
  loading,
  bookingSuccess,
  bookingDetailSuccess,
  error,
}

enum BookingDetailStatus {
  init,
  loading,
  success,
  error,
}

class VerifyBookingState extends Equatable {
  final BookingStatus status;
  final BookingDetailStatus detailStatus;
  final List<BookingModel> bookingList;
  final List<BookingModel> bookingDetail;
  final String message;
  const VerifyBookingState({
    this.status: BookingStatus.init,
    this.detailStatus: BookingDetailStatus.init,
    this.bookingDetail: const [],
    this.bookingList: const [],
    this.message: '',
  });

  VerifyBookingState copyWith({
    BookingStatus status,
    BookingDetailStatus detailStatus,
    List<BookingModel> bookingList,
    List<BookingModel> bookingDetail,
    String message,
  }) =>
      VerifyBookingState(
        status: status ?? this.status,
        detailStatus: detailStatus ?? this.detailStatus,
        bookingList: bookingList ?? this.bookingList,
        bookingDetail: bookingDetail ?? this.bookingDetail,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        bookingList,
        bookingDetail,
        message,
      ];
}

// class VerifyBookingInitState extends VerifyBookingState {}

// class VerifyBookingLoadingState extends VerifyBookingState {}

// class VerifyBookingSuccessState extends VerifyBookingState {
//   List<BookingModel> bookingList;
//   VerifyBookingSuccessState({this.bookingList});
// }

// class VerifyBookingDetailSucessState extends VerifyBookingState {
//   List<BookingModel> data;
//   VerifyBookingDetailSucessState({this.data});
// }

// class VerifyBookingErrorState extends VerifyBookingState {
//   final String message;
//   VerifyBookingErrorState({this.message});
// }
