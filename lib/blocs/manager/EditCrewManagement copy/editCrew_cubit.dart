import 'dart:convert';
import 'dart:math';

import 'package:car_service/blocs/manager/EditCrewManagement%20copy/editCrew_state.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/createCrewModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCrewCubit extends Cubit<EditCrewState> {
  EditCrewCubit() : super(EditCrewState());

  prepareSelectedList(List<Members> editList) {
    List<CreateCrewModel> selectedList = [];

    for (int i = 0; i < editList.length; i++) {
      selectedList.add(CreateCrewModel(username: editList[i].username));
    }
    print("Prepare selected success");
    emit(state.copyWith(
        selectedList: selectedList, loadSelectedListSuccess: true));
  }

  prepareUnselectedList(List<StaffModel> staffList) {
    List<CreateCrewModel> unselectedList = [];
    for (int i = 0; i < staffList.length; i++) {
      unselectedList.add(CreateCrewModel(username: staffList[i].username));
    }
    // staffList.forEach((element) {
    //   unselectedList.add(CreateCrewModel(username: element.username));
    // });
    print("Prepare unselected success");
    emit(state.copyWith(
        unselectedList: unselectedList, loadUnselectedListSuccess: true));
  }

  addCrew(CreateCrewModel createCrewModel) {
    emit(state.copyWith(status: EditCrewStatus.loading));
    List<CreateCrewModel> selectedList = state.selectedList;
    List<CreateCrewModel> unselectedList = state.unselectedList;
    selectedList.add(createCrewModel);
    unselectedList.remove(createCrewModel);
    emit(state.copyWith(
        selectedList: selectedList,
        unselectedList: unselectedList,
        status: EditCrewStatus.success));
  }

  removeCrew(CreateCrewModel createCrewModel) {
    emit(state.copyWith(status: EditCrewStatus.loading));
    List<CreateCrewModel> selectedList = state.selectedList;
    List<CreateCrewModel> unselectedList = state.unselectedList;
    selectedList.remove(createCrewModel);
    unselectedList.add(createCrewModel);
    emit(state.copyWith(
        selectedList: selectedList,
        unselectedList: unselectedList,
        status: EditCrewStatus.success));
  }
}
