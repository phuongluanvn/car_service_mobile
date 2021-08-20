import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_events.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_state.dart';
import 'package:car_service/utils/model/BookingModel.dart';
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
      yield state.copyWith(status: TableCalendarStatus.loading);
      try {
        List<OrderDetailModel> historyList = await _repo.getCalendarList();
        if (historyList != null) {
          print(historyList);
          yield state.copyWith(
              tableCalendarList: historyList,
              status: TableCalendarStatus.tableCalendarSuccess);
        } else {
          yield state.copyWith(
            status: TableCalendarStatus.error,
            message: 'Error',
          );
          print('no data');
        }
      } catch (e) {
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
    }
  }
}
