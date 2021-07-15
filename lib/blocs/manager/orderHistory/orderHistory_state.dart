import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/TestOrderModel.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/model/BookingModel.dart';
import '../../../utils/model/BookingModel.dart';

enum OrderHistoryStatus {
  init,
  loading,
  historySuccess,
  historyDetailSuccess,
  error,
}

enum OrderHistoryDetailStatus {
  init,
  loading,
  success,
  updateStatusSuccess,
  error,
}

class OrderHistoryState extends Equatable {
  final OrderHistoryStatus status;
  final OrderHistoryDetailStatus detailStatus;
  final List<OrderDetailModel> historyList;
  final List<OrderDetailModel> historyDetail;
  final String message;
  const OrderHistoryState({
    this.status: OrderHistoryStatus.init,
    this.detailStatus: OrderHistoryDetailStatus.init,
    this.historyDetail: const [],
    this.historyList: const [],
    this.message: '',
  });

  OrderHistoryState copyWith({
    OrderHistoryStatus status,
    OrderHistoryDetailStatus detailStatus,
    List<OrderDetailModel> historyList,
    List<OrderDetailModel> historyDetail,
    String message,
  }) =>
      OrderHistoryState(
        status: status ?? this.status,
        detailStatus: detailStatus ?? this.detailStatus,
        historyList: historyList ?? this.historyList,
        historyDetail: historyDetail ?? this.historyDetail,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        historyList,
        historyDetail,
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
