import 'package:bloc/bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:equatable/equatable.dart';

class StaffCubit extends Cubit<StaffState> {
  ManagerRepository _repro;

  StaffCubit(StaffState initialState, this._repro) : super(initialState);

  // Get Data movie from json
  Future<void> getStaffList() async {
    List<StaffModel> bookinglist = await _repro.getStaffList();
    try {
      if (bookinglist != null) {
        emit(StaffListSuccessState(staffList: bookinglist));
      } else {
        emit(StaffLoadingState());
      }
    } catch (e) {
      emit(StaffListErrorState(message: e.toString()));
    }
  }
}
