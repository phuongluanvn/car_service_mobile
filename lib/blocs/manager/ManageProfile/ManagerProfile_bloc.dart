import 'dart:convert';

import 'package:car_service/blocs/manager/ManageProfile/ManagerProfile_event.dart';
import 'package:car_service/blocs/manager/ManageProfile/ManagerProfile_state.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerProfileBloc
    extends Bloc<ManagerProfileEvent, ManagerProfileState> {
  ManagerRepository _repo;

  ManagerProfileBloc({ManagerRepository repo})
      : _repo = repo,
        super(ManagerProfileState());

  @override
  Stream<ManagerProfileState> mapEventToState(
      ManagerProfileEvent event) async* {
    if (event is GetManagerProfileByUsername) {
      yield state.copyWith(status: ProfileStatus.loading);
      try {
        var data = await _repo.getEmpProfile(event.username);
        print(data);
        if (data != null) {
          yield state.copyWith(
              managerProfile: data, status: ProfileStatus.getProflieSuccess);
        } else {
          yield state.copyWith(
              status: ProfileStatus.error, message: 'Error getprofile');
        }
      } catch (e) {
        yield state.copyWith(
          status: ProfileStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
