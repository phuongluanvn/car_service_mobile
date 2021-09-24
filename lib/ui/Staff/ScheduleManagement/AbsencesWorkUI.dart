// import 'package:car_service/blocs/staff/absencesWork/AbsencesWork_bloc.dart';
// import 'package:car_service/blocs/staff/absencesWork/AbsencesWork_event.dart';
// import 'package:car_service/blocs/staff/absencesWork/AbsencesWork_state.dart';
// import 'package:car_service/theme/app_theme.dart';
// import 'package:car_service/ui/Staff/ScheduleManagement/event.dart';
// import 'package:car_service/utils/model/AbsencesModel.dart';
// import 'package:date_format/date_format.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';
// import 'package:car_service/utils/helpers/constants/StaffConstants.dart'
//     as staffConstants;

// class AbsencesWorkUI extends StatefulWidget {
//   @override
//   _AbsencesWorkUIState createState() => _AbsencesWorkUIState();
// }

// class _AbsencesWorkUIState extends State<AbsencesWorkUI> {
//   CalendarFormat formatT = CalendarFormat.month;
//   DateTime selectedDay = DateTime.now();
//   DateTime focusedDay = DateTime.now();
//   DateTime _toDay = DateTime.now();
//   Map<DateTime, List<Event>> selectedEvents;
//   TextEditingController _eventController = TextEditingController();
//   String _statusChanged;
//   AbsencesWorkBloc _absencesWorkBloc;
//   String _username;
//   List<DateTime> _selectedDayList = [];
//   DateTime date;
//   int _valueSelected = 0;
//   DateTimeRange dateRange;
//   List<Absences> _listAbsences = [];
//   Absences _absences = Absences();
//   String _empNote;
//   bool _isShowOneDay = false;
//   bool _isShowRangeDay = false;

//   _convertDate(dateInput) {
//     return formatDate(DateTime.parse(dateInput),
//         [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
//   }

//   _startDate(String date) {
//     return date + staffConstants.TIME_STATR;
//   }

//   _endDate(String date) {
//     return date + staffConstants.TIME_END;
//   }

//   _getStringFromSharedPref() async {
//     final prefs = await SharedPreferences.getInstance();
//     final username = prefs.getString('Username');

//     setState(() {
//       _username = username;
//     });
//   }

//   @override
//   void initState() {
//     // _dateTimeFormat();
//     _getStringFromSharedPref();
//     super.initState();
//     _absencesWorkBloc = BlocProvider.of<AbsencesWorkBloc>(context);
//   }

