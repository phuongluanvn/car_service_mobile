import 'package:car_service/blocs/manager/CrewManagement/crew_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_event.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_state.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
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
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignOrderDetailUi extends StatefulWidget {
  final String orderId;
  AssignOrderDetailUi({@required this.orderId});

  @override
  _AssignOrderDetailUiState createState() => _AssignOrderDetailUiState();
}

class _AssignOrderDetailUiState extends State<AssignOrderDetailUi> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _visible = false;
  UpdateStatusOrderBloc updateStatusBloc;
  String selectItem;
  String holder = '';
  List<StaffModel> selectData = [];
  List<StaffModel> selectbackvalue = [];
  bool _selectStaff = false;
  List<CrewModel> selectCrew = [];
  List selectCrewName = [];
  CrewBloc crewBloc;
  ProcessOrderBloc processOrderBloc;
  bool _checkStatusCheckin = true;
  OrderHistoryBloc orderHistoryBloc;
  String _crewId = '';
  String _crewName = '';

  @override
  void initState() {
    super.initState();
    orderHistoryBloc = BlocProvider.of<OrderHistoryBloc>(context);
    processOrderBloc = BlocProvider.of<ProcessOrderBloc>(context);
    crewBloc = BlocProvider.of<CrewBloc>(context);
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    BlocProvider.of<AssignOrderBloc>(context)
        .add(DoAssignOrderDetailEvent(id: widget.orderId));
    // BlocProvider.of<ManageStaffBloc>(context).add(DoListStaffEvent());
    BlocProvider.of<OrderHistoryBloc>(context)
        .add(DoOrderHistoryDetailEvent(id: widget.orderId));
  }

  void getDropDownItem() {
    setState(() {
      holder = selectItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String checkinStatus = 'Đã nhận xe';
    final String checkingStatus = 'Kiểm tra';
    final String cancelStatus = 'Hủy đơn';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Quản lý đơn hàng'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15, top: 5),
            child: BlocListener<UpdateStatusOrderBloc, UpdateStatusOrderState>(
              // ignore: missing_return
              listener: (builder, statusState) {
                if (statusState.status ==
                    UpdateStatus.updateStatusCancelSuccess) {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                }
              },
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red[800]),
                            child: Center(
                              child: Text('Hủy đơn',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            onPressed: () {
                              updateStatusBloc.add(
                                  UpdateStatusCancelButtonPressed(
                                      id: widget.orderId,
                                      status: cancelStatus));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
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
                    state.assignDetail.isNotEmpty) {
                  if (state.assignDetail[0].crew != null &&
                      state.assignDetail[0].crew.id != null &&
                      state.assignDetail[0].crew.id.isNotEmpty) {
                    _crewId = state.assignDetail[0].crew.id;
                  }
                  print('checkk' + _crewId);
                  if (state.assignDetail[0].status == 'Đã nhận xe') {
                    _visible = true;
                    _checkStatusCheckin = false;
                  }
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
                                        0.36,
                                    child: Text(
                                      'Thời gian xác nhận:',
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
                                              'Hãng xe:',
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
                                              'Mã xe:',
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
                                    ],
                                  ),
                                ),
                              ),
                              BlocListener<UpdateStatusOrderBloc,
                                  UpdateStatusOrderState>(
                                // ignore: missing_return
                                listener: (builder, statusState) {
                                  if (statusState.status ==
                                      UpdateStatus.updateStatusCheckinSuccess) {
                                    setState(() {
                                      _visible = true;
                                      _checkStatusCheckin = false;
                                      orderHistoryBloc.add(
                                          DoOrderHistoryDetailEvent(
                                              id: widget.orderId));
                                    });
                                  } else if (statusState.status ==
                                      UpdateStatus
                                          .updateStatusCheckingSuccess) {}
                                },
                                child: BlocBuilder<OrderHistoryBloc,
                                    OrderHistoryState>(
                                  // ignore: missing_return
                                  builder: (context, hstate) {
                                    if (hstate.detailStatus ==
                                        OrderHistoryDetailStatus.init) {
                                      return CircularProgressIndicator();
                                    } else if (hstate.detailStatus ==
                                        OrderHistoryDetailStatus.loading) {
                                      return CircularProgressIndicator();
                                    } else if (hstate.detailStatus ==
                                        OrderHistoryDetailStatus.success) {
                                      if (hstate.historyDetail != null &&
                                          hstate.historyDetail.isNotEmpty) {
                                        return Visibility(
                                          visible: _checkStatusCheckin,
                                          child: Column(
                                            children: [
                                              Row(
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
                                                      child: Text('Nhận xe',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      onPressed: () {
                                                        updateStatusBloc.add(
                                                            UpdateStatusCheckinButtonPressed(
                                                                id: hstate
                                                                    .historyDetail[
                                                                        0]
                                                                    .id,
                                                                status:
                                                                    checkinStatus));
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      } else
                                        return Center(child: Text('Empty'));
                                    } else if (hstate.detailStatus ==
                                        OrderHistoryDetailStatus.error) {
                                      return Text(hstate.message.toString());
                                    }
                                  },
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
                        Visibility(
                          visible: _visible,
                          child: Container(
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
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black26),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Tổ đội phụ trách',
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
                                                    // state.assignDetail[0]
                                                    //                 .crew !=
                                                    //             null &&
                                                    //         state
                                                    //                 .assignDetail[
                                                    //                     0]
                                                    //                 .crew
                                                    //                 .id !=
                                                    //             null &&
                                                    //         state
                                                    //             .assignDetail[0]
                                                    //             .crew
                                                    //             .id
                                                    //             .isNotEmpty
                                                    // _crewId ==
                                                    //         state
                                                    //             .assignDetail[0]
                                                    //             .crew
                                                    //             .id
                                                    _crewName != ''
                                                        ? ListTile(
                                                            leading: Image.asset(
                                                                'lib/images/logo_blue.png'),
                                                            title:
                                                                Text(_crewName),
                                                          )
                                                        : ListTile(
                                                            leading: state
                                                                        .assignDetail[
                                                                            0]
                                                                        .crew !=
                                                                    null
                                                                ? Image.asset(
                                                                    'lib/images/logo_blue.png')
                                                                : SizedBox(),
                                                            title: Text(state
                                                                        .assignDetail[
                                                                            0]
                                                                        .crew !=
                                                                    null
                                                                ? state
                                                                    .assignDetail[
                                                                        0]
                                                                    .crew
                                                                    .leaderFullname
                                                                : ''),
                                                          ),
                                                  ]),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        AppTheme.colors.blue),
                                                child: Text('Chọn tổ đội'),
                                                onPressed: () => setState(() {
                                                      crewBloc.add(
                                                          DoListAvailCrew());
                                                      showInformationDialog(
                                                              context,
                                                              widget.orderId)
                                                          .then((value) {
                                                        setState(() {
                                                          selectData = value;
                                                        });
                                                      });
                                                    })),
                                            Container(height: 10),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: AppTheme.colors.blue),
                                          child: Text('Kiểm tra xe',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onPressed: () {
                                            updateStatusBloc.add(
                                                UpdateStatusCheckingButtonPressed(
                                                    id: state
                                                        .assignDetail[0].id,
                                                    status: checkingStatus));

                                            Navigator.pushNamed(
                                                context, '/manager');
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
                  );
                } else
                  return Center(child: Text('Empty'));
              } else if (state.detailStatus == AssignDetailStatus.error) {
                return Text(state.message.toString());
              }
            },
          ),
        ),
      ),
    );
  }

  // ======================

  Future showInformationDialog(BuildContext context, String orderId) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Form(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Chọn tổ đội',
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
                                                if (stateOfPackage
                                                        .crewAvailList[index]
                                                        .leaderFullname !=
                                                    null) {
                                                  _crewName = stateOfPackage
                                                      .crewAvailList[index]
                                                      .leaderFullname;
                                                }
                                                print(_crewId);
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  else //nếu không có xe nào
                                    return Text('Hiện tại không có tổ đội');
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
                    'Xác nhận',
                    style: TextStyle(color: AppTheme.colors.blue),
                  ),
                  onPressed: () {
                    // processOrderBloc.add(UpdateSelectCrewEvent(
                    //     crewId: crewId,
                    //     selectCrew: selectCrew,
                    //     orderId: orderId));
                    // Do something like updating SharedPreferences or User Settings etc.
                    crewBloc.add(UpdateCrewToListEvent(
                        id: widget.orderId, crewId: _crewId));
                    Navigator.pop(context);
                    BlocProvider.of<AssignOrderBloc>(context)
                        .add(DoAssignOrderDetailEvent(id: widget.orderId));
                  },
                ),
              ],
            );
          });
        });
  }

  // Future showInformationDialog(
  //     BuildContext context, List<CrewModel> crewlist, String orderId) async {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(builder: (context, setState) {
  //           return AlertDialog(
  //             content: SingleChildScrollView(
  //               child: Form(
  //                 child: Container(
  //                   // height: MediaQuery.of(context).size.height * 0.7,
  //                   // width: MediaQuery.of(context).size.width * 0.7,
  //                   child: SingleChildScrollView(
  //                     child: Column(
  //                       children: [
  //                         Text(
  //                           'Chọn nhân viên',
  //                           style: TextStyle(
  //                               fontSize: 16, fontWeight: FontWeight.w600),
  //                         ),
  //                         Container(
  //                           height: MediaQuery.of(context).size.height * 0.5,
  //                           width: MediaQuery.of(context).size.width * 0.7,
  //                           child:
  //                               // BlocBuilder<AssignorderCubit,
  //                               //     AssignorderCubitState>(
  //                               //   builder: (context, state) {
  //                               //     return
  //                               ListView.builder(
  //                                   itemCount: crewlist.length,
  //                                   itemBuilder:
  //                                       (BuildContext context, int index) {
  //                                     return CheckboxListTile(
  //                                       value: selectCrew.indexWhere(
  //                                               (element) =>
  //                                                   element.leaderFullname ==
  //                                                   crewlist[index]
  //                                                       .leaderFullname) >=
  //                                           0,
  //                                       onChanged: (bool selected) {
  //                                         if (selected) {
  //                                           setState(() {
  //                                             // BlocProvider.of<AssignorderCubit>(
  //                                             //         context)
  //                                             //     .addItem(stafflist[index]);
  //                                             selectCrew.add(crewlist[index]);
  //                                             // selectCrewName.add(
  //                                             //     stafflist[index].username);
  //                                             // print('select crew name 1');
  //                                             // print(selectCrew);
  //                                           });
  //                                         } else {
  //                                           setState(() {
  //                                             // BlocProvider.of<AssignorderCubit>(
  //                                             //         context)
  //                                             //     .removeItem(stafflist[index]);
  //                                             // selectCrewName.remove(
  //                                             //     stafflist[index].username);
  //                                             selectCrew
  //                                                 .remove(crewlist[index]);
  //                                             print('select crew name 2');
  //                                             print(selectCrew);
  //                                           });
  //                                         }
  //                                       },
  //                                       title: Text(crewlist[index].leaderFullname),
  //                                     );
  //                                   }),
  //                           //   },
  //                           // ),
  //                         ),
  //                       ],
  //                       //  stafflist.map((e) {
  //                       //   return CheckboxListTile(
  //                       //       activeColor: AppTheme.colors.deepBlue,

  //                       //       //font change
  //                       //       title: new Text(
  //                       //         e.username,
  //                       //       ),
  //                       //       value: selectData.indexOf(e) < 0 ? false : true,
  //                       //       secondary: Container(
  //                       //         height: 50,
  //                       //         width: 50,
  //                       //         child: Image.asset(
  //                       //           'lib/images/logo_blue.png',
  //                       //           fit: BoxFit.cover,
  //                       //         ),
  //                       //       ),
  //                       //       onChanged: (bool val) {
  //                       //         if (selectData.indexOf(e) < 0) {
  //                       //           setState(() {
  //                       //             selectData.add(e);
  //                       //             _selectStaff = true;
  //                       //           });
  //                       //         } else {
  //                       //           setState(() {
  //                       //             selectData
  //                       //                 .removeWhere((element) => element == e);
  //                       //           });
  //                       //         }
  //                       //         print(selectData);
  //                       //       });
  //                       // }).toList(),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: Text(
  //                   'Xác nhận',
  //                   style: TextStyle(color: AppTheme.colors.blue),
  //                 ),
  //                 onPressed: () {
  //                   // processOrderBloc.add(UpdateSelectCrewEvent(
  //                   //     crewId: crewId,
  //                   //     selectCrew: selectCrew,
  //                   //     orderId: orderId));
  //                   // Do something like updating SharedPreferences or User Settings etc.
  //                   crewBloc.add(UpdateCrewToListEvent(
  //                       id: widget.orderId, crewId: selectCrew));
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ],
  //           );
  //         });
  //       });
  // }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }
}
