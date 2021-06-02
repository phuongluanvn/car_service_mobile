import 'dart:convert';

import 'package:car_service/blocs/sign_up/sign_up_events.dart';
import 'package:car_service/blocs/sign_up/sign_up_state.dart';
import 'package:car_service/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthRepository repo;
  SignUpBloc(SignUpState initialState, this.repo) : super(initialState);

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    var pref = await SharedPreferences.getInstance();
    if (event is SignUpButtonPressed) {
      yield SignUpLoadingState();
      var data = await repo.signUp(
          event.user, event.name, event.email, event.phone, event.password);
      // String jsonsDataString = data.toString();
      // final jsonData = jsonDecode(jsonsDataString);
      // print(jsonData);
      // if (jsonData != null) {
        // } else if (jsonData['maLoaiNguoiDung'] == 'NhanVien') {
        //   pref.setString("token", data['token']);
        //   pref.setInt("type", data['type']);
        //   pref.setString("email", data['email']);
        //   yield StaffLoginSuccessState();
        // } else if (jsonData['maLoaiNguoiDung'] == 'KhachHang') {
        //   pref.setString("token", data['token']);
        //   pref.setInt("type", data['type']);
        //   pref.setString("email", data['email']);
      //   yield CustomerSignUpSuccessState();
      // } else {
      //   yield SignUpErrorState(message: "SignUp Error");
      // }
    }
  }
}