//   @override
//   void dispose() {
//     _eventController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     initializeDateFormatting('vi_VN', null);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppTheme.colors.deepBlue,
//         automaticallyImplyLeading: false,
//         title: Text(staffConstants.REGISTER_ABSENCES_TITLE),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//             // context.read<CustomerCarBloc>().add(DoCarListEvent());
//           },
//         ),
//       ),
//       backgroundColor: AppTheme.colors.lightblue,
//       body: SingleChildScrollView(
//         // child: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//           child: Container(
//             decoration: BoxDecoration(
//                 // color: Colors.white,
//                 border: Border.all(color: Colors.black26),
//                 borderRadius: BorderRadius.circular(5)),
//             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//             child: BlocListener<AbsencesWorkBloc, AbsencesWorkState>(
//               listener: (context, state) {
//                 // TODO: implement listener
//                 if (state.status == AbsencesWorkStatus.absencesWorkSuccess) {
//                   _showSelectedAbsencesWorkDialog();
//                   // Navigator.of(context).pop();
//                 } else if (state.status == AbsencesWorkStatus.error) {
//                   _showErrorAbsencesWorkDialog(state.message);
//                 }
//               },
//               child: Column(
//                 children: [
//                   Text(
//                     staffConstants.CHOOSE_ABSENCES_TITLE,
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   Container(
//                     child: Column(
//                       children: <Widget>[
//                         RadioListTile(
//                             title: Text(staffConstants.ONE_DAY),
//                             value: 1,
//                             groupValue: _valueSelected,
//                             onChanged: (value) {
//                               setState(() {
//                                 _valueSelected = value;
//                                 _isShowOneDay = true;
//                                 _isShowRangeDay = false;
//                               });
//                             }),
//                         Visibility(
//                           visible: _isShowOneDay,
//                           child: _valueSelected == 1
//                               ? ElevatedButton(
//                                   onPressed: () {
//                                     pickDate(context);
//                                   },
//                                   child: Text(getText()))
//                               : ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                       primary: Colors.grey),
//                                   onPressed: () {
//                                     // pickDate(context);
//                                   },
//                                   child: Text(getText(),
//                                       style: TextStyle(color: Colors.white))),
//                         ),
//                         RadioListTile(
//                             title: Text(staffConstants.RANGE_DAY),
//                             value: 2,
//                             groupValue: _valueSelected,
//                             onChanged: (value) {
//                               setState(() {
//                                 _valueSelected = value;
//                                 _isShowOneDay = false;
//                                 _isShowRangeDay = true;
//                               });
//                             }),
//                         Visibility(
//                           visible: _isShowRangeDay,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: _valueSelected == 2
//                                     ? ElevatedButton(
//                                         onPressed: () {
//                                           pickDateRange(context);
//                                         },
//                                         child: Text(getFrom()))
//                                     : ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                             primary: Colors.grey),
//                                         onPressed: () {
//                                           // pickDate(context);
//                                         },
//                                         child: Text(getFrom(),
//                                             style: TextStyle(
//                                                 color: Colors.white))),
//                               ),
//                               const SizedBox(width: 8),
//                               Icon(Icons.arrow_forward, color: Colors.white),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: _valueSelected == 2
//                                     ? ElevatedButton(
//                                         onPressed: () {
//                                           pickDateRange(context);
//                                         },
//                                         child: Text(getUntil()))
//                                     : ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                             primary: Colors.grey),
//                                         onPressed: () {
//                                           // pickDate(context);
//                                         },
//                                         child: Text(getUntil(),
//                                             style: TextStyle(
//                                                 color: Colors.white))),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: TextField(
//                       onChanged: (noteValue) {
//                         setState(() {
//                           _empNote = noteValue;
//                         });
//                       },
//                       maxLines: 3,
//                       decoration: InputDecoration.collapsed(
//                           hintText: staffConstants.REASON_REGISTER),
//                     ),
//                   ),
//                   ElevatedButton(
//                     style:
//                         ElevatedButton.styleFrom(primary: AppTheme.colors.blue),
//                     child: Text(staffConstants.CONFIRM_BUTTON),
//                     onPressed: () {
//                       if (_empNote == null) {
//                         _showErrorAbsencesWorkDialog(
//                             staffConstants.NOTI_INPUT_REASON);
//                       } else if (_valueSelected == 0) {
//                         _showErrorAbsencesWorkDialog(
//                             staffConstants.NOTI_SELECTED_DAY);
//                       } else {
//                         _listAbsences = [];
//                         _selectedDayList
//                             .map((e) => {
//                                   _absences.empUsername = _username,
//                                   _absences.noteEmp = _empNote,
//                                   _absences.timeStart = _startDate(e
//                                       .toIso8601String()
//                                       .split(staffConstants.T_SPLIT)[0]),
//                                   _absences.timeEnd = _endDate(e
//                                       .toIso8601String()
//                                       .split(staffConstants.T_SPLIT)[0]),
//                                   _listAbsences.add(_absences),
//                                 })
//                             .toList();
//                         _absencesWorkBloc.add(AbsencesWorkButtonPressed(
//                           username: _username,
//                           absences: _listAbsences,
//                         ));
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         // ),
//       ),
//     );
//   }

//   // _dateTimeFormat() {
//   //   Intl.defaultLocale = 'es';
//   //   print(DateFormat('hh:mm a').format(
//   //       DateTime.parse(_endDate(selectedDay.toIso8601String().split("T")[0]))));
//   // }

//   Future pickDate(BuildContext context) async {
//     final initialDate = DateTime.now();
//     final newDate = await showDatePicker(
//       context: context,
//       initialDate: date ?? initialDate,
//       firstDate: DateTime(DateTime.now().year - 5),
//       lastDate: DateTime(DateTime.now().year + 5),
//     );

//     if (newDate == null) return;

//     setState(() => {
//           date = newDate,
//           if (_selectedDayList.isNotEmpty) //neu co ngay thi chuyen thanh rong
//             {
//               _selectedDayList = [],
//               _selectedDayList.add(date),
//             }
//           else
//             {_selectedDayList.add(date)},
//           print(_selectedDayList)
//         });
//   }

//   String getText() {
//     if (date == null) {
//       return staffConstants.SELECT_DAY;
//     } else {
//       return DateFormat(staffConstants.DATE_FORMAT).format(date);
//       // return '${date.month}/${date.day}/${date.year}';
//     }
//   }

//   _showSelectedAbsencesWorkDialog() {
//     showDialog(
//         context: context,
//         builder: (BuildContext ctx) {
//           return AlertDialog(
//             title: Text(
//               staffConstants.NOTI_TITLE,
//               style: TextStyle(color: Colors.greenAccent),
//             ),
//             content: Text(staffConstants.NOTI_SUCCESS_REGISTER),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     // Close the dialog
//                     Navigator.pop(context);
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(staffConstants.OK_BUTTON))
//             ],
//           );
//         });
//   }

