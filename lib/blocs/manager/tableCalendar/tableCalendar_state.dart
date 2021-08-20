import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/TestOrderModel.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/model/BookingModel.dart';
import '../../../utils/model/BookingModel.dart';

enum TableCalendarStatus {
  init,
  loading,
  tableCalendarSuccess,
  error,
}

enum TableCalendarDetailStatus {
  init,
  loading,
  success,
  updateStatusSuccess,
  error,
}

class TableCalendarState extends Equatable {
  final TableCalendarStatus status;
  final TableCalendarDetailStatus detailStatus;
  final List<CrewModel> tableCalendarList;
  final List<OrderDetailModel> tableCalendarDetail;
  final String message;
  const TableCalendarState({
    this.status: TableCalendarStatus.init,
    this.detailStatus: TableCalendarDetailStatus.init,
    this.tableCalendarDetail: const [],
    this.tableCalendarList: const [],
    this.message: '',
  });

  TableCalendarState copyWith({
    TableCalendarStatus status,
    TableCalendarDetailStatus detailStatus,
    List<CrewModel> tableCalendarList,
    List<OrderDetailModel> tableCalendarDetail,
    String message,
  }) =>
      TableCalendarState(
        status: status ?? this.status,
        detailStatus: detailStatus ?? this.detailStatus,
        tableCalendarList: tableCalendarList ?? this.tableCalendarList,
        tableCalendarDetail: tableCalendarDetail ?? this.tableCalendarDetail,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        tableCalendarList,
        tableCalendarDetail,
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
