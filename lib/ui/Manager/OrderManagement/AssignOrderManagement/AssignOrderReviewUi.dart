import 'dart:convert';
import 'dart:io';

import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';

import 'package:car_service/blocs/manager/cubit/assignorder_cubit.dart';
import 'package:car_service/blocs/manager/cubit/assignorder_cubit_state.dart';
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
  final String processingStatus = 'Processing';
  UpdateStatusOrderBloc updateStatusBloc;
  bool _visible = false;
  List<StaffModel> _selection = [];
  List<StaffModel> selectData = [];
  StaffModel _staffModel;
  bool _selectStaff = false;
  AssignorderCubit assignCubit;
  @override
  void initState() {
    super.initState();
    assignCubit = BlocProvider.of<AssignorderCubit>(context);
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    
    BlocProvider.of<AssignOrderBloc>(context)
        .add(DoAssignOrderDetailEvent(id: widget.userId));
    BlocProvider.of<ManageStaffBloc>(context).add(DoListStaffEvent());
  }

  @override
  Widget build(BuildContext context) {
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
                if (state.assignDetail != null && state.assignDetail.isNotEmpty)
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
                                      'Fullname:',
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
                                      'Booking Time:',
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text(
                                      'Status:',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      state.assignDetail[0].status,
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: AppTheme.colors.blue),
                                      child: Text('Review Task',
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
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: AppTheme.colors.blue),
                                      child: Text('Send Confirm',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
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
                                              BlocBuilder<AssignorderCubit,
                                                  AssignorderCubitState>(
                                                builder: (context, state) {
                                                  if (state.status ==
                                                      AssignCubitStatus
                                                          .loadingSuccess)
                                                    return Column(
                                                      children: [
                                                        for (int i = 0;
                                                            i <
                                                                state.listStaff
                                                                    .length;
                                                            i++)
                                                          Card(
                                                            child: Column(
                                                                children: [
                                                                  ListTile(
                                                                    leading: Image
                                                                        .asset(
                                                                            'lib/images/logo_blue.png'),
                                                                    title: Text(state
                                                                        .listStaff[
                                                                            i]
                                                                        .fullname),
                                                                  ),
                                                                ]),
                                                          ),
                                                      ],
                                                    );
                                                  else
                                                    return SizedBox();
                                                  // ListView.builder(
                                                  //   shrinkWrap: true,
                                                  //   itemCount: state.length,
                                                  //   itemBuilder:
                                                  //       (context, index) {
                                                  //     return Card(
                                                  //       child: Column(
                                                  //           children: [
                                                  //             ListTile(
                                                  //               leading: Image
                                                  //                   .asset(
                                                  //                       'lib/images/logo_blue.png'),
                                                  //               title: Text(
                                                  //                   state[index]
                                                  //                       .fullname),
                                                  //             ),
                                                  //           ]),
                                                  //     );
                                                  //   },
                                                  // );
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
                                                          staffState.staffList,
                                                        );
                                                      })),
                                              Container(height: 10),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          height: 15,
                                        ),
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
                                                      .updateStatusStartSuccess) {
                                                Navigator.pushNamed(
                                                    context, '/manager');
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: AppTheme
                                                                .colors.blue),
                                                    child: Text('Start Process',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    onPressed: () {
                                                      updateStatusBloc.add(
                                                          UpdateStatusStartButtonPressed(
                                                              id: state
                                                                  .assignDetail[
                                                                      0]
                                                                  .id,
                                                              status:
                                                                  processingStatus));
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
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
                else
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

  Future showInformationDialog(
      BuildContext context, List<StaffModel> stafflist) async {
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
                          Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: BlocBuilder<AssignorderCubit,
                                AssignorderCubitState>(
                              bloc: assignCubit,
                              builder: (context, state) {
                                print(state.listStaff.contains(stafflist[0]));
                                print(state.listStaff[0].fullname);
                                print(stafflist[0].fullname);
                                return ListView.builder(
                                    itemCount: stafflist.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CheckboxListTile(
                                        value: state.listStaff
                                            .contains(stafflist[index]),
                                        onChanged: (bool selected) {
                                          if (selected == true) {
                                            setState(() {
                                              BlocProvider.of<AssignorderCubit>(
                                                      context)
                                                  .addItem(stafflist[index]);
                                            });
                                          } else {
                                            setState(() {
                                              BlocProvider.of<AssignorderCubit>(
                                                      context)
                                                  .removeItem(stafflist[index]);
                                            });
                                          }
                                        },
                                        title: Text(stafflist[index].username),
                                      );
                                    });
                              },
                            ),
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
                    'Okay',
                    style: TextStyle(color: AppTheme.colors.blue),
                  ),
                  onPressed: () {
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
