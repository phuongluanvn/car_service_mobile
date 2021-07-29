import 'package:car_service/blocs/manager/selected_data/select_data__events.dart';
import 'package:car_service/blocs/manager/selected_data/select_data__state.dart';

import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectDataBloc extends Bloc<SelectDataEvent, SelectDataState> {
  ManagerRepository _repo;

  SelectDataBloc({ManagerRepository repo})
      : _repo = repo,
        super(SelectDataState());

  @override
  Stream<SelectDataState> mapEventToState(SelectDataEvent event) async* {
    if (event is DoListSelectStaffEvent) {
      yield state.copyWith(staffSelectStt: SelectStaffStatus.loading);
      try {
        var data = event.listDataStaff;
        if (data != null) {
          print("Not null");
          yield state.copyWith(
            staffSelectStt: SelectStaffStatus.success,
            staffSelect: data,
          );
        } else {
          yield state.copyWith(
            staffSelectStt: SelectStaffStatus.error,
            message: 'Detail Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            staffSelectStt: SelectStaffStatus.error, message: e.toString());
      }
    }
  }
}
