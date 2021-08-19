import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/TestOrderModel.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/model/BookingModel.dart';
import '../../../utils/model/BookingModel.dart';

enum WaitingPaymentStatus {
  init,
  loading,
  waitingPaymentSuccess,
  error,
}

enum WaitingPaymentDetailStatus {
  init,
  loading,
  success,
  updateStatusSuccess,
  error,
}

class WaitingPaymentState extends Equatable {
  final WaitingPaymentStatus status;
  final WaitingPaymentDetailStatus detailStatus;
  final List<OrderDetailModel> waitingPaymentList;
  final List<OrderDetailModel> waitingPaymentDetail;
  final String message;
  const WaitingPaymentState({
    this.status: WaitingPaymentStatus.init,
    this.detailStatus: WaitingPaymentDetailStatus.init,
    this.waitingPaymentDetail: const [],
    this.waitingPaymentList: const [],
    this.message: '',
  });

  WaitingPaymentState copyWith({
    WaitingPaymentStatus status,
    WaitingPaymentDetailStatus detailStatus,
    List<OrderDetailModel> waitingPaymentList,
    List<OrderDetailModel> waitingPaymentDetail,
    String message,
  }) =>
      WaitingPaymentState(
        status: status ?? this.status,
        detailStatus: detailStatus ?? this.detailStatus,
        waitingPaymentList: waitingPaymentList ?? this.waitingPaymentList,
        waitingPaymentDetail: waitingPaymentDetail ?? this.waitingPaymentDetail,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        waitingPaymentList,
        waitingPaymentDetail,
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
