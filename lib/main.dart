import 'package:car_service/blocs/customer_car/customerCar_bloc.dart';
import 'package:car_service/blocs/customer_car/customerCar_state.dart';
import 'package:car_service/blocs/login/auth_bloc.dart';
import 'package:car_service/blocs/login/auth_state.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/booking/booking_bloc.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/sign_up/sign_up_bloc.dart';
import 'package:car_service/blocs/sign_up/sign_up_state.dart';
import 'package:car_service/repository/auth_repo.dart';
import 'package:car_service/repository/customer_repo.dart';
import 'package:car_service/repository/manager_repo.dart';
import 'package:car_service/ui/Customer/CustomerHome.dart';
import 'package:car_service/ui/LoginUi.dart';
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
        BlocProvider(
            create: (context) =>
                CustomerCarBloc(InitCustomerCarState(), CustomerRepository())),
        BlocProvider(
            create: (context) =>
                AssignOrderBloc(AssignOrderInitState(), ManagerRepository())),
        BlocProvider(
            create: (context) =>
                StaffBloc(StaffInitState(), ManagerRepository()))
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
