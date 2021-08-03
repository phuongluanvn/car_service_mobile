import 'dart:convert';

import 'package:car_service/blocs/manager/CrewManagement/crew_event.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_state.dart';
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
        var data = await _repo.updateCrewByName(event.id, event.listName);
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
    //   else if (event is DoAccessoryDetailEvent) {
    //     yield state.copyWith(statusDetail: DoAccessoryDetailStatus.loading);
    //     try {
    //       List<AccessoryModel> data = await _repo.getAccessoryByName(event.name);
    //       print('hihihihihuhuhuhu');
    //       print(data);
    //       if (data != null) {
    //         yield state.copyWith(
    //           statusDetail: DoAccessoryDetailStatus.success,
    //           accessoryList: data,
    //         );
    //       } else {
    //         yield state.copyWith(
    //           statusDetail: DoAccessoryDetailStatus.error,
    //           message: 'Detail Error',
    //         );
    //       }
    //     } catch (e) {
    //       yield state.copyWith(
    //           statusDetail: DoAccessoryDetailStatus.error, message: e.toString());
    //     }
    //   }
  }
}
