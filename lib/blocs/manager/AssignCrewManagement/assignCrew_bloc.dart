import 'dart:convert';
import 'dart:math';

import 'package:car_service/blocs/manager/AssignCrewManagement/assignCrew_event.dart';
import 'package:car_service/blocs/manager/AssignCrewManagement/assignCrew_state.dart';

import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/accessory_model.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignCrewBloc extends Bloc<AssignCrewEvent, AssignCrewState> {
  ManagerRepository _repo;

  AssignCrewBloc({ManagerRepository repo})
      : _repo = repo,
        super(AssignCrewState());

  @override
  Stream<AssignCrewState> mapEventToState(AssignCrewEvent event) async* {
    
    if (event is UpdateCrewAgainEvent) {
      yield state.copyWith(assignStatus: DoAssignCrewStatus.loading);
      try {
        // print(event.listName);
        var data = await _repo.updateCrewByName(event.id, event.crewId);
        if (data != null) {
          print(data);
          yield state.copyWith(assignStatus: DoAssignCrewStatus.againsuccess);
          print('Assign Crew success');
        } else {
          yield state.copyWith(
            assignStatus: DoAssignCrewStatus.error,
            message: 'Assin Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          assignStatus: DoAssignCrewStatus.error,
          message: e.toString(),
        );
      }
    }else if (event is DoListAssignCrew) {
      yield state.copyWith(status: DoListAssignCrewStatus.loading);
      try {
        List<CrewModel> bookingList = await _repo.getCrewList();
        if (bookingList != null) {
          print('hasdata');
          yield state.copyWith(
              assignCrewList: bookingList, status: DoListAssignCrewStatus.success);
        } else {
          yield state.copyWith(
            status: DoListAssignCrewStatus.error,
            message: 'Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          status: DoListAssignCrewStatus.error,
          message: e.toString(),
        );
        ;
      }
    }
  }
}
