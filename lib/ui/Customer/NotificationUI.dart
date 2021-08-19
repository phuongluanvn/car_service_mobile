import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CarManagement/CustomerCarDetailUI.dart';
import 'package:car_service/ui/Customer/message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
        title: Text('Thông báo'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: Text('Chưa có thông báo mới'),
        // child: BlocBuilder<VerifyBookingBloc, VerifyBookingState>(
        //   // ignore: missing_return
        //   builder: (context, state) {
        //     if (state.status == BookingStatus.init) {
        //       return CircularProgressIndicator();
        //     } else if (state.status == BookingStatus.loading) {
        //       return CircularProgressIndicator();
        //     } else if (state.status == BookingStatus.bookingSuccess) {
        //       if (state.bookingList != null && state.bookingList.isNotEmpty)
        //         return ListView.builder(
        //           itemCount: state.bookingList.length,
        //           shrinkWrap: true,
        //           itemBuilder: (context, index) {
        //             return Card(
        //               child: (state.bookingList[index].status == 'Booked')
        //                   ? Column(children: [
        //                       ListTile(
        //                         trailing: Column(
        //                             mainAxisSize: MainAxisSize.min,
        //                             children: <Widget>[
        //                               Icon(
        //                                 Icons.circle,
        //                                 color: Colors.red,
        //                               ),
        //                               Text('Booked'),
        //                             ]),
        //                         leading: FlutterLogo(),
        //                         title: Text(state
        //                             .bookingList[index].vehicle.licensePlate),
        //                         subtitle:
        //                             Text(state.bookingList[index].bookingTime),
        //                         onTap: () {
        //                           Navigator.of(context).push(MaterialPageRoute(
        //                               builder: (_) => VerifyBookingDetailUi(
        //                                   orderId:
        //                                       state.bookingList[index].id)));
        //                         },
        //                       ),
        //                     ])
        //                   : SizedBox(),
        //               // : Column(children: [
        //               //     ListTile(
        //               //       trailing: Column(
        //               //           mainAxisSize: MainAxisSize.min,
        //               //           children: <Widget>[
        //               //             Icon(
        //               //               Icons.circle,
        //               //               color: Colors.green,
        //               //             ),
        //               //             Text('Đợi xác nhận'),
        //               //           ]),
        //               //       leading: FlutterLogo(),
        //               //       title: Text(
        //               //           state.orderLists[index].taiKhoan),
        //               //       subtitle:
        //               //           Text(state.orderLists[index].hoTen),
        //               //       onTap: () {
        //               //         Navigator.of(context).push(
        //               //             MaterialPageRoute(
        //               //                 builder: (_) =>
        //               //                     CustomerCarDetailUi(
        //               //                         emailId: state
        //               //                             .orderLists[index]
        //               //                             .taiKhoan)));
        //               //       },
        //               //     ),
        //               //   ]),
        //             );
        //             // ListTile(
        //             //   title: Text(state.bookingList[index].customer.fullname),
        //             //   onTap: () {
        //             //     Navigator.of(context).push(MaterialPageRoute(
        //             //         builder: (_) => VerifyBookingDetailUi(
        //             //             emailId: state.bookingList[index].id)));
        //             //   },
        //             // );
        //           },
        //         );
        //       else
        //         return Center(
        //           child: Text('Hiện tại không có đơn'),
        //         );
        //     } else if (state.status == BookingStatus.error) {
        //       return ErrorWidget(state.message.toString());
        //     }
        //   },
        // ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _showNotification,
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
