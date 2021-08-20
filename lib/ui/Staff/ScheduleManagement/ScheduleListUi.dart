import 'package:car_service/blocs/manager/booking/booking_cubit.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_bloc.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_events.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_state.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_bloc.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_events.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderDetailUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/OrderHistory/OrderHistoryDetailUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingManagement/VerifyBookingDetailUi.dart';
import 'package:car_service/ui/Staff/ScheduleManagement/event.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class ScheduleListUi extends StatefulWidget {
  @override
  _ScheduleListUiState createState() => _ScheduleListUiState();
}

class _ScheduleListUiState extends State<ScheduleListUi> {
  CalendarFormat formatT = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  Map<DateTime, List<Event>> selectedEvents;
  TextEditingController _eventController = TextEditingController();
  List _selectedEvents;
  int _counter = 0;
  Map<DateTime, List> _events;
  // CalendarController _calendarController;

  AnimationController _animationController;

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }

  _getDay(dateInput) {
    return formatDate(DateTime.parse(dateInput), [dd]);
  }

  _getMonth(dateInput) {
    return formatDate(DateTime.parse(dateInput), [mm]);
  }

  _getYear(dateInput) {
    return formatDate(DateTime.parse(dateInput), [yyyy]);
  }

  // Future<Map<DateTime, List>> getTask1() async {
  //   Map<DateTime, List> mapFetch = {};
  //   List<OrderDetailModel> list =
  //       await ManagerRepository().getBookingOrderList();
  //   for (int i = 0; i < list.length; i++) {
  //     var createTime = DateTime(
  //       _getYear(list[i].bookingTime),
  //       _getMonth(list[i].bookingTime),
  //       _getDay(list[i].bookingTime),
  //     );
  //     var original = mapFetch[createTime];
  //     if (original == null) {
  //       print("null");
  //       mapFetch[createTime] = [DateTime.parse(list[i].bookingTime)];
  //     } else {
  //       print(DateTime.parse(list[i].bookingTime));
  //       mapFetch[createTime] = List.from(original)
  //         ..addAll([DateTime.parse(list[i].bookingTime)]);
  //     }
  //   }

  //   return mapFetch;
  // }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  void initState() {
    final DateTime selectedDay = DateTime.now();
    super.initState();
    selectedEvents = {};
    setState(() {
      BlocProvider.of<TableCalendarBloc>(context)
          .add(DoListTableCalendarEvent());
    });

    // context.read<OrderHistoryBloc>().add(DoListOrderHistoryEvent());
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        automaticallyImplyLeading: false,
        title: Text('Quản lý công việc'),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: focusedDay,
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              calendarFormat: formatT,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  formatT = _format;
                });
              },
              eventLoader: _getEventsfromDay,
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: AppTheme.colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: AppTheme.colors.white),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekVisible: true,
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronVisible: false,
                rightChevronVisible: false,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            BlocBuilder<TableCalendarBloc, TableCalendarState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state.status == TableCalendarStatus.init) {
                  return CircularProgressIndicator();
                } else if (state.status == TableCalendarStatus.loading) {
                  return CircularProgressIndicator();
                } else if (state.status ==
                    TableCalendarStatus.tableCalendarSuccess) {
                  if (state.tableCalendarList != null &&
                      state.tableCalendarList.isNotEmpty) {
                    return Column(
                      children: List.generate(state.tableCalendarList.length,
                          (index) {
                        DateTime checkinTime = DateFormat('yyyy-MM-ddTHH:mm:ss')
                            .parse(state.tableCalendarList[index].checkinTime);

                        if (isSameDay(selectedDay, checkinTime)) {
                          return Card(
                              // child: (state.assignList[0].status == 'Checkin')
                              //     ?
                              child: Column(children: [
                            ListTile(
                              trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.circle,
                                      color: Colors.yellow,
                                    ),
                                    Text(state.tableCalendarList[index].status),
                                  ]),
                              leading:
                                  Image.asset('lib/images/order_small.png'),
                              title: Text(state.tableCalendarList[index].vehicle
                                  .licensePlate),
                              subtitle: Text(
                                _convertDate(
                                    state.tableCalendarList[index].checkinTime),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => AssignOrderDetailUi(
                                        orderId: state
                                            .tableCalendarList[index].id)));
                              },
                            ),
                          ])
                              // : SizedBox(),
                              );
                        } else
                          return SizedBox();
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
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text("Add Event"),
      //       content: TextFormField(
      //         controller: _eventController,
      //       ),
      //       actions: [
      //         TextButton(
      //           child: Text("Cancel"),
      //           onPressed: () => Navigator.pop(context),
      //         ),
      //         TextButton(
      //           child: Text("Ok"),
      //           onPressed: () {
      //             if (_eventController.text.isEmpty) {
      //             } else {
      //               if (selectedEvents[selectedDay] != null) {
      //                 selectedEvents[selectedDay].add(
      //                   Event(title: _eventController.text),
      //                 );
      //               } else {
      //                 selectedEvents[selectedDay] = [
      //                   Event(title: _eventController.text)
      //                 ];
      //               }
      //             }
      //             Navigator.pop(context);
      //             _eventController.clear();
      //             setState(() {});
      //             return;
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      //   label: Text("Add Event"),
      //   icon: Icon(Icons.add),
      // ),

      // Center(
      //   child:

      //  BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
      //   // ignore: missing_return
      //   builder: (context, state) {
      //     if (state.status == OrderHistoryStatus.init) {
      //       return CircularProgressIndicator();
      //     } else if (state.status == OrderHistoryStatus.loading) {
      //       return CircularProgressIndicator();
      //     } else if (state.status == OrderHistoryStatus.historySuccess) {
      //       if (state.historyList != null && state.historyList.isNotEmpty)
      //         return ListView.builder(
      //           itemCount: state.historyList.length,
      //           shrinkWrap: true,
      //           itemBuilder: (context, index) {
      //             return Card(
      //                 child: Column(children: [
      //               ListTile(
      //                 trailing: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: <Widget>[
      //                       Icon(
      //                         Icons.circle,
      //                         color: Colors.red,
      //                       ),
      //                       Text(state.historyList[index].status),
      //                     ]),
      //                 leading: Image.asset('lib/images/order_small.png'),
      //                 title:
      //                     Text(state.historyList[index].vehicle.licensePlate),
      //                 subtitle: Text(
      //                   _convertDate(state.historyList[index].createdTime),
      //                 ),
      //                 onTap: () {
      //                   Navigator.of(context).push(MaterialPageRoute(
      //                       builder: (_) => OrderHistoryDetailUi(
      //                           orderId: state.historyList[index].id)));
      //                 },
      //               ),
      //             ])

      //                 );

      //           },
      //         );
      //       else
      //         return Center(
      //           child: Text('Hiện tại không có đơn'),
      //         );
      //     } else if (state.status == OrderHistoryStatus.error) {
      //       return ErrorWidget(state.message.toString());
      //     }
      //   },
      // ),

      // );
    );
  }

  // _convertDate(dateInput) {
  //   return formatDate(DateTime.parse(dateInput),
  //       [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  // }
}
