import 'dart:io';

// import 'package:car_service/blocs/customer_car/customerCar_state.dart';
import 'package:car_service/blocs/customer/customerCar/CreateCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CreateBooking_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerService/CustomerService_bloc.dart';
import 'package:car_service/blocs/login/auth_bloc.dart';
import 'package:car_service/blocs/login/auth_state.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/booking/booking_bloc.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_cubit.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/sign_up/sign_up_bloc.dart';
import 'package:car_service/blocs/sign_up/sign_up_state.dart';
import 'package:car_service/ui/Customer/CustomerMainUI.dart';
import 'package:car_service/ui/LoginUi.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/Staff/StaffHome.dart';
import 'package:car_service/utils/repository/auth_repo.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'ui/Manager/ManagerMain.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(Auth());
}

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc(LoginInitState(), AuthRepository())),
        BlocProvider(create: (context) => SignUpBloc(repo: AuthRepository())),
        BlocProvider(
            create: (context) => VerifyBookingBloc(repo: ManagerRepository())),
        // BlocProvider(create: (context) => CarCustomerCubit()),
        BlocProvider(
            create: (context) => AssignOrderBloc(repo: ManagerRepository())),
        BlocProvider(
            create: (context) => CustomerCarBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => CustomerOrderBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => CreateCarBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => CreateBookingBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) =>
                CustomerServiceBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => CreateOrderBloc(repo: ManagerRepository())),
        BlocProvider(
            create: (context) => ProcessOrderBloc(repo: ManagerRepository())),
        BlocProvider(
            create: (context) =>
                StaffBloc(StaffInitState(), ManagerRepository())),
        // BlocProvider(
        //     create: (context) =>
        //         BookingCubit(VerifyBookingInitState(), ManagerRepository())),
        BlocProvider(
            create: (context) =>
                StaffCubit(StaffInitState(), ManagerRepository())),
      ],
      child: GetMaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => ManagerMain(),
          '/manager': (context) => ManagerMain(),
          '/staff': (context) => StaffHome(),
          '/customer': (context) => CustomerHome(),
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
