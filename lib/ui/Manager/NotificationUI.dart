import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerProfile_bloc.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerProfile_event.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerProfile_state.dart';
import 'package:car_service/blocs/manager/employeeProfile/EmployeeProfile_bloc.dart';
import 'package:car_service/blocs/manager/employeeProfile/EmployeeProfile_event.dart';
import 'package:car_service/blocs/manager/employeeProfile/EmployeeProfile_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CarManagement/CustomerCarDetailUI.dart';
import 'package:car_service/ui/Customer/message.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

int _counter = 0;
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
  // runApp(Auth());
}

class NotificationUI extends StatefulWidget {
  @override
  _NotificationUIState createState() => _NotificationUIState();
}

class _NotificationUIState extends State<NotificationUI> {
  @override
  void initState() {
    _getStringFromSharedPref();
    BlocProvider.of<EmployeeProfileBloc>(context);
    main();
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

  _getStringFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();

    BlocProvider.of<EmployeeProfileBloc>(context)
        .add(GetEmpProfileByUsername(username: prefs.getString('Username')));
  }

  void _showNotification() {
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
                color: AppTheme.colors.deepBlue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
          importance: Importance.high,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        )));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Th??ng b??o'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: BlocBuilder<EmployeeProfileBloc, EmployeeProfileState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == EmpProfileStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == EmpProfileStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == EmpProfileStatus.getProflieSuccess) {
              if (state.empProfile[0].notifications != [] && state.empProfile.isNotEmpty) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: ListView.builder(
                      itemCount: state.empProfile[0].notifications.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        //hi???n th??? list xe
                        return Card(
                          child: Column(children: [
                            ListTile(
                              leading: Column(
                                children: [
                                  Image.asset(
                                    'lib/images/logo_blue.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  Text(_convertDate(state.empProfile.first
                                      .notifications[index].createdAt))
                                ],
                              ),
                              title: Text(state
                                  .empProfile.first.notifications[index].title),
                              subtitle: Text(state.empProfile.first
                                  .notifications[index].message),
                            ),
                          ]),
                        );
                      },
                    ),
                  ),
                );
              } else
                return Center(
                  child: Text('Kh??ng c?? th??ng b??o'),
                );
            } else if (state.status == EmpProfileStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput), [dd, '/', mm, '/', yyyy]);
  }
}
