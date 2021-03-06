import 'dart:convert';
import 'dart:io';

import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_event.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_state.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/booking/booking_bloc.dart';
import 'package:car_service/blocs/manager/booking/booking_events.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_bloc.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_events.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_state.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/ReviewTaskUi.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignOrderReviewUi extends StatefulWidget {
  final String userId;

  AssignOrderReviewUi({@required this.userId});

  @override
  _AssignOrderReviewUiState createState() => _AssignOrderReviewUiState();
}

class _AssignOrderReviewUiState extends State<AssignOrderReviewUi> {
  final String processingStatus = '??ang ti???n h??nh';
  final String workingStatus = '??ang l??m vi???c';
  UpdateStatusOrderBloc updateStatusBloc;
  bool _visible = false;
  bool _visibleKm = true;
  List<StaffModel> selectData = [];
  String description;

  // AssignorderCubit assignCubit;
  CrewBloc crewBloc;
  List selectCrewName = [];
  List<StaffModel> selectCrew = [];
  ProcessOrderBloc processOrderBloc;
  VerifyBookingBloc verifyBloc;
  CustomerCarBloc customerCarBloc;
  OrderHistoryBloc orderHistoryBloc;
  TextEditingController kmController = TextEditingController();
  int kmRecord = 0;
  int kmCheck = 0;
  String _crewId = '';
  String _selectCrewName = '';
  @override
  void initState() {
    super.initState();
    customerCarBloc = BlocProvider.of<CustomerCarBloc>(context);
    processOrderBloc = BlocProvider.of<ProcessOrderBloc>(context);
    verifyBloc = BlocProvider.of<VerifyBookingBloc>(context);
    orderHistoryBloc = BlocProvider.of<OrderHistoryBloc>(context);
    // assignCubit = BlocProvider.of<AssignorderCubit>(context);
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    crewBloc = BlocProvider.of<CrewBloc>(context);
    BlocProvider.of<AssignOrderBloc>(context)
        .add(DoAssignOrderDetailEvent(id: widget.userId));
    BlocProvider.of<VerifyBookingBloc>(context)
        .add(DoVerifyBookingDetailEvent(email: widget.userId));
    BlocProvider.of<OrderHistoryBloc>(context)
        .add(DoOrderHistoryDetailEvent(id: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final String sendConfirmStatus = '?????i ph???n h???i';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Qu???n l?? ????n h??ng'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<AssignOrderBloc, AssignOrderState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state.detailStatus == AssignDetailStatus.init) {
                return CircularProgressIndicator();
              } else if (state.detailStatus == AssignDetailStatus.loading) {
                return CircularProgressIndicator();
              } else if (state.detailStatus == AssignDetailStatus.success) {
                if (state.assignDetail != null &&
                    state.assignDetail.isNotEmpty &&
                    state.assignDetail[0].crew?.members != null &&
                    state.assignDetail[0].crew != null) {
                  _crewId = state.assignDetail[0].crew.id;
                  // selectCrew = state.assignDetail[0].crew.members;
                  if (state.assignDetail[0].status == '?????i ph???n h???i' ||
                      // state.assignDetail[0].status == '???? t??? ch???i' ||
                      state.assignDetail[0].status == '???? ?????ng ??') {
                    _visible = true;
                  }
                  // if (state.assignDetail[0].vehicle.millageCount != 0) {
                  //   _visibleKm = true;
                  // }
                  print(_visible);
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Th??ng tin kh??ch h??ng',
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
                                      'H??? t??n:',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      state.assignDetail[0].customer.fullname,
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
                                      state.assignDetail[0].customer.email,
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
                                        0.35,
                                    child: Text(
                                      'Th???i gian nh???n xe:',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      _convertDate(
                                          state.assignDetail[0].bookingTime),
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                ],
                              ),
                              Container(height: 16),
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
                                        'Th??ng tin xe',
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
                                              'Bi???n s??? xe:',
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              state.assignDetail[0].vehicle
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
                                              'H??ng xe:',
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              state.assignDetail[0].vehicle
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
                                              'M?? xe:',
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              state.assignDetail[0].vehicle
                                                  .model,
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(height: 10),
                                      BlocListener<CustomerCarBloc,
                                          CustomerCarState>(
                                        listener: (context, cstate) {
                                          print(cstate);
                                          if (cstate.withIdstatus ==
                                              CustomerCarWithIdStatus.init) {
                                            print("object");
                                            setState(() {
                                              _visibleKm = false;
                                              orderHistoryBloc.add(
                                                DoOrderHistoryDetailEvent(
                                                    id: widget.userId),
                                              );
                                            });
                                            orderHistoryBloc.add(
                                                DoOrderHistoryDetailEvent(
                                                    id: widget.userId));
                                          }
                                        },
                                        child: BlocBuilder<OrderHistoryBloc,
                                                OrderHistoryState>(
                                            // ignore: missing_return
                                            builder: (context, costate) {
                                          print(costate);
                                          if (costate.detailStatus ==
                                              OrderHistoryDetailStatus.init) {
                                            return CircularProgressIndicator();
                                          } else if (costate.detailStatus ==
                                              OrderHistoryDetailStatus
                                                  .loading) {
                                            return CircularProgressIndicator();
                                          } else if (costate.detailStatus ==
                                              OrderHistoryDetailStatus
                                                  .success) {
                                            if (costate.historyDetail != null &&
                                                costate
                                                    .historyDetail.isNotEmpty) {
                                              return _visibleKm
                                                  ? Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .baseline,
                                                          textBaseline:
                                                              TextBaseline
                                                                  .alphabetic,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                              child: Text(
                                                                'S??? km ???????c ghi nh???n:',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                costate
                                                                    .historyDetail[
                                                                        0]
                                                                    .vehicle
                                                                    .millageCount
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary: AppTheme
                                                                        .colors
                                                                        .blue),
                                                            onPressed: () {
                                                              setState(() {
                                                                _visibleKm =
                                                                    false;
                                                              });
                                                            },
                                                            child: Text(
                                                                'Ch???nh s???a')),
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          // textBaseline: TextBaseline.alphabetic,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.82,
                                                              child:
                                                                  TextFormField(
                                                                initialValue: costate
                                                                    .historyDetail[
                                                                        0]
                                                                    .vehicle
                                                                    .millageCount
                                                                    .toString(),
                                                                // controller: kmController,
                                                                maxLines: null,
                                                                autofocus:
                                                                    false,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  labelText:
                                                                      'S??? km ???????c ghi nh???n',
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .fromLTRB(
                                                                              20,
                                                                              10,
                                                                              20,
                                                                              10),
                                                                ),
                                                                onChanged:
                                                                    (event) {
                                                                  // kmController.text = event;
                                                                  kmRecord =
                                                                      int.parse(
                                                                          event);
                                                                },
                                                                // textInputAction:
                                                                //     TextInputAction.search,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary:
                                                                      AppTheme
                                                                          .colors
                                                                          .blue),
                                                          child:
                                                              Text('C???p nh???t'),
                                                          onPressed: () {
                                                            setState(() {
                                                              _visibleKm = true;
                                                              customerCarBloc.add(
                                                                  DoUpdateInfoCarEvent(
                                                                      id: state
                                                                          .assignDetail[
                                                                              0]
                                                                          .vehicle
                                                                          .id,
                                                                      kilometer:
                                                                          kmRecord));
                                                            });
                                                            orderHistoryBloc.add(
                                                                DoOrderHistoryDetailEvent(
                                                                    id: widget
                                                                        .userId));
                                                            orderHistoryBloc.add(
                                                                DoOrderHistoryDetailEvent(
                                                                    id: widget
                                                                        .userId));
                                                          },
                                                        ),
                                                      ],
                                                    );
                                            } else
                                              return Center(
                                                  child: Text('Empty'));
                                          } else if (costate.detailStatus ==
                                              OrderHistoryDetailStatus.error) {
                                            return ErrorWidget(
                                                state.message.toString());
                                          }
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text(
                                        'Ghi ch?? t??? ng?????i d??ng:',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Flexible(
                                        child: Text(
                                          state.assignDetail[0].note ??
                                              'Kh??ng c?? ghi ch??',
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 1,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.065,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: AppTheme.colors.blue),
                                        child: Text('D???ch v???',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (_) => ReviewTaskUi(
                                                        orderId: state
                                                            .assignDetail[0].id,
                                                      )));
                                        },
                                      ),
                                    ),
                                    BlocListener<UpdateStatusOrderBloc,
                                        UpdateStatusOrderState>(
                                      // ignore: missing_return
                                      listener: (builder, statusState) {
                                        if (statusState.status ==
                                            UpdateStatus
                                                .updateStatusWaitConfirmSuccess) {
                                          setState(() {
                                            _visible = true;
                                            verifyBloc.add(
                                              DoVerifyBookingDetailEvent(
                                                  email: widget.userId),
                                            );
                                          });
                                        }
                                      },
                                      child: BlocBuilder<VerifyBookingBloc,
                                          VerifyBookingState>(
                                        // ignore: missing_return
                                        builder: (context, costate) {
                                          if (costate.detailStatus ==
                                              BookingDetailStatus.init) {
                                            return CircularProgressIndicator();
                                          } else if (costate.detailStatus ==
                                              BookingDetailStatus.loading) {
                                            return CircularProgressIndicator();
                                          } else if (costate.detailStatus ==
                                              BookingDetailStatus.success) {
                                            if (costate.bookingDetail != null &&
                                                costate
                                                    .bookingDetail.isNotEmpty) {
                                              return SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.065,
                                                child: _visible
                                                    ? Container(
                                                        decoration: BoxDecoration(
                                                            color: AppTheme
                                                                .colors.white,
                                                            border: Border.all(
                                                                width: 2,
                                                                color: AppTheme
                                                                    .colors
                                                                    .deepBlue),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Center(
                                                          child: Text(
                                                            costate
                                                                .bookingDetail[
                                                                    0]
                                                                .status,
                                                            style: TextStyle(
                                                                color: AppTheme
                                                                    .colors
                                                                    .deepBlue),
                                                          ),
                                                        ))
                                                    : ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    AppTheme
                                                                        .colors
                                                                        .blue),
                                                        child: Text(
                                                            'G???i x??c nh???n',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        onPressed: () {
                                                          // updateStatusBloc.add(
                                                          //     UpdateStatusSendConfirmButtonPressed(
                                                          //         id: state
                                                          //             .assignDetail[
                                                          //                 0]
                                                          //             .id,
                                                          //         status:
                                                          //             sendConfirmStatus));
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      ctx) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                    'Th??ng b??o!',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .redAccent),
                                                                  ),
                                                                  content:
                                                                      TextField(
                                                                    onChanged:
                                                                        (noteValue) {
                                                                      setState(
                                                                          () {
                                                                        description =
                                                                            noteValue;
                                                                      });
                                                                    },
                                                                    maxLines: 3,
                                                                    decoration: InputDecoration.collapsed(
                                                                        hintText:
                                                                            'M?? t???'),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          Navigator.pop(
                                                                              context);
                                                                          print(
                                                                              description);
                                                                          updateStatusBloc.add(UpdateStatusDenyWithReasonButtonPressed(
                                                                              id: state.assignDetail[0].id,
                                                                              status: sendConfirmStatus,
                                                                              reason: description));
                                                                        },
                                                                        child: Text(
                                                                            'X??c nh???n')),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: Text(
                                                                            'H??y b???')),
                                                                  ],
                                                                );
                                                              });
                                                        },
                                                      ),
                                              );
                                            } else
                                              return Center(
                                                  child: Text('Empty'));
                                          } else if (costate.detailStatus ==
                                              BookingDetailStatus.error) {
                                            return ErrorWidget(
                                                state.message.toString());
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black87,
                          height: 20,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: [
                                    // Container(
                                    //   height: MediaQuery.of(context)
                                    //           .size
                                    //           .height *
                                    //       0.3,
                                    //   width: MediaQuery.of(context)
                                    //           .size
                                    //           .width *
                                    //       0.7,
                                    //   child:
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black26),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: Column(
                                        children: [
                                          Text(
                                            'T??? ?????i ph??? tr??ch',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),

                                          Column(
                                            children: [
                                              // Text(_crewId),
                                              // for (int i = 0;
                                              //     i < selectCrew.length;
                                              //     i++)
                                              Card(
                                                child: Column(children: [
                                                  _selectCrewName != ''
                                                      ? ListTile(
                                                          leading: Image.asset(
                                                              'lib/images/logo_blue.png'),
                                                          title: Text(
                                                              _selectCrewName),
                                                        )
                                                      : ListTile(
                                                          leading: Image.asset(
                                                              'lib/images/logo_blue.png'),
                                                          title: Text(state
                                                              .assignDetail[0]
                                                              .crew
                                                              .leaderFullname),
                                                        ),
                                                ]),
                                              ),
                                            ],
                                          ),
                                          // ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: AppTheme.colors.blue,
                                              ),
                                              child: Text('Ch???n t??? ?????i'),
                                              onPressed: () => setState(() {
                                                    crewBloc
                                                        .add(DoListAvailCrew());
                                                    showInformationDialog(
                                                            context,
                                                            widget.userId)
                                                        .then((value) {
                                                      setState(() {
                                                        selectData = value;
                                                      });
                                                    });
                                                  })),
                                          Container(height: 10),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            child: BlocListener<
                                                UpdateStatusOrderBloc,
                                                UpdateStatusOrderState>(
                                              // ignore: missing_return
                                              listener: (builder, statusState) {
                                                if (statusState.status ==
                                                    UpdateStatus
                                                        .updateStatusStartSuccess) {}
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.45,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: AppTheme
                                                                  .colors.blue),
                                                      child: Text('B???t ?????u',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      onPressed: () {
                                                        print(state
                                                            .assignDetail[0]
                                                            .id);
                                                        // crewBloc.add(UpdateCrewToListEvent(
                                                        //     id: widget
                                                        //         .userId,
                                                        //     listName:
                                                        //         widget.selectCrewName));
                                                        updateStatusBloc.add(
                                                            UpdateStatusStartAndWorkingButtonPressed(
                                                                id: state
                                                                    .assignDetail[
                                                                        0]
                                                                    .id,
                                                                listData: state
                                                                    .assignDetail[
                                                                        0]
                                                                    .crew
                                                                    .members,
                                                                status:
                                                                    processingStatus,
                                                                workingStatus:
                                                                    workingStatus));

                                                        Navigator.pushNamed(
                                                            context,
                                                            '/manager');
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Container(
                                    //   child: Text('$holder'),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else
                  return Center(child: Text('Empty'));
              } else if (state.detailStatus == AssignDetailStatus.error) {
                return ErrorWidget(state.message.toString());
              }
            },
          ),
        ),
      ),
    );
  }

  Future showInformationDialog(BuildContext context, String orderId) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Form(
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.7,
                    // width: MediaQuery.of(context).size.width * 0.7,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Ch???n t??? ?????i',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.7,
                            // child: SingleChildScrollView(
                            child: BlocBuilder<CrewBloc, CrewState>(
                              // ignore: missing_return
                              builder: (context, stateOfPackage) {
                                if (stateOfPackage.status ==
                                    ListCrewStatus.init) {
                                  return Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator());
                                } else if (stateOfPackage.status ==
                                    ListCrewStatus.loading) {
                                  return Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator());
                                } else if (stateOfPackage.status ==
                                    ListCrewStatus.availSuccess) {
                                  if (stateOfPackage.crewAvailList != null &&
                                      stateOfPackage.crewAvailList.isNotEmpty)
                                    return ListView.builder(
                                      itemCount:
                                          stateOfPackage.crewAvailList.length,
                                      shrinkWrap: true,
                                      // ignore: missing_return
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            title: Text(
                                              stateOfPackage
                                                  .crewAvailList[index]
                                                  .leaderFullname,
                                              style: TextStyle(
                                                  color: (_crewId ==
                                                          stateOfPackage
                                                              .crewAvailList[
                                                                  index]
                                                              .id)
                                                      ? AppTheme.colors.deepBlue
                                                      : Colors.grey),
                                            ),
                                            subtitle: Text(stateOfPackage
                                                .crewAvailList[index]
                                                .leaderFullname),
                                            onTap: () {
                                              setState(() {
                                                _crewId = stateOfPackage
                                                    .crewAvailList[index].id;
                                                print(_crewId);
                                                _selectCrewName = stateOfPackage
                                                    .crewAvailList[index]
                                                    .leaderFullname;
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  else //n???u kh??ng c?? xe n??o
                                    return Text('Hi???n t???i kh??ng c?? t??? ?????i');
                                } else if (stateOfPackage.status ==
                                    ListCrewStatus.error) {
                                  return ErrorWidget(
                                      stateOfPackage.message.toString());
                                }
                              },
                            ),
                            // ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'X??c nh???n',
                    style: TextStyle(color: AppTheme.colors.blue),
                  ),
                  onPressed: () {
                    // processOrderBloc.add(UpdateSelectCrewEvent(
                    //     crewId: crewId,
                    //     selectCrew: selectCrew,
                    //     orderId: orderId));
                    // Do something like updating SharedPreferences or User Settings etc.

                    crewBloc.add(UpdateCrewToListEvent(
                        id: widget.userId, crewId: _crewId));
                    Navigator.pop(context);
                    BlocProvider.of<AssignOrderBloc>(context)
                        .add(DoAssignOrderDetailEvent(id: widget.userId));
                  },
                ),
              ],
            );
          });
        });
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }
}
