import 'dart:ffi';

import 'package:car_service/blocs/manager/Accessories/accessory_bloc.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_state.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/blocs/manager/waitingPayment/waitingPayment_bloc.dart';
import 'package:car_service/blocs/manager/waitingPayment/waitingPayment_events.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';

class WaitingPaymentDetailUi extends StatefulWidget {
  final String orderId;

  WaitingPaymentDetailUi({@required this.orderId});

  @override
  _WaitingPaymentDetailUiState createState() => _WaitingPaymentDetailUiState();
}

class _WaitingPaymentDetailUiState extends State<WaitingPaymentDetailUi> {
  final String processingStatus = 'Hoàn thành';
  final String workingStatus = 'Đang hoạt động';
  UpdateStatusOrderBloc updateStatusBloc;
  bool _visible = false;
  bool checkedValue = false;
  String selectItem;
  String holder = '';
  int countPrice = 0;
  @override
  void initState() {
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    super.initState();

    BlocProvider.of<ProcessOrderBloc>(context)
        .add(DoProcessOrderDetailEvent(email: widget.orderId));
    BlocProvider.of<AccessoryBloc>(context).add(DoListAccessories());
    // BlocProvider.of<StaffBloc>(context).add(DoListStaffEvent());
  }

  void getDropDownItem() {
    setState(() {
      holder = selectItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Thanh toán'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: BlocBuilder<ProcessOrderBloc, ProcessOrderState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state.detailStatus == ProcessDetailStatus.init) {
                  return CircularProgressIndicator();
                } else if (state.detailStatus == ProcessDetailStatus.loading) {
                  return CircularProgressIndicator();
                } else if (state.detailStatus == ProcessDetailStatus.success) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    // child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Thông tin khách hàng',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                                      state.processDetail[0].customer.fullname,
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
                                      state.processDetail[0].customer.email,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.36,
                                    child: Text(
                                      'Thời gian xác nhận:',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      _convertDate(
                                          state.processDetail[0].bookingTime),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.36,
                                    child: Text(
                                      'Trạng thái:',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      state.processDetail[0].status,
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                ],
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       vertical: 5, horizontal: 5),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         border: Border.all(color: Colors.black26),
                              //         borderRadius: BorderRadius.circular(5)),
                              //     padding: EdgeInsets.symmetric(
                              //         horizontal: 5, vertical: 10),
                              //     child: Column(
                              //       children: [
                              //         Text(
                              //           'Thông tin gói dịch vụ',
                              //           style: TextStyle(
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.w600),
                              //         ),
                              //         ListView(
                              //           shrinkWrap: true,
                              //           children: state
                              //               .bookingDetail[0].orderDetails
                              //               .map((service) {
                              //             return ListTile(
                              //               title: Text(service.name),
                              //             );
                              //           }).toList(),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Center(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Thông tin hóa đơn',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Column(
                                      children: state
                                          .processDetail[0].orderDetails
                                          .map((service) {
                                        countPrice += service.price;
                                        return BlocBuilder<AccessoryBloc,
                                                AccessoryState>(
                                            // ignore: missing_return
                                            builder: (context, accState) {
                                          if (accState.status ==
                                              ListAccessoryStatus.init) {
                                            return CircularProgressIndicator();
                                          } else if (accState.status ==
                                              ListAccessoryStatus.loading) {
                                            return CircularProgressIndicator();
                                          } else if (accState.status ==
                                              ListAccessoryStatus.success) {
                                            return ExpansionTile(
                                              title: Text(service.name),
                                              trailing: Text(_convertMoney(
                                                  service.price.toDouble() != 0
                                                      ? service.price.toDouble()
                                                      : 0)),
                                              children: [
                                                accState.accessoryList.indexWhere(
                                                            (element) =>
                                                                element.id ==
                                                                service
                                                                    .accessoryId) >=
                                                        0
                                                    ? ListTile(
                                                        title: Text(accState
                                                            .accessoryList
                                                            .firstWhere((element) =>
                                                                element.id ==
                                                                service
                                                                    .accessoryId)
                                                            .name),
                                                        trailing: Image.network(
                                                            accState
                                                                .accessoryList
                                                                .firstWhere(
                                                                    (element) =>
                                                                        element
                                                                            .id ==
                                                                        service
                                                                            .accessoryId)
                                                                .imageUrl),
                                                      )
                                                    : Text(
                                                        'Hiện tại không có phụ tùng'),
                                              ],
                                            );
                                          }
                                          ;
                                        });
                                      }).toList(),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      thickness: 2,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                    ListTile(
                                        title: Text(
                                          'Tổng cộng: ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        trailing: Text(
                                          _convertMoney(
                                              countPrice.toDouble() != 0
                                                  ? countPrice.toDouble()
                                                  : 0),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                BlocListener<UpdateStatusOrderBloc,
                                    UpdateStatusOrderState>(
                                  // ignore: missing_return
                                  listener: (builder, statusState) {
                                    if (statusState.status ==
                                        UpdateStatus.updateStatusStartSuccess) {
                                      // Navigator.pushNamed(
                                      //     context, '/manager');
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: AppTheme.colors.blue),
                                          child: Text('Hoàn thành',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onPressed: () {
                                            updateStatusBloc.add(
                                                UpdateStatusButtonPressed(
                                                    id: state
                                                        .processDetail[0].id,
                                                    status: processingStatus));
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ManagerMain()));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // ),
                    // ),
                    // ),
                  );
                } else if (state.detailStatus == ProcessDetailStatus.error) {
                  return ErrorWidget(state.message.toString());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }

  _convertMoney(double money) {
    MoneyFormatter fmf = new MoneyFormatter(
        amount: money,
        settings: MoneyFormatterSettings(
          symbol: 'VND',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 0,
          // compactFormatType: CompactFormatType.sort
        ));
    print(fmf.output.symbolOnRight);
    return fmf.output.symbolOnRight.toString();
  }
}
