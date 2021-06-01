import 'package:car_service/blocs/login/auth_events.dart';
import 'package:car_service/blocs/login/auth_state.dart';
import 'package:car_service/repository/auth_repo.dart';
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
      var data = await repo.login(event.email, event.password);
      if (data['type'] == 'manager') {
        pref.setString("token", data['token']);
        pref.setInt("type", data['type']);
        pref.setString("email", data['email']);
        yield ManagerLoginSuccessState();
      } else if (data['type'] == 'staff') {
        pref.setString("token", data['token']);
        pref.setInt("type", data['type']);
        pref.setString("email", data['email']);
        yield StaffLoginSuccessState();
      } else if (data['type'] == 'customer') {
        pref.setString("token", data['token']);
        pref.setInt("type", data['type']);
        pref.setString("email", data['email']);
        yield CustomerLoginSuccessState();
      } else {
        yield LoginErrorState(message: "Auth Error");
      }
    }
  }
}
