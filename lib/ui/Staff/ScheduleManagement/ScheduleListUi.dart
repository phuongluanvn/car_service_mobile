import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_bloc.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_events.dart';
import 'package:car_service/blocs/manager/tableCalendar/tableCalendar_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Staff/ScheduleManagement/AbsencesWorkUI.dart';
import 'package:car_service/ui/Staff/ScheduleManagement/ScheduleDetailUi.dart';
import 'package:car_service/ui/Staff/ScheduleManagement/event.dart';
import 'package:car_service/utils/model/AbsencesModel.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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
  String username;
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
    // context.read<OrderHistoryBloc>().add(DoListOrderHistoryEvent());
  }

  _getStringFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    // username = prefs.getString('Username');
    // setState(() {
    //   _username = username;
    // });
    BlocProvider.of<TableCalendarBloc>(context)
        .add(DoListTableCalendarEvent(username: prefs.getString('Username')));
    // BlocProvider.of<TableCalendarBloc>(context)
    //     .add(DoListAbsencesEvent(username: prefs.getString('Username')));
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
                    if (state.processList != null &&
                        state.processList.isNotEmpty) {
                      print(state.absList.length);
                      return Column(
                        children:
                            List.generate(state.processList.length, (index) {
                          DateTime bookingTime =
                              DateFormat('yyyy-MM-ddTHH:mm:ss').parse(state
                                  .processList[index].order[index].bookingTime);

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
                                title: Text(state.processList[index]
                                    .order[index].vehicle.licensePlate),
                                subtitle: Text(
                                  _convertDate(state.processList[index]
                                      .order[index].bookingTime),
                                ),
                                onTap: () {
                                  print(
                                      state.processList[index].order[index].id);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ScheduleDetailUi(
                                          orderId: state.processList[index]
                                              .order[index].id)));
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
