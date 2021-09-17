import 'dart:developer';

import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_bloc.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_events.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Staff/ScheduleManagement/AbsencesWorkUI.dart';
import 'package:car_service/ui/Staff/ScheduleManagement/ScheduleDetailUi.dart';
import 'package:car_service/ui/Staff/ScheduleManagement/event.dart';
import 'package:car_service/utils/model/CalendarModel.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalendarUI extends StatefulWidget {
  @override
  _CalendarUIState createState() => _CalendarUIState();
}

class _CalendarUIState extends State<CalendarUI> {
  CalendarFormat formatT = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime _toDay = DateTime.now();
  Map<DateTime, List<Event>> selectedEvents;
  TextEditingController _eventController = TextEditingController();
  bool _isShowAbsButton = false;
  List _selectedEvents;
  int _counter = 0;
  Map<DateTime, List> _events;
  String username;
  String _statusChanged;
  Map<DateTime, List<CalendarModel>> _loadedEvent;
  List<CalendarModel> _listCalendars;
  // final DateTime selectedDay = DateTime.now();
  // CalendarController _calendarController;

  AnimationController _animationController;

  List<CalendarModel> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  _getEventInDate(List<CalendarModel> calendars) {
    _loadedEvent = {};
    calendars.forEach((element) {
      DateTime date = DateTime.utc(
          _getDay(element.order.checkinTime),
          _getMonth(element.order.checkinTime),
          _getYear(element.order.checkinTime),
          12);
      if (_loadedEvent[date] == null) {
        _loadedEvent[date] = [];
      } else {
        _loadedEvent[date].add(element);
      }
    });
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }

  _convertDateNoTime(dateInput) {
    return formatDate(DateTime.parse(dateInput), [dd, '/', mm, '/', yyyy]);
  }

  _changeStatus(String status) {
    if (status != 'Hoàn thành') {
      _statusChanged = 'Đang xử lý';
    } else {
      _statusChanged = 'Đã hoàn thành';
    }
    return _statusChanged;
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
        .add(DoListTaskEvent(username: prefs.getString('Username')));
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
        title: Text('Quản lý lịch làm'),
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
              // eventLoader: _getEventInDate(_listCalendars),
              calendarStyle: CalendarStyle(
                canMarkersOverflow: true,
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
                if (selectedDay.day - _toDay.day > 0) {
                  _isShowAbsButton = true;
                } else {
                  _isShowAbsButton = false;
                }
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                // leftChevronVisible: false,
                // rightChevronVisible: false,
              ),
            ),
            Divider(),
            Text(
                'Công việc ngày ' + _convertDateNoTime(selectedDay.toString())),
            Padding(
              padding: EdgeInsets.all(24),
              child: BlocBuilder<TableCalendarBloc, TableCalendarState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state.status == TableCalendarStatus.init) {
                    return CircularProgressIndicator();
                  } else if (state.status == TableCalendarStatus.loading) {
                    return CircularProgressIndicator();
                  } else if (state.status ==
                      TableCalendarStatus.tableCalendarSuccess) {
                    if (state.taskLists != null && state.taskLists.isNotEmpty) {
                      setState(() {
                        _listCalendars = state.taskLists;
                      });
                      return Column(
                        children:
                            List.generate(state.taskLists.length, (index) {
                          DateTime bookingTime =
                              DateFormat('yyyy-MM-ddTHH:mm:ss').parse(
                                  state.taskLists[index].order.bookingTime);

                          // if (isSameDay(selectedDay, bookingTime)) {
                          return Card(
                              child: Column(children: [
                            ListTile(
                              trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.circle,
                                      color: Colors.yellow,
                                    ),
                                    Text(_changeStatus(
                                        state.taskLists[index].order.status)),
                                  ]),
                              leading:
                                  Image.asset('lib/images/order_small.png'),
                              title: Text(state
                                  .taskLists[index].order.vehicle.licensePlate),
                              subtitle: Text(
                                _convertDate(
                                    state.taskLists[index].order.bookingTime),
                              ),
                              onTap: () {
                                print(state.taskLists[index].order.id);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ScheduleDetailUi(
                                        orderId:
                                            state.taskLists[index].order.id)));
                              },
                            ),
                          ])
                              // : SizedBox(),
                              );
                          // } else
                          //   return Center(
                          //     child: Text('Chưa có công việc cho hôm nay!'),
                          //   );
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
          ],
        ),
      ),
      floatingActionButton: _isShowAbsButton
          ? ElevatedButton(
              child: Text('Xin nghỉ'),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AbsencesWorkUI()));
              },
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.grey),
              child: Text('Xin nghỉ'),
              onPressed: () {},
            ),
    );
  }
}
