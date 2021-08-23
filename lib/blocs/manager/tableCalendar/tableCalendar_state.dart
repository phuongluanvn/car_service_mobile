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
  final List<CrewModel> processList;
  final List<CrewModel> finishList;
  final List<OrderDetailModel> tableCalendarDetail;
  final String message;
  const TableCalendarState({
    this.status: TableCalendarStatus.init,
    this.detailStatus: TableCalendarDetailStatus.init,
    this.tableCalendarDetail: const [],
    this.tableCalendarList: const [],
    this.processList: const [],
    this.finishList: const [],
    this.message: '',
  });

  TableCalendarState copyWith({
    TableCalendarStatus status,
    TableCalendarDetailStatus detailStatus,
    List<CrewModel> tableCalendarList,
    List<OrderDetailModel> tableCalendarDetail,
    List<CrewModel> processList,
    List<CrewModel> finishList,
    String message,
  }) =>
      TableCalendarState(
        status: status ?? this.status,
        detailStatus: detailStatus ?? this.detailStatus,
        tableCalendarList: tableCalendarList ?? this.tableCalendarList,
        tableCalendarDetail: tableCalendarDetail ?? this.tableCalendarDetail,
        message: message ?? this.message,
        processList: processList?? this.processList,
        finishList: finishList?? this.finishList,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        tableCalendarList,
        tableCalendarDetail,
        processList,
        finishList,
        message,
      ];
}


