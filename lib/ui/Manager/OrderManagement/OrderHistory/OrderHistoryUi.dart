import 'package:car_service/blocs/manager/booking/booking_cubit.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_bloc.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_events.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/OrderManagement/OrderHistory/OrderHistoryDetailUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingManagement/VerifyBookingDetailUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/manager/booking/booking_bloc.dart';
import '../../../../blocs/manager/booking/booking_bloc.dart';
import '../../../../blocs/manager/booking/booking_events.dart';

class OrderHistoryUi extends StatefulWidget {
  @override
  _OrderHistoryUiState createState() => _OrderHistoryUiState();
}

class _OrderHistoryUiState extends State<OrderHistoryUi> {
  @override
  void initState() {
    super.initState();

    context.read<OrderHistoryBloc>().add(DoListOrderHistoryEvent());
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
        title: Text('Lịch sử đơn hàng'),
      ),
      backgroundColor: Colors.blue[100],
      body: Center(
        child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == OrderHistoryStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == OrderHistoryStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == OrderHistoryStatus.historySuccess) {
              if (state.historyList != null && state.historyList.isNotEmpty)
                return ListView.builder(
                  itemCount: state.historyList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Column(children: [
                      ListTile(
                        trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.circle,
                                color: Colors.red,
                              ),
                              Text('Finished'),
                            ]),
                        leading: FlutterLogo(),
                        title: Text(state.historyList[index].customer.fullname),
                        subtitle: Text(state.historyList[index].bookingTime),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => OrderHistoryDetailUi(
                                  orderId: state.historyList[index].id)));
                        },
                      ),
                    ])

                        // : Column(children: [
                        //     ListTile(
                        //       trailing: Column(
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: <Widget>[
                        //             Icon(
                        //               Icons.circle,
                        //               color: Colors.green,
                        //             ),
                        //             Text('Đợi xác nhận'),
                        //           ]),
                        //       leading: FlutterLogo(),
                        //       title: Text(
                        //           state.orderLists[index].taiKhoan),
                        //       subtitle:
                        //           Text(state.orderLists[index].hoTen),
                        //       onTap: () {
                        //         Navigator.of(context).push(
                        //             MaterialPageRoute(
                        //                 builder: (_) =>
                        //                     CustomerCarDetailUi(
                        //                         emailId: state
                        //                             .orderLists[index]
                        //                             .taiKhoan)));
                        //       },
                        //     ),
                        //   ]),
                        );
                    // ListTile(
                    //   title: Text(state.bookingList[index].customer.fullname),
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (_) => VerifyBookingDetailUi(
                    //             emailId: state.bookingList[index].id)));
                    //   },
                    // );
                  },
                );
              else
                return Center(
                  child: Text('Empty'),
                );
            } else if (state.status == OrderHistoryStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
