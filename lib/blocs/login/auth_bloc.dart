import 'dart:convert';

import 'package:car_service/blocs/login/auth_events.dart';
import 'package:car_service/blocs/login/auth_state.dart';
import 'package:car_service/utils/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthRepository repo;
  AuthBloc(AuthState initialState, this.repo) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvents event) async* {
    var pref = await SharedPreferences.getInstance();
    if (event is StartEvent) {
      yield LoginInitState();
    } else if (event is LoginButtonPressed) {
      yield LoginLoadingState();
      var res = await repo.login(event.email, event.password);
      var data = json.decode(res);
      print(data);

      if (data != null) {
        if (data['role'] == 'manager') {
          // pref.setString("token", data['accessToken']);
          // pref.setString("email", data['email']);
          yield ManagerLoginSuccessState();
        } else if (data['role'] == 'staff') {
          //   pref.setString("token", data['token']);
          //   pref.setInt("type", data['type']);
          //   pref.setString("email", data['email']);
          yield StaffLoginSuccessState();
        } else if (data['role'] == 'customer') {
          var dataProfile = data['profile'];
          var enc = json.encode(dataProfile);
          var dec = json.decode(enc);
          pref.setString("Fullname", dec['Fullname']);
          pref.setInt("AccumulatedPoint", dec['AccumulatedPoint']);
          pref.setString("PhoneNumber", dec['PhoneNumber']);
          pref.setString("Address", dec['Address']);
          pref.setString("Email", dec['Email']);

          yield CustomerLoginSuccessState();
        } else {
          yield LoginErrorState(message: "Auth Error");
        }
      }
    }
  }
}
