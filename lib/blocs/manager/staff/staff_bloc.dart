import 'dart:convert';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  ManagerRepository repo;
  StaffBloc(StaffState initialState, this.repo) : super(initialState);

  @override
  Stream<StaffState> mapEventToState(StaffEvent event) async* {
    if (event is DoListStaffEvent) {
      yield StaffLoadingState();
      try {
        var staffList = await repo.getStaffList();
        if (staffList != null) {
          yield StaffListSuccessState(staffList: staffList);
          print('dada');
        } else {
          yield StaffLoadingState();
          print('no data');
        }
      } catch (e) {
        yield StaffListErrorState(message: e.toString());
      }
    } else if (event is DoStaffDetailEvent) {
      yield StaffLoadingState();
      try {
        var data = await repo.getStaffDetail(event.email);
        if (data != null) {
          yield StaffDetailSucessState(data: data);
          print(data);
        } else {
          yield StaffLoadingState();
          print('no data detail');
        }
      } catch (e) {
        yield StaffListErrorState(message: e.toString());
      }
    }
  }
}
