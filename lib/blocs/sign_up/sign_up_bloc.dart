import 'dart:convert';

import 'package:car_service/blocs/sign_up/sign_up_events.dart';
import 'package:car_service/blocs/sign_up/sign_up_state.dart';
import 'package:car_service/utils/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            event.username, event.password, event.email, event.phoneNumber, event.fullname, event.address);
        String jsonsDataString = data.toString();
        final jsonData = jsonDecode(jsonsDataString);
        print(jsonData);
        if (jsonData != null) {
          // } else if (jsonData['maLoaiNguoiDung'] == 'NhanVien') {
          //   pref.setString("token", data['token']);
          //   pref.setInt("type", data['type']);
          //   pref.setString("email", data['email']);
          //   yield StaffLoginSuccessState();
          // } else if (jsonData['maLoaiNguoiDung'] == 'KhachHang') {
          //   pref.setString("token", data['token']);
          //   pref.setInt("type", data['type']);
          //   pref.setString("email", data['email']);
          yield state.copyWith(status: SignUpStatus.signUpSuccess);
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
