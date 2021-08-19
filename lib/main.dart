import 'dart:io';

// import 'package:car_service/blocs/customer_car/customerCar_state.dart';
import 'package:car_service/blocs/assignOrderReview/assignOrderReview_bloc.dart';
import 'package:car_service/blocs/coupon/Coupon_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CreateCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/DelCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/UpdateCar_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CreateBooking_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerEditProfile_bloc.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerProfile_bloc.dart';
import 'package:car_service/blocs/customer/customerService/CustomerService_bloc.dart';
import 'package:car_service/blocs/customer/manufacturers/Manufacturer_bloc.dart';
import 'package:car_service/blocs/login/auth_bloc.dart';
import 'package:car_service/blocs/login/auth_state.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/booking/booking_bloc.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_bloc.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/updateFinishTask_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/manager/updateItem/updateItem_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/packageService/PackageService_bloc.dart';
import 'package:car_service/blocs/sign_up/sign_up_bloc.dart';
import 'package:car_service/blocs/sign_up/sign_up_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CustomerMainUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderUI.dart';
import 'package:car_service/ui/LoginUi.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/ReviewTaskUi.dart';
import 'package:car_service/ui/Staff/StaffHome.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/repository/auth_repo.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'ui/Manager/ManagerMain.dart';

AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up : ${message.messageId}');
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(Auth());
}

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(repo: AuthRepository())),
        BlocProvider(create: (context) => SignUpBloc(repo: AuthRepository())),
        BlocProvider(
            create: (context) => VerifyBookingBloc(repo: ManagerRepository())),
        // BlocProvider(create: (context) => CarCustomerCubit()),
        BlocProvider(
            create: (context) => AssignOrderBloc(repo: ManagerRepository())),
        BlocProvider(
            create: (context) => AssignReviewBloc(repo: ManagerRepository())),
        BlocProvider(
            create: (context) => CustomerCarBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => CustomerOrderBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => CreateCarBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => CreateBookingBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => ManufacturerBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => DeleteCarBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => UpdateCarBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => ProfileBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => CouponBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) =>
                CustomerServiceBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => CreateOrderBloc(repo: ManagerRepository())),
        BlocProvider(
            create: (context) => ProcessOrderBloc(repo: ManagerRepository())),
        BlocProvider(
            create: (context) =>
                UpdateFinishTaskBloc(repo: ManagerRepository())),
        BlocProvider(
            create: (context) => OrderHistoryBloc(repo: ManagerRepository())),
        BlocProvider(
            create: (context) =>
                UpdateStatusOrderBloc(repo: ManagerRepository())),
        BlocProvider(
            create: (context) => EditProfileBloc(repo: CustomerRepository())),
        BlocProvider(
            create: (context) => ManageStaffBloc(repo: ManagerRepository())),
        BlocProvider(
            create: (context) =>
                PackageServiceBloc(repo: CustomerRepository())),
        BlocProvider(create: (context) => CrewBloc(repo: ManagerRepository())),
        BlocProvider(
            create: (context) => AccessoryBloc(repo: ManagerRepository())),
        BlocProvider(
            create: (context) => UpdateItemBloc(repo: ManagerRepository())),
        // BlocProvider(
        //     create: (context) =>
        //         BookingCubit(VerifyBookingInitState(), ManagerRepository())),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginUi(),
          '/manager': (context) => ManagerMain(),
          '/staff': (context) => StaffHomeUi(),
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
