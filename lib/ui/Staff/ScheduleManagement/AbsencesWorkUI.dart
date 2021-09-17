import 'package:car_service/blocs/staff/absencesWork/AbsencesWork_bloc.dart';
import 'package:car_service/blocs/staff/absencesWork/AbsencesWork_event.dart';
import 'package:car_service/blocs/staff/absencesWork/AbsencesWork_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Staff/ScheduleManagement/event.dart';
import 'package:car_service/utils/model/AbsencesModel.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AbsencesWorkUI extends StatefulWidget {
  @override
  _AbsencesWorkUIState createState() => _AbsencesWorkUIState();
}

class _AbsencesWorkUIState extends State<AbsencesWorkUI> {
  CalendarFormat formatT = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime _toDay = DateTime.now();
  Map<DateTime, List<Event>> selectedEvents;
  TextEditingController _eventController = TextEditingController();
  String _statusChanged;
  AbsencesWorkBloc _absencesWorkBloc;
  String _username;
  String timeStart = 'T08:00:00';
  String timeEnd = 'T17:00:00';
  List<DateTime> _selectedDayList = [];
  DateTime date;
  int _valueSelected = 0;
  DateTimeRange dateRange;
  List<Absences> _listAbsences = [];
  Absences _absences = Absences();
String _empNote;
  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }

  _startDate(String date) {
    print(timeEnd);
    return date + timeStart;
  }

  _endDate(String date) {
    return date + timeEnd;
  }

  _getStringFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('Username');

    setState(() {
      _username = username;
    });
  }

  @override
  void initState() {
    _dateTimeFormat();
    _getStringFromSharedPref();
    super.initState();
    _absencesWorkBloc = BlocProvider.of<AbsencesWorkBloc>(context);
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
        title: Text('Đăng ký nghỉ'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // context.read<CustomerCarBloc>().add(DoCarListEvent());
          },
        ),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        // child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Container(
            decoration: BoxDecoration(
                // color: Colors.white,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: BlocListener<AbsencesWorkBloc, AbsencesWorkState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state.status == AbsencesWorkStatus.absencesWorkSuccess) {
                  _showSelectedAbsencesWorkDialog();
                  // Navigator.of(context).pop();
                }
              },
              child: Column(
                children: [
                  Text(
                    'Chọn ngày nghỉ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        RadioListTile(
                            title: Text('Một ngày'),
                            value: 1,
                            groupValue: _valueSelected,
                            onChanged: (value) {
                              setState(() {
                                _valueSelected = value;
                              });
                            }),
                        _valueSelected == 1
                            ? ElevatedButton(
                                onPressed: () {
                                  pickDate(context);
                                },
                                child: Text(getText()))
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey),
                                // onPressed: () {
                                //   // pickDate(context);
                                // },
                                child: Text(getText(),
                                    style: TextStyle(color: Colors.white))),
                        RadioListTile(
                            title: Text('Dài ngày'),
                            value: 2,
                            groupValue: _valueSelected,
                            onChanged: (value) {
                              setState(() {
                                _valueSelected = value;
                              });
                            }),
                        Row(
                          children: [
                            Expanded(
                              child: _valueSelected == 2
                                  ? ElevatedButton(
                                      onPressed: () {
                                        pickDateRange(context);
                                      },
                                      child: Text(getFrom()))
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.grey),
                                      // onPressed: () {
                                      //   // pickDate(context);
                                      // },
                                      child: Text(getFrom(),
                                          style:
                                              TextStyle(color: Colors.white))),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _valueSelected == 2
                                  ? ElevatedButton(
                                      onPressed: () {
                                        pickDateRange(context);
                                      },
                                      child: Text(getUntil()))
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.grey),
                                      // onPressed: () {
                                      //   // pickDate(context);
                                      // },
                                      child: Text(getUntil(),
                                          style:
                                              TextStyle(color: Colors.white))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      onChanged: (noteValue) {
                        setState(() {
                          _empNote = noteValue;
                        });
                      },
                      maxLines: 3,
                      decoration:
                          InputDecoration.collapsed(hintText: 'Lý do xin nghỉ'),
                    ),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: AppTheme.colors.blue),
                    child: Text('Xác nhận'),
                    onPressed: () {
                      _listAbsences = [];
                      _selectedDayList
                          .map((e) => {
                                _absences.empUsername = _username,
                                _absences.noteEmp = _empNote,
                                _absences.timeStart = _startDate(
                                    e.toIso8601String().split("T")[0]),
                                _absences.timeEnd =
                                    _endDate(e.toIso8601String().split("T")[0]),
                                _listAbsences.add(_absences),
                              })
                          .toList();
                      _absencesWorkBloc.add(AbsencesWorkButtonPressed(
                        username: _username,
                        absences: _listAbsences,
                      ));
                      // print(test);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        // ),
      ),
    );
  }

  _dateTimeFormat() {
    Intl.defaultLocale = 'es';
    print(DateFormat('hh:mm a').format(
        DateTime.parse(_endDate(selectedDay.toIso8601String().split("T")[0]))));
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => {
          date = newDate,
          if (_selectedDayList.isNotEmpty) //neu co ngay thi chuyen thanh rong
            {
              _selectedDayList = [],
              _selectedDayList.add(date),
            }
          else
            {_selectedDayList.add(date)},
          print(_selectedDayList)
        });
  }

  String getText() {
    if (date == null) {
      return 'Chọn ngày';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  _showSelectedAbsencesWorkDialog() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              'Thông báo!',
              style: TextStyle(color: Colors.greenAccent),
            ),
            content: Text('Đăng ký thành công. Xin đợi duyệt!'),
            actions: [
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.pop(context);
                    Navigator.of(context).pop();
                  },
                  child: Text('Đồng ý'))
            ],
          );
        });
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() => {
          dateRange = newDateRange,
          if (_selectedDayList.isNotEmpty) //neu ngay co thi xoa ngay di
            {
              _selectedDayList = [],
              for (int i = 0;
                  i <= newDateRange.end.difference(newDateRange.start).inDays;
                  i++)
                {
                  _selectedDayList
                      .add(newDateRange.start.add(Duration(days: i)))
                },
              print(dateRange),
            }
          else
            {
              for (int i = 0;
                  i <= newDateRange.end.difference(newDateRange.start).inDays;
                  i++)
                {
                  _selectedDayList
                      .add(newDateRange.start.add(Duration(days: i)))
                },
              print(dateRange),
            },
          print(_selectedDayList)
        });
  }

  String getFrom() {
    if (dateRange == null) {
      return 'From';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Until';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange.end);
    }
  }
}
