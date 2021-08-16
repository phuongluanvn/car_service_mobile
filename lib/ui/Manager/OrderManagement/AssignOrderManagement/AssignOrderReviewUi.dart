import 'dart:convert';
import 'dart:io';

import 'package:car_service/blocs/manager/CrewManagement/crew_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_event.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';

import 'package:car_service/blocs/manager/assign_order_cubit/assignorder_cubit.dart';
import 'package:car_service/blocs/manager/assign_order_cubit/assignorder_cubit_state.dart';
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
import 'package:car_service/utils/model/StaffModel.dart';
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
  final String processingStatus = 'Đang tiến hành';
  final String workingStatus = 'working';
  UpdateStatusOrderBloc updateStatusBloc;
  bool _visible = false;
  List<StaffModel> _selection = [];
  List<StaffModel> selectData = [];
  StaffModel _staffModel;
  bool _selectStaff = false;
  // AssignorderCubit assignCubit;
  CrewBloc crewBloc;
  List selectCrewName = [];
  List<StaffModel> selectCrew = [];
  ProcessOrderBloc processOrderBloc;
  @override
  void initState() {
    super.initState();
    processOrderBloc = BlocProvider.of<ProcessOrderBloc>(context);
    // assignCubit = BlocProvider.of<AssignorderCubit>(context);
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    crewBloc = BlocProvider.of<CrewBloc>(context);
    BlocProvider.of<AssignOrderBloc>(context)
        .add(DoAssignOrderDetailEvent(id: widget.userId));
    BlocProvider.of<ManageStaffBloc>(context).add(DoListStaffEvent());
  }

  @override
  Widget build(BuildContext context) {
    final String sendConfirmStatus = 'Đợi phản hồi';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Quản lý đơn hàng'),
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
                    state.assignDetail.isNotEmpty) {
                  selectCrew = state.assignDetail[0].crew.members;
                  if (state.assignDetail[0].status == 'Đợi phản hồi') {
                    _visible = true;
                  } else {
                    _visible = false;
                  }
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      'Thời gian nhận xe:',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      state.assignDetail[0].bookingTime,
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
                                        child: Text('Dịch vụ',
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
                                                .updateStatusCheckinSuccess) {
                                          setState(() {
                                            _visible = true;
                                          });
                                        } else if (statusState.status ==
                                            UpdateStatus
                                                .updateStatusCheckingSuccess) {}
                                      },
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.065,
                                        child: _visible
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppTheme.colors.white,
                                                    border: Border.all(
                                                        width: 2,
                                                        color: AppTheme
                                                            .colors.deepBlue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                  child: Text(
                                                    'Đợi phản hồi',
                                                    style: TextStyle(
                                                        color: AppTheme
                                                            .colors.deepBlue),
                                                  ),
                                                ))
                                            : ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        AppTheme.colors.blue),
                                                child: Text('Gửi xác nhận',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                onPressed: () {
                                                  updateStatusBloc.add(
                                                      UpdateStatusSendConfirmButtonPressed(
                                                          id: state
                                                              .assignDetail[0]
                                                              .id,
                                                          status:
                                                              sendConfirmStatus));
                                                },
                                              ),
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
                                child: BlocBuilder<ManageStaffBloc,
                                        ManageStaffState>(
                                    // ignore: missing_return
                                    builder: (builder, staffState) {
                                  if (staffState.status == StaffStatus.init) {
                                    return CircularProgressIndicator();
                                  } else if (staffState.status ==
                                      StaffStatus.loading) {
                                    return CircularProgressIndicator();
                                  } else if (staffState.status ==
                                      StaffStatus.staffListsuccess) {
                                    return Column(
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
                                              border: Border.all(
                                                  color: Colors.black26),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Nhân viên phụ trách',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              // BlocBuilder<AssignorderCubit,
                                              //     AssignorderCubitState>(
                                              //   builder: (context,
                                              //       assignStaffstate) {
                                              //     if (assignStaffstate.status ==
                                              //         AssignCubitStatus
                                              //             .loadingSuccess)
                                              //       return Column(
                                              //         children: [
                                              //           for (int i = 0;
                                              //               i <
                                              //                   assignStaffstate
                                              //                       .listStaff
                                              //                       .length;
                                              //               i++)
                                              //             Card(
                                              //               child: Column(
                                              //                   children: [
                                              //                     ListTile(
                                              //                       leading: Image
                                              //                           .asset(
                                              //                               'lib/images/logo_blue.png'),
                                              //                       title: Text(assignStaffstate
                                              //                           .listStaff[
                                              //                               i]
                                              //                           .fullname),
                                              //                     ),
                                              //                   ]),
                                              //             ),
                                              //           SizedBox(
                                              //             height: 15,
                                              //           ),
                                              //           ElevatedButton(
                                              //               style:
                                              //                   ElevatedButton
                                              //                       .styleFrom(
                                              //                 primary: AppTheme
                                              //                     .colors.blue,
                                              //               ),
                                              //               child: Text(
                                              //                   'Chọn nhân viên'),
                                              //               onPressed: () =>
                                              //                   setState(() {
                                              //                     showInformationDialog(
                                              //                       context,
                                              //                       staffState
                                              //                           .staffList,
                                              //                     );
                                              //                   })),
                                              //           SizedBox(
                                              //             height: 20,
                                              //           ),

                                              //         ],
                                              //       );
                                              //     else
                                              //       return SizedBox();
                                              //     // ListView.builder(
                                              //     //   shrinkWrap: true,
                                              //     //   itemCount: state.length,
                                              //     //   itemBuilder:
                                              //     //       (context, index) {
                                              //     //     return Card(
                                              //     //       child: Column(
                                              //     //           children: [
                                              //     //             ListTile(
                                              //     //               leading: Image
                                              //     //                   .asset(
                                              //     //                       'lib/images/logo_blue.png'),
                                              //     //               title: Text(
                                              //     //                   state[index]
                                              //     //                       .fullname),
                                              //     //             ),
                                              //     //           ]),
                                              //     //     );
                                              //     //   },
                                              //     // );
                                              //   },
                                              // ),
                                              // // ),

                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: state.assignDetail[0]
                                                    .crew.members.length,
                                                itemBuilder: (context, index) {
                                                  // state.processDetail[0].crew
                                                  //     .members
                                                  //     .map((e) => selectCrewName
                                                  //         .add(e.fullname))
                                                  //     .toList();
                                                  // print(selectCrewName);
                                                  // for (int i = 0;
                                                  //     i <=
                                                  //         state
                                                  //             .processDetail[0]
                                                  //             .crew
                                                  //             .members
                                                  //             .length;
                                                  //     i++) {
                                                  //   selectCrewName.add(state
                                                  //       .processDetail[0]
                                                  //       .crew
                                                  //       .members[i]
                                                  //       .username);
                                                  //   print('selectCrewName is');
                                                  //   print(state.processDetail[0]
                                                  //       .crew.members.length);
                                                  // }
                                                  return Card(
                                                    child: Column(children: [
                                                      ListTile(
                                                        leading: Image.asset(
                                                            'lib/images/logo_blue.png'),
                                                        title: Text(state
                                                            .assignDetail[0]
                                                            .crew
                                                            .members[index]
                                                            .fullname),
                                                      ),
                                                    ]),
                                                  );
                                                },
                                              ),
                                              // ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        AppTheme.colors.blue,
                                                  ),
                                                  child: Text('Chọn nhân viên'),
                                                  onPressed: () => setState(() {
                                                        showInformationDialog(
                                                                context,
                                                                staffState
                                                                    .staffList,
                                                                state
                                                                    .assignDetail[
                                                                        0]
                                                                    .crew
                                                                    .id,
                                                                widget.userId)
                                                            .then((value) {
                                                          setState(() {
                                                            selectData = value;
                                                            _visible = true;
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
                                                  listener:
                                                      (builder, statusState) {
                                                    if (statusState.status ==
                                                        UpdateStatus
                                                            .updateStatusStartSuccess) {}
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.45,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary:
                                                                      AppTheme
                                                                          .colors
                                                                          .blue),
                                                          child: Text('Bắt đầu',
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
                                                            updateStatusBloc.add(UpdateStatusStartAndWorkingButtonPressed(
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
                                    );
                                  } else if (staffState.status ==
                                      StaffStatus.error) {
                                    return ErrorWidget(
                                        state.message.toString());
                                  }
                                  ;
                                }),
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

  Future showInformationDialog(BuildContext context, List<StaffModel> stafflist,
      String crewId, String orderId) async {
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
                            'Chọn nhân viên',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child:
                                // BlocBuilder<AssignorderCubit,
                                //     AssignorderCubitState>(
                                //   builder: (context, state) {
                                //     return
                                ListView.builder(
                                    itemCount: stafflist.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CheckboxListTile(
                                        value: selectCrew.indexWhere(
                                                (element) =>
                                                    element.username ==
                                                    stafflist[index]
                                                        .username) >=
                                            0,
                                        onChanged: (bool selected) {
                                          if (selected) {
                                            setState(() {
                                              // BlocProvider.of<AssignorderCubit>(
                                              //         context)
                                              //     .addItem(stafflist[index]);
                                              selectCrew.add(stafflist[index]);
                                              // selectCrewName.add(
                                              //     stafflist[index].username);
                                              // print('select crew name 1');
                                              // print(selectCrew);
                                            });
                                          } else {
                                            setState(() {
                                              // BlocProvider.of<AssignorderCubit>(
                                              //         context)
                                              //     .removeItem(stafflist[index]);
                                              // selectCrewName.remove(
                                              //     stafflist[index].username);
                                              selectCrew
                                                  .remove(stafflist[index]);
                                              print('select crew name 2');
                                              print(selectCrew);
                                            });
                                          }
                                        },
                                        title: Text(stafflist[index].fullname),
                                      );
                                    }),
                            //   },
                            // ),
                          ),
                        ],
                        //  stafflist.map((e) {
                        //   return CheckboxListTile(
                        //       activeColor: AppTheme.colors.deepBlue,

                        //       //font change
                        //       title: new Text(
                        //         e.username,
                        //       ),
                        //       value: selectData.indexOf(e) < 0 ? false : true,
                        //       secondary: Container(
                        //         height: 50,
                        //         width: 50,
                        //         child: Image.asset(
                        //           'lib/images/logo_blue.png',
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //       onChanged: (bool val) {
                        //         if (selectData.indexOf(e) < 0) {
                        //           setState(() {
                        //             selectData.add(e);
                        //             _selectStaff = true;
                        //           });
                        //         } else {
                        //           setState(() {
                        //             selectData
                        //                 .removeWhere((element) => element == e);
                        //           });
                        //         }
                        //         print(selectData);
                        //       });
                        // }).toList(),
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
                    processOrderBloc.add(UpdateSelectCrewEvent(
                        crewId: crewId,
                        selectCrew: selectCrew,
                        orderId: orderId));
                    // Do something like updating SharedPreferences or User Settings etc.

                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
        });
  }
}
