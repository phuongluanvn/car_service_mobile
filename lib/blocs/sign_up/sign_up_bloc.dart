import 'package:car_service/blocs/login/auth_events.dart';
import 'package:car_service/blocs/login/auth_state.dart';
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
    // if (event is StartEvent) {
    //   yield LoginInitState();
    // } else if (event is SignUpButtonPressed) {
    //   yield LoginLoadingState();
    //   var data = await repo.login(event.email, event.password);
    //   if (data['type'] == 'manager') {
    //     pref.setString("token", data['token']);
    //     pref.setInt("type", data['type']);
    //     pref.setString("email", data['email']);
    //     yield ManagerLoginSuccessState();
    //   } else {
    //     yield LoginErrorState(message: "Auth Error");
    //   }
    // }
  }
}