//   _showErrorAbsencesWorkDialog(String mess) {
//     showDialog(
//         context: context,
//         builder: (BuildContext ctx) {
//           return AlertDialog(
//             title: Text(
//               staffConstants.NOTI_TITLE,
//               style: TextStyle(color: Colors.greenAccent),
//             ),
//             content: Text(mess),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     // Close the dialog
//                     Navigator.pop(context);
//                     // Navigator.of(context).pop();
//                   },
//                   child: Text(staffConstants.OK_BUTTON))
//             ],
//           );
//         });
//   }

//   Future pickDateRange(BuildContext context) async {
//     final initialDateRange = DateTimeRange(
//       start: DateTime.now(),
//       end: DateTime.now().add(Duration(hours: 24 * 3)),
//     );
//     final newDateRange = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime(DateTime.now().year - 5),
//       lastDate: DateTime(DateTime.now().year + 5),
//       initialDateRange: dateRange ?? initialDateRange,
//     );

//     if (newDateRange == null) return;

//     setState(() => {
//           dateRange = newDateRange,
//           if (_selectedDayList.isNotEmpty) //neu ngay co thi xoa ngay di
//             {
//               _selectedDayList = [],
//               for (int i = 0;
//                   i <= newDateRange.end.difference(newDateRange.start).inDays;
//                   i++)
//                 {
//                   _selectedDayList
//                       .add(newDateRange.start.add(Duration(days: i)))
//                 },
//               print(dateRange),
//             }
//           else
//             {
//               for (int i = 0;
//                   i <= newDateRange.end.difference(newDateRange.start).inDays;
//                   i++)
//                 {
//                   _selectedDayList
//                       .add(newDateRange.start.add(Duration(days: i)))
//                 },
//               print(dateRange),
//             },
//           print(_selectedDayList)
//         });
//   }

//   String getFrom() {
//     if (dateRange == null) {
//       return staffConstants.FROM_DAY;
//     } else {
//       return DateFormat(staffConstants.DATE_FORMAT).format(dateRange.start);
//     }
//   }

//   String getUntil() {
//     if (dateRange == null) {
//       return staffConstants.TO_DAY;
//     } else {
//       return DateFormat(staffConstants.DATE_FORMAT).format(dateRange.end);
//     }
//   }
// }
