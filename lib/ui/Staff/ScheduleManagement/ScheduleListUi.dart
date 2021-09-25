import 'dart:convert';

import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_bloc.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_events.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Staff/ScheduleManagement/AbsencesWorkUI.dart';
import 'package:car_service/ui/Staff/ScheduleManagement/ScheduleDetailUi.dart';
import 'package:car_service/ui/Staff/ScheduleManagement/event.dart';
import 'package:car_service/utils/model/AbsencesModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
// import 'package:car_service/utils/model/StaffModel.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;

class ScheduleListUi extends StatefulWidget {
  @override
  _ScheduleListUiState createState() => _ScheduleListUiState();
}

class _ScheduleListUiState extends State<ScheduleListUi> {
  CalendarFormat formatT = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  Map<DateTime, List<Absences>> selectedEvents;
  TextEditingController _eventController = TextEditingController();
  List _selectedEvents;
  int _counter = 0;
  Map<DateTime, List> _events;
  String _username = '';
  String username = '';
  DateTime absenceTime;
  // final DateTime selectedDay = DateTime.now();
  // CalendarController _calendarController;

  AnimationController _animationController;

  List<Absences> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  void initState() {
    super.initState();
    _getStringFromSharedPref();
    selectedEvents = {};
  }

  _getStringFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    BlocProvider.of<TableCalendarBloc>(context)
        .add(DoListTableCalendarEvent(username: prefs.getString('Username')));
    setState(() {
      _username = prefs.getString('Username');
    });
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi_VN', null);
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
                locale: 'vi_VN',
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
                calendarBuilders: CalendarBuilders(
                  disabledBuilder: (context, day, focusedDay) {},
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
                      // print(state.absList[0].noteAdmin);
                      return Column(
                        children: List.generate(state.tableCalendarList.length,
                            (index) {
                          DateTime bookingTime =
                              DateFormat('yyyy-MM-ddTHH:mm:ss').parse(state
                                  .tableCalendarList[index].order.bookingTime);
                          absenceTime = DateFormat('yyyy-MM-ddTHH:mm:ss')
                              .parse(state.absList[index].timeStart);
                          print(isSameDay(absenceTime, selectedDay));
                          if (isSameDay(selectedDay, bookingTime)) {
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
                                      // Text(state.processList[index].order.status),
                                    ]),
                                leading:
                                    Image.asset('lib/images/order_small.png'),
                                title: Text(state.tableCalendarList[index].order
                                    .vehicle.licensePlate),
                                subtitle: Text(
                                  _convertDate(state.tableCalendarList[index]
                                      .order.bookingTime),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ScheduleDetailUi(
                                          orderId: state
                                              .tableCalendarList[index]
                                              .order
                                              .id)));
                                },
                              ),
                            ])
                                // : SizedBox(),
                                );
                          } else if (isSameDay(absenceTime, selectedDay)) {
                            String mess;
                            if (isSameDay(absenceTime, selectedDay) &&
                                state.absList[index].isApproved == true) {
                              mess = 'Ngày nghỉ!';
                            } else {
                              mess = 'Hiện tại không có công việc!';
                            }
                            return Center(
                              child: Text(mess),
                            );
                          } else {
                            return Text('Hiện tại không có công việc!');
                          }
                        }),
                      );
                    } else {
                      return Center(
                        child: Text('Hiện tại không có công việc!'),
                      );
                    }
                  } else if (state.status == TableCalendarStatus.error) {
                    return ErrorWidget(state.message.toString());
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: ElevatedButton(
          child: Text('Xin nghỉ'),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => AbsencesWorkUI()));
          },
        )
        // : ElevatedButton(
        //     style: ElevatedButton.styleFrom(primary: Colors.grey),
        //     child: Text('Xin nghỉ'),
        //     onPressed: () {},
        //   ),
        );
  }

  // _convertDate(dateInput) {
  //   return formatDate(DateTime.parse(dateInput),
  //       [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  // }
}
