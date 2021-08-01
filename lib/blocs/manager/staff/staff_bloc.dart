import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageStaffBloc extends Bloc<ManageStaffEvent, ManageStaffState> {
  ManagerRepository _repo;

  ManageStaffBloc({ManagerRepository repo})
      : _repo = repo,
        super(ManageStaffState());

  @override
  Stream<ManageStaffState> mapEventToState(ManageStaffEvent event) async* {
    if (event is DoListStaffEvent) {
      List<StaffModel> listTest = [];
      yield state.copyWith(status: StaffStatus.loading);
      try {
        var staffList = await _repo.getStaffList();
        staffList.map((e) => {
          if(e.role == 'staff') {
            listTest.add(e)
          }
        }).toList();
        print(listTest);
        if (staffList != null) {
          yield state.copyWith(
              staffList: listTest, status: StaffStatus.staffListsuccess);
        } else {
          yield state.copyWith(
            status: StaffStatus.error,
            message: 'Staff Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          status: StaffStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is DoStaffDetailEvent) {
      yield state.copyWith(detailStatus: StaffDetailStatus.loading);
      try {
        print('check 1: ' + event.username);
        List<StaffModel> data = await _repo.getStaffDetail(event.username);
        if (data != null) {
          print("Not null");
          yield state.copyWith(
            detailStatus: StaffDetailStatus.success,
            staffDetail: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: StaffDetailStatus.error,
            message: 'Detail Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: StaffDetailStatus.error, message: e.toString());
      }
    } else if (event is DoListSelectStaffEvent) {
      yield state.copyWith(staffSelectStt: StaffSelectStatus.loading);
      try {
        var data = event.listDataStaff;
        if (data != null) {
          print("Not null");
          yield state.copyWith(
            staffSelectStt: StaffSelectStatus.success,
            staffSelect: data,
          );
        } else {
          yield state.copyWith(
            staffSelectStt: StaffSelectStatus.error,
            message: 'Detail Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            staffSelectStt: StaffSelectStatus.error, message: e.toString());
      }
    }
  }
}
