import 'package:car_service/blocs/login/auth_bloc.dart';
import 'package:car_service/blocs/login/auth_state.dart';
import 'package:car_service/blocs/sign_up/sign_up_bloc.dart';
import 'package:car_service/blocs/sign_up/sign_up_state.dart';
import 'package:car_service/repository/auth_repo.dart';
import 'package:car_service/ui/Customer/CustomerHome.dart';
import 'package:car_service/ui/LoginUi.dart';
import 'package:car_service/ui/Manager/ManagerHome.dart';
import 'package:car_service/ui/Staff/StaffHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(Auth());

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc(LoginInitState(), AuthRepository())),
        BlocProvider(
            create: (context) => SignUpBloc(SignUpState(), AuthRepository()))
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => LoginUi(),
          '/manager': (context) => ManagerHome(),
          '/staff': (context) => StaffHome(),
          '/customer': (context) => CustomerHome(),
        },
      ),
    );
  }
}
