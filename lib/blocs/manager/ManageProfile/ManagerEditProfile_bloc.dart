import 'dart:convert';
import 'package:car_service/blocs/manager/ManageProfile/ManagerEditProfile_event.dart';
import 'package:car_service/blocs/manager/ManageProfile/ManagerEditProfile_state.dart';
import 'package:car_service/utils/repository/manager_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagerEditProfileBloc extends Bloc<ManagerEditProfileEvent, ManagerEditProfileState> {
  ManagerRepository _repo;

  ManagerEditProfileBloc({ManagerRepository repo})
      : _repo = repo,
        super(ManagerEditProfileState());

  @override
  Stream<ManagerEditProfileState> mapEventToState(ManagerEditProfileEvent event) async* {
    if (event is EditManagerProfileButtonPressed) {
      yield state.copyWith(status: EditProfileStatus.loading);
      try {
        var data = await _repo.editProfile(event.username, event.fullname,
            event.phoneNumber, event.email, event.address);
        String jsonsDataString = data.toString();
        final jsonData = jsonDecode(jsonsDataString);
        print(jsonData);
        if (jsonData != null) {
          yield state.copyWith(status: EditProfileStatus.editSuccess);
        } else {
          yield state.copyWith(
              status: EditProfileStatus.error, message: 'Error Edit');
        }
      } catch (e) {
        yield state.copyWith(
          status: EditProfileStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
