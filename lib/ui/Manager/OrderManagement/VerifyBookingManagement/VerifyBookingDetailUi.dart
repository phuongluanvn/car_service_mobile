import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/blocs/manager/booking/booking_cubit.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingManagement/VerifyBookingUi.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/manager/booking/booking_bloc.dart';
import '../../../../blocs/manager/booking/booking_bloc.dart';
import '../../../../blocs/manager/booking/booking_events.dart';
import '../../../../blocs/manager/booking/booking_state.dart';
import '../../../../blocs/manager/booking/booking_state.dart';

class VerifyBookingDetailUi extends StatefulWidget {
  final String orderId;

  VerifyBookingDetailUi({@required this.orderId});

  @override
  _VerifyBookingDetailUiState createState() => _VerifyBookingDetailUiState();
}

class _VerifyBookingDetailUiState extends State<VerifyBookingDetailUi> {
  String reasonReject;
  UpdateStatusOrderBloc updateStatusBloc;
  @override
  void initState() {
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    super.initState();
    BlocProvider.of<VerifyBookingBloc>(context)
        .add(DoVerifyBookingDetailEvent(email: widget.orderId));
    print(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    final String acceptStatus = 'Đã xác nhận';
    final String denyStatus = 'Từ chối đặt lịch';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Thông tin đơn hàng'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<VerifyBookingBloc, VerifyBookingState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state.detailStatus == BookingDetailStatus.init) {
                return CircularProgressIndicator();
              } else if (state.detailStatus == BookingDetailStatus.loading) {
                return CircularProgressIndicator();
              } else if (state.detailStatus == BookingDetailStatus.success) {
                if (state.bookingDetail != null &&
                    state.bookingDetail.isNotEmpty)
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppTheme.colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                      state.bookingDetail[0].customer.fullname,
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
                                      state.bookingDetail[0].customer.email,
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
                                          state.bookingDetail[0].bookingTime),
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
                                      state.bookingDetail[0].status,
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
                                      state.bookingDetail[0].note == null
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
                                              state.bookingDetail[0].vehicle
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
                                              state.bookingDetail[0].vehicle
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
                                              state.bookingDetail[0].vehicle
                                                  .model,
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
                                  child: state.bookingDetail[0].note != null
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: Column(
                                            children: [
                                              Text(
                                                'Ghi chú từ người dùng',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                      state.bookingDetail[0]
                                                          .note,
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
                                              'Thông tin gói bảo dưỡng',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'Tên gói',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Center(
                                              child: Column(children: [
                                                for (int i = 0;
                                                    i <
                                                        state
                                                            .bookingDetail[0]
                                                            .packageLists
                                                            .length;
                                                    i++)
                                                  ExpansionTile(
                                                      title: Text(state
                                                          .bookingDetail[0]
                                                          .packageLists[i]
                                                          .name),
                                                          
                                                      children: [
                                                        for (int j = 0;
                                                            j <
                                                                state
                                                                    .bookingDetail[
                                                                        0]
                                                                    .packageLists[
                                                                        i]
                                                                    .orderDetails
                                                                    .length;
                                                            j++)
                                                          ListTile(
                                                            title: Text(state
                                                                .bookingDetail[
                                                                    0]
                                                                .packageLists[i]
                                                                .orderDetails[j]
                                                                .name),
                                                          ),
                                                      ]),
                                              ]),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        BlocListener<UpdateStatusOrderBloc,
                            UpdateStatusOrderState>(
                          // ignore: missing_return
                          listener: (builder, statusState) {
                            if (statusState.status ==
                                UpdateStatus.updateStatusSuccess) {
                              Navigator.pushNamed(context, '/manager');
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red),
                                  child: Text('Từ chối',
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return AlertDialog(
                                            title: Text(
                                              'Thông báo!',
                                              style: TextStyle(
                                                  color: Colors.redAccent),
                                            ),
                                            content: TextField(
                                              onChanged: (noteValue) {
                                                setState(() {
                                                  reasonReject = noteValue;
                                                });
                                              },
                                              maxLines: 3,
                                              decoration:
                                                  InputDecoration.collapsed(
                                                      hintText:
                                                          'Lý do từ chối'),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.pop(context);
                                                    print(reasonReject);
                                                    updateStatusBloc.add(
                                                        UpdateStatusDenyWithReasonButtonPressed(
                                                            id: state
                                                                .bookingDetail[
                                                                    0]
                                                                .id,
                                                            status: denyStatus,
                                                            reason:
                                                                reasonReject));
                                                  },
                                                  child: Text('Xác nhận')),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Hùy bỏ')),
                                            ],
                                          );
                                        });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: AppTheme.colors.blue),
                                  child: Text('Đồng ý',
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    updateStatusBloc.add(
                                        UpdateStatusButtonPressed(
                                            id: state.bookingDetail[0].id,
                                            status: acceptStatus));
                                  },
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
      ),
    );
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }
}
