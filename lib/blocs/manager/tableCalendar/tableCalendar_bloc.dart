import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_events.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_state.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/CalendarModel.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TableCalendarBloc extends Bloc<TableCalendarEvent, TableCalendarState> {
  ManagerRepository _repo;

  TableCalendarBloc({ManagerRepository repo})
      : _repo = repo,
        super(TableCalendarState());

  @override
  Stream<TableCalendarState> mapEventToState(TableCalendarEvent event) async* {
    if (event is DoListTableCalendarEvent) {
      List<CrewModel> finishList = [];
      List<CrewModel> processList = [];
      yield state.copyWith(status: TableCalendarStatus.loading);
      try {
        List<Absences> absenceList =
            await _repo.getAbsencesList(event.username);
            print(absenceList);
        List<CrewModel> historyList =
            await _repo.getCalendarList(event.username);
        // print(historyList);
        historyList
            .map((orderT) => {
                  // if (orderT.order.status == 'Đang tiến hành' ||
                  //     orderT.order.status == 'Kiểm tra')
                  //   {
                  //     processList.add(orderT),
                  //     print(orderT.order.status),
                  //   }
                  // else if (orderT.order.status == 'Hoàn thành')
                  //   {
                  //     finishList.add(orderT),
                  //     print(finishList),
                  //   }
                })
            .toList();

        if (historyList != null) {
          yield state.copyWith(
              tableCalendarList: historyList,
              finishList: finishList,
              processList: processList,
              absList: absenceList,
              status: TableCalendarStatus.tableCalendarSuccess);
        } else {
          yield state.copyWith(
            status: TableCalendarStatus.error,
            message: 'Error',
          );
          print('no data');
        }
      } catch (e) {
        print(e);
        yield state.copyWith(
          status: TableCalendarStatus.error,
          message: e.toString(),
        );
        ;
      }
    } else if (event is DoTableCalendarDetailEvent) {
      yield state.copyWith(detailStatus: TableCalendarDetailStatus.loading);
      try {
        print('check 1: ' + event.id);
        List<OrderDetailModel> data =
            await _repo.getVerifyOrderDetail(event.id);
        if (data != null) {
          print("Not null");
          yield state.copyWith(
            detailStatus: TableCalendarDetailStatus.success,
            tableCalendarDetail: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: TableCalendarDetailStatus.error,
            message: 'Detail Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: TableCalendarDetailStatus.error,
            message: e.toString());
      }
    } else if (event is DoListTaskEvent) {
      // List<CalendarModel> allTasks = [];
      yield state.copyWith(status: TableCalendarStatus.loading);
      try {
        List<CalendarModel> allTasks =
            await _repo.getTaskListNew(event.username);
        // allTasks.map((orderT) => {}).toList();
        print(allTasks);
        if (allTasks != null) {
          yield state.copyWith(
              taskLists: allTasks,
              status: TableCalendarStatus.tableCalendarSuccess);
        } else {
          yield state.copyWith(
            status: TableCalendarStatus.error,
            message: 'Error',
          );
          print('no data');
        }
      } catch (e) {
        print(e);
        yield state.copyWith(
          status: TableCalendarStatus.error,
          message: e.toString(),
        );
        ;
      }
    }
  }
}
