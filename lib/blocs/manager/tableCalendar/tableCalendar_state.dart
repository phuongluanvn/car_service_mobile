import 'package:car_service/utils/model/CalendarModel.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/TaskModel.dart';
import 'package:equatable/equatable.dart';

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
  final List<Absences> absList;
  final TableCalendarStatus status;
  final TableCalendarDetailStatus detailStatus;
  final List<TaskModel> tableCalendarList;
  final List<CalendarModel> taskLists;
  final List<TaskModel> processList;
  final List<TaskModel> finishList;
  final List<OrderDetailModel> tableCalendarDetail;
  final String message;
  const TableCalendarState({
    this.status: TableCalendarStatus.init,
    this.detailStatus: TableCalendarDetailStatus.init,
    this.tableCalendarDetail: const [],
    this.tableCalendarList: const [],
    this.taskLists: const [],
    this.processList: const [],
    this.finishList: const [],
    this.absList: const[],
    this.message: '',
  });

  TableCalendarState copyWith({
    TableCalendarStatus status,
    TableCalendarDetailStatus detailStatus,
    List<TaskModel> tableCalendarList,
    List<CalendarModel> taskLists,
    List<OrderDetailModel> tableCalendarDetail,
    List<TaskModel> processList,
    List<TaskModel> finishList,
    List<Absences> absList,
    String message,
  }) =>
      TableCalendarState(
        status: status ?? this.status,
        detailStatus: detailStatus ?? this.detailStatus,
        tableCalendarList: tableCalendarList ?? this.tableCalendarList,
        taskLists: taskLists ?? this.taskLists,
        tableCalendarDetail: tableCalendarDetail ?? this.tableCalendarDetail,
        message: message ?? this.message,
        processList: processList ?? this.processList,
        finishList: finishList ?? this.finishList,
        absList: absList ?? this.absList,

      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        tableCalendarList,
        taskLists,
        tableCalendarDetail,
        processList,
        finishList,
        message,
        absList
      ];
}
