import 'dart:convert';
import 'dart:math';

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
        var data = await _repo.updateCrewByName(event.id, event.crewId);
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
    if (event is CreateCrewEvent) {
      print(event.listUsername);
      yield state.copyWith(createStatus: CreateCrewStatus.loading);
      try {
        // print(event.listName);
        var data = await _repo.createCrew(event.listUsername);
        if (data != null) {
          yield state.copyWith(
              message: data, createStatus: CreateCrewStatus.success);
        } else {
          yield state.copyWith(
              createStatus: CreateCrewStatus.error, message: data);
        }
      } catch (e) {
        yield state.copyWith(
          createStatus: CreateCrewStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is DoCrewDetailEvent) {
      yield state.copyWith(statusDetail: DoCrewDetailStatus.loading);
      try {
        // print('check 1: ' + event.username);
        List<CrewModel> data = await _repo.getCrewDetail(event.id);
        if (data != null) {
          print("Not null");
          yield state.copyWith(
            statusDetail: DoCrewDetailStatus.success,
            crewDetails: data,
          );
        } else {
          yield state.copyWith(
            statusDetail: DoCrewDetailStatus.error,
            message: 'Detail Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            statusDetail: DoCrewDetailStatus.error, message: e.toString());
      }
    } else if (event is DoReloadStatus) {
      yield (state.copyWith(statusDetail: DoCrewDetailStatus.loading));
      yield (state.copyWith(statusDetail: DoCrewDetailStatus.success));
    } else if (event is EditCrewEvent) {
      print(event.listUsername);
      yield state.copyWith(updateCrewStatus: UpdateCrewStatus.loading);
      try {
        // print(event.listName);
        var data = await _repo.updateCrew(event.id, event.listUsername);
        if (data != null) {
          yield state.copyWith(
              message: data, updateCrewStatus: UpdateCrewStatus.success);
        } else {
          yield state.copyWith(
              updateCrewStatus: UpdateCrewStatus.error, message: data);
        }
      } catch (e) {
        yield state.copyWith(
          updateCrewStatus: UpdateCrewStatus.error,
          message: e.toString(),
        );
      }
    }
    if (event is DoListAvailCrew) {
      yield state.copyWith(status: ListCrewStatus.loading);
      try {
        List<CrewModel> bookingList = await _repo.getAvailCrewList();
        if (bookingList != null) {
          // print('hasdata');
          yield state.copyWith(
              crewAvailList: bookingList, status: ListCrewStatus.availSuccess);
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
    // if (event is UpdateCrewAgainEvent) {
    //   yield state.copyWith(updateStatus: DoUpdateStatus.loading);
    //   try {
    //     // print(event.listName);
    //     var data = await _repo.updateCrewByName(event.id, event.crewId);
    //     if (data != null) {
    //       print(data);
    //       yield state.copyWith(updateStatus: DoUpdateStatus.againsuccess);
    //       print('Assign Crew success');
    //     } else {
    //       yield state.copyWith(
    //         updateStatus: DoUpdateStatus.error,
    //         message: 'Assin Error',
    //       );
    //       print('no data');
    //     }
    //   } catch (e) {
    //     yield state.copyWith(
    //       updateStatus: DoUpdateStatus.error,
    //       message: e.toString(),
    //     );
    //   }
    // }
  }
}
