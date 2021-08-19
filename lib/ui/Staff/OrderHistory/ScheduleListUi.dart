import 'package:calendar_strip/calendar_strip.dart' ;
import 'package:car_service/blocs/manager/booking/booking_cubit.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_bloc.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_events.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/OrderManagement/OrderHistory/OrderHistoryDetailUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingManagement/VerifyBookingDetailUi.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleListUi extends StatefulWidget {
  @override
  _ScheduleListUiState createState() => _ScheduleListUiState();
}

class _ScheduleListUiState extends State<ScheduleListUi> {
  DateTime startDate = DateTime.now().subtract(Duration(days: 2));
  DateTime endDate = DateTime.now().add(Duration(days: 2));
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 2));
  List<DateTime> markedDates = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().add(Duration(days: 4))
  ];

  onSelect(data) {
    print("Selected Date -> $data");
  }

  onWeekSelect(data) {
    print("Selected week starting at -> $data");
  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(monthName,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontStyle: FontStyle.italic)),
      padding: EdgeInsets.only(top: 8, bottom: 4),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      ),
      Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      )
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 14.5, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // context.read<OrderHistoryBloc>().add(DoListOrderHistoryEvent());
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
          automaticallyImplyLeading: false,
          title: Text('Quản lý công việc'),
        ),
        backgroundColor: AppTheme.colors.lightblue,
        body: ListView(
          children: [
            Container(
                child: CalendarStrip(
              startDate: startDate,
              endDate: endDate,
              onDateSelected: onSelect,
              onWeekSelected: onWeekSelect,
              dateTileBuilder: dateTileBuilder,
              iconColor: Colors.black87,
              monthNameWidget: _monthNameWidget,
              markedDates: markedDates,
              containerDecoration: BoxDecoration(color: Colors.black12),
            ))
          ],
        )

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

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }
}
