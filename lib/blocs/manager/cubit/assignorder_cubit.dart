import 'package:bloc/bloc.dart';
import 'package:car_service/blocs/manager/cubit/assignorder_cubit_state.dart';
import 'package:car_service/utils/model/StaffModel.dart';

class AssignorderCubit extends Cubit<AssignorderCubitState> {
  AssignorderCubit() : super(AssignorderCubitState());

  onListChanged(List<StaffModel> listdata) {
    emit(state.copyWith(listStaff: listdata));
  }

  addItem(StaffModel item) {
    emit(state.copyWith(status: AssignCubitStatus.loading));
    List<StaffModel> listdata = state.listStaff;
    if (listdata.isEmpty) {
      listdata = [item];
    } else {
      listdata.add(item);
    }

    emit(state.copyWith(
        listStaff: listdata, status: AssignCubitStatus.loadingSuccess));
  }

  removeItem(StaffModel item) {
    emit(state.copyWith(status: AssignCubitStatus.loading));
    List<StaffModel> listdata = state.listStaff;
    if (listdata.isEmpty) {
      listdata = [item];
    } else {
      listdata.remove(item);
    }
    emit(state.copyWith(
        listStaff: listdata, status: AssignCubitStatus.loadingSuccess));
  }
}