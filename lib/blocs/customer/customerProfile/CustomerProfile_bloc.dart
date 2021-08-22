import 'dart:convert';

import 'package:car_service/blocs/customer/customerProfile/CustomerEditProfile_event.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerEditProfile_state.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerProfile_event.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerProfile_state.dart';
import 'package:car_service/blocs/sign_up/sign_up_events.dart';
import 'package:car_service/blocs/sign_up/sign_up_state.dart';
import 'package:car_service/utils/repository/auth_repo.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  CustomerRepository _repo;

  ProfileBloc({CustomerRepository repo})
      : _repo = repo,
        super(ProfileState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetProfileByUsername) {
      yield state.copyWith(status: ProfileStatus.loading);
      try {
        var data = await _repo.getProfile(event.username);
        if (data != null) {
          yield state.copyWith(
            cusProfile: data,
            status: ProfileStatus.getProflieSuccess);
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
