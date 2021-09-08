import 'dart:convert';

import 'package:car_service/blocs/manager/CrewManagement/crew_event.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_state.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/accessory_model.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrewBloc extends Bloc<CrewEvent, CrewState> {
  ManagerRepository _repo;

  CrewBloc({ManagerRepository repo})
      : _repo = repo,
        super(CrewState());

  @override
  Stream<CrewState> mapEventToState(CrewEvent event) async* {
    if (event is UpdateCrewToListEvent) {
      yield state.copyWith(updateStatus: DoUpdateStatus.loading);
      try {
        // print(event.listName);
        var data = await _repo.updateCrewByName(event.id, event.selectCrew);
        if (data != null) {
          print(data);
          yield state.copyWith(
              crewList: data, updateStatus: DoUpdateStatus.success);
          print('Update Crew success');
        } else {
          yield state.copyWith(
            updateStatus: DoUpdateStatus.error,
            message: 'Assin Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          updateStatus: DoUpdateStatus.error,
          message: e.toString(),
        );
      }
    }
    if (event is DoListCrew) {
      yield state.copyWith(status: ListCrewStatus.loading);
      try {
        List<CrewModel> bookingList = await _repo.getCrewList();
        if (bookingList != null) {
          print('hasdata');
          yield state.copyWith(
              crewList: bookingList, status: ListCrewStatus.success);
        } else {
          yield state.copyWith(
            status: ListCrewStatus.error,
            message: 'Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          status: ListCrewStatus.error,
          message: e.toString(),
        );
        ;
      }
    }
  }
}
