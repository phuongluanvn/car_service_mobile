import 'dart:convert';

import 'package:car_service/blocs/sign_up/sign_up_events.dart';
import 'package:car_service/blocs/sign_up/sign_up_state.dart';
import 'package:car_service/utils/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthRepository _repo;

  SignUpBloc({AuthRepository repo})
      : _repo = repo,
        super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpButtonPressed) {
      yield state.copyWith(status: SignUpStatus.loading);
      try {
        var data = await _repo.signUp(
            event.username, event.password, event.email, event.fullname, event.phoneNumber, event.address);
        String jsonsDataString = data.toString();
        final jsonData = jsonDecode(jsonsDataString);
        print(jsonData);
        if (jsonData != null) {
          yield state.copyWith(
            message: data,
            status: SignUpStatus.signUpSuccess);
        } else {
          yield state.copyWith(
              status: SignUpStatus.error, message: 'Error SignUp');
        }
      } catch (e) {
        yield state.copyWith(
          status: SignUpStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
