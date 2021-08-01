import 'dart:convert';

import 'package:car_service/blocs/login/auth_events.dart';
import 'package:car_service/blocs/login/auth_state.dart';
import 'package:car_service/utils/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// {
//   "username": "annp@css.com",
//   "role": "manager",
//   "profile": {
//     "Fullname": "Nguyen Phuoc An",
//     "DateOfBirth": "1998-02-21T00:00:00",
//     "PhoneNumber": "0901179498",
//     "Status": "available"
//   },
//   "jwt": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFubnBAY3NzLmNvbSIsInJvbGUiOiJtYW5hZ2VyIiwibmJmIjoxNjI3NjU5MjAzLCJleHAiOjE2Mjc2NjI4MDMsImlhdCI6MTYyNzY1OTIwM30.hmt0A1lLQRtfat30NkOxBU4J5XBluKcTMVgPbZURTCI"
// }
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
          var dataProfile = data['profile'];
          var enc = json.encode(dataProfile);
          var dec = json.decode(enc);

          pref.setString("Fullname", dec['Fullname']);
          pref.setString("PhoneNumber", dec['PhoneNumber']);
          pref.setString("DateOfBirth", dec['DateOfBirth']);
          pref.setString("Status", dec['Status']);
          pref.setString("Username", data['username']);

          yield ManagerLoginSuccessState();
        } else if (data['role'] == 'staff') {
          var dataProfile = data['profile'];
          var enc = json.encode(dataProfile);
          var dec = json.decode(enc);

          pref.setString("Fullname", dec['Fullname']);
          pref.setString("PhoneNumber", dec['PhoneNumber']);
          pref.setString("DateOfBirth", dec['DateOfBirth']);
          pref.setString("Status", dec['Status']);
          pref.setString("Username", data['username']);

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
          pref.setString("Username", data['username']);

          yield CustomerLoginSuccessState();
        } else {
          yield LoginErrorState(message: "Auth Error");
        }
      }
    }
  }
}
