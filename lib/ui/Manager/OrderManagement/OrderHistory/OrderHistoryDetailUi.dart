import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/blocs/manager/booking/booking_cubit.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_bloc.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_events.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingManagement/VerifyBookingUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoryDetailUi extends StatefulWidget {
  final String orderId;

  OrderHistoryDetailUi({@required this.orderId});

  @override
  _OrderHistoryDetailUiState createState() => _OrderHistoryDetailUiState();
}

class _OrderHistoryDetailUiState extends State<OrderHistoryDetailUi> {
  // UpdateStatusOrderBloc updateStatusBloc;
  @override
  void initState() {
    // updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    super.initState();
    BlocProvider.of<OrderHistoryBloc>(context)
        .add(DoOrderHistoryDetailEvent(id: widget.orderId));
    print(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    final String acceptStatus = 'Accepted';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Booking Information'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.detailStatus == OrderHistoryDetailStatus.init) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == OrderHistoryDetailStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == OrderHistoryDetailStatus.success) {
              if (state.historyDetail != null && state.historyDetail.isNotEmpty)
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              'Fullname:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            child: Text(
                              state.historyDetail[0].customer.fullname,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              'Email:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            child: Text(
                              state.historyDetail[0].customer.email,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              'Booking time:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            child: Text(
                              state.historyDetail[0].bookingTime,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              'Status:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            child: Text(
                              state.historyDetail[0].status,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 16),
                      // BlocListener<UpdateStatusOrderBloc,
                      //     UpdateStatusOrderState>(
                      //   // ignore: missing_return
                      //   listener: (builder, statusState) {
                      //     if (statusState.status ==
                      //         UpdateStatus.updateStatusSuccess) {
                      //       Navigator.pushNamed(context, '/manager');
                      //     }
                      //   },
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       SizedBox(
                      //         width: MediaQuery.of(context).size.width * 0.45,
                      //         child: ElevatedButton(
                      //           style: ElevatedButton.styleFrom(
                      //               primary: Colors.blue),
                      //           child: Text('Accept',
                      //               style: TextStyle(color: Colors.white)),
                      //           onPressed: () {
                      //             updateStatusBloc.add(
                      //                 UpdateStatusButtonPressed(
                      //                     id: state.bookingDetail[0].id,
                      //                     status: acceptStatus));
                      //           },
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: MediaQuery.of(context).size.width * 0.45,
                      //         child: ElevatedButton(
                      //           style: ElevatedButton.styleFrom(
                      //               primary: Colors.red),
                      //           child: Text('Deny',
                      //               style: TextStyle(color: Colors.white)),
                      //           onPressed: () {},
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                );
              else
                return Center(child: Text('Empty'));
            } else if (state.detailStatus == BookingDetailStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
