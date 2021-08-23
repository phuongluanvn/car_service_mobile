import 'dart:convert';

import 'package:car_service/blocs/customer/customerProfile/CustomerEditProfile_event.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerEditProfile_state.dart';
import 'package:car_service/blocs/sign_up/sign_up_events.dart';
import 'package:car_service/blocs/sign_up/sign_up_state.dart';
import 'package:car_service/utils/repository/auth_repo.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditEmpProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  CustomerRepository _repo;

  EditEmpProfileBloc({CustomerRepository repo})
      : _repo = repo,
        super(EditProfileState());

  @override
  Stream<EditProfileState> mapEventToState(EditProfileEvent event) async* {
    if (event is EditProfileButtonPressed) {
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
