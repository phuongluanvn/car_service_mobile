import 'package:car_service/blocs/manager/booking/booking_cubit.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_bloc.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_events.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_state.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_bloc.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_events.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/OrderManagement/OrderHistory/OrderHistoryDetailUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingManagement/VerifyBookingDetailUi.dart';
import 'package:car_service/ui/Staff/ScheduleManagement/ScheduleDetailUi.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffOrderHistoryUi extends StatefulWidget {
  @override
  _StaffOrderHistoryUiState createState() => _StaffOrderHistoryUiState();
}

class _StaffOrderHistoryUiState extends State<StaffOrderHistoryUi> {
  List dataModel = [];
  @override
  void initState() {
    super.initState();
    _getStringFromSharedPref();
  }

  _getStringFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    // username = prefs.getString('Username');
    // setState(() {
    //   _username = username;
    // });
    BlocProvider.of<TableCalendarBloc>(context)
        .add(DoListTableCalendarEvent(username: prefs.getString('Username')));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getData() async {
    setState(() {
      BlocProvider.of<TableCalendarBloc>(context).add(DoListTableCalendarEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Lịch sử đơn hàng'),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: RefreshIndicator(
        onRefresh: _getData,
        child: BlocBuilder<TableCalendarBloc, TableCalendarState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == TableCalendarStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == TableCalendarStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status ==
                TableCalendarStatus.tableCalendarSuccess) {
              if (state.finishList != null && state.finishList.isNotEmpty) {
                return Column(
                  children: List.generate(state.finishList.length, (index) {
                    return Card(
                        // child: (state.assignList[0].status == 'Checkin')
                        //     ?
                        child: Column(children: [
                      // ListTile(
                      //   trailing: Column(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: <Widget>[
                      //         Icon(
                      //           Icons.circle,
                      //           color: Colors.yellow,
                      //         ),
                      //         Text(state.finishList[index].order.status),
                      //       ]),
                      //   leading: Image.asset('lib/images/order_small.png'),
                      //   title: Text(
                      //       state.finishList[index].order.vehicle.licensePlate),
                      //   subtitle: Text(
                      //     _convertDate(
                      //         state.finishList[index].order.bookingTime),
                      //   ),
                      //   onTap: () {
                      //     print(state.finishList[index].order.id);
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (_) => ScheduleDetailUi(
                      //             orderId: state.finishList[index].order.id)));
                      //   },
                      // ),
                    ])
                        // : SizedBox(),
                        );
                  }),
                );
              } else
                return Center(
                  child: Text('Hiện tại không có đơn'),
                );
            } else if (state.status == TableCalendarStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }
}
