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
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleDetailUi extends StatefulWidget {
  final String orderId;

  ScheduleDetailUi({@required this.orderId});

  @override
  _ScheduleDetailUiState createState() => _ScheduleDetailUiState();
}

class _ScheduleDetailUiState extends State<ScheduleDetailUi> {
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
        title: Text('Quản lý công việc'),
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
                      Container(
                        decoration: BoxDecoration(
                            color: AppTheme.colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Thông tin khách hàng',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Text(
                                    'Họ tên:',
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    'Thời gian đặt lịch:',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    _convertDate(
                                        state.historyDetail[0].bookingTime),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    'Trạng thái hiện tại:',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    state.historyDetail[0].status,
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.red),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    'Loại dịch vụ:',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    state.historyDetail[0].note == null
                                        ? 'Bảo dưỡng'
                                        : 'Sửa chữa',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black26),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      'Thông tin xe',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Text(
                                            'Biển số xe:',
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            state.historyDetail[0].vehicle
                                                .licensePlate,
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Text(
                                            'Hãng xe:',
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            state.historyDetail[0].vehicle
                                                .manufacturer,
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Text(
                                            'Mã xe:',
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            state
                                                .historyDetail[0].vehicle.model,
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black26),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: state.historyDetail[0].note != null
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Column(
                                          children: [
                                            Text(
                                              'Ghi chú từ người dùng',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.baseline,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    state.historyDetail[0].note,
                                                    style: TextStyle(
                                                        fontSize: 15.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Text(
                                            'Thông tin gói dịch vụ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          ListView(
                                            shrinkWrap: true,
                                            children: state
                                                .historyDetail[0].orderDetails
                                                .map((service) {
                                              return ListTile(
                                                title: Text(service.name),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }
}
