import 'package:car_service/blocs/login/auth_bloc.dart';
import 'package:car_service/blocs/login/auth_state.dart';
import 'package:car_service/blocs/manager/booking/booking_bloc.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/blocs/sign_up/sign_up_bloc.dart';
import 'package:car_service/blocs/sign_up/sign_up_state.dart';
import 'package:car_service/repository/auth_repo.dart';
import 'package:car_service/repository/manager_repo.dart';
import 'package:car_service/ui/Customer/CustomerHome.dart';
import 'package:car_service/ui/LoginUi.dart';
import 'package:car_service/ui/Manager/AssignBookingUi/VerifyBookingUi.dart';
import 'package:car_service/ui/Manager/ManagerProfile.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
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
            create: (context) => SignUpBloc(SignUpState(), AuthRepository())),
        BlocProvider(
            create: (context) => VerifyBookingBloc(
                VerifyBookingInitState(), ManagerRepository())),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => LoginUi(),
          '/manager': (context) => ManagerMain(),
          '/staff': (context) => StaffHome(),
          '/customer': (context) => CustomerHome(),
        },
      ),
    );
  }
}
