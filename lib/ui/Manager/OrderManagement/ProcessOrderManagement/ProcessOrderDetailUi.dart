import 'dart:convert';
import 'package:car_service/blocs/manager/CrewManagement/crew_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_event.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_state.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/assign_order_cubit/assignorder_cubit.dart';
import 'package:car_service/blocs/manager/assign_order_cubit/assignorder_cubit_state.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_state.dart';
import 'package:car_service/blocs/manager/processOrder/updateFinishTask_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/updateFinishTask_event.dart';
import 'package:car_service/blocs/manager/processOrder/updateFinishTask_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/ProcessOrderManagement/CheckoutOrderUi.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProcessOrderDetailUi extends StatefulWidget {
  final String orderId;
  ProcessOrderDetailUi({@required this.orderId});

  @override
  _ProcessOrderDetailUiState createState() => _ProcessOrderDetailUiState();
}

class _ProcessOrderDetailUiState extends State<ProcessOrderDetailUi> {
  bool _visible = false;
  List TestList = [1, 2, 3];
  String selectItem;
  bool checkedValue = false;
  String holder = '';
  List<StaffModel> selectStaff = [];
  String _selectedValueDetail;
  String _valueSelectedPackageService;
  String _orderId;
  String _note;
  List<StaffModel> selectData = [];
  List<StaffModel> selectCrew = [];
  List selectService = [];
  List<String> selectCrewName = [];
  ProcessOrderBloc processOrderBloc;
  UpdateFinishTaskBloc updateFinishBloc;
  AssignOrderBloc _assignOrderBloc;
  AssignorderCubit assignCubit = AssignorderCubit();
  String _crewId = '';
  CrewBloc crewBloc;
  @override
  void initState() {
    super.initState();
    _orderId = widget.orderId;
    // assignCubit = BlocProvider.of<AssignorderCubit>(context);
    updateFinishBloc = BlocProvider.of<UpdateFinishTaskBloc>(context);
    processOrderBloc = BlocProvider.of<ProcessOrderBloc>(context);
    _assignOrderBloc = BlocProvider.of<AssignOrderBloc>(context);
    crewBloc = BlocProvider.of<CrewBloc>(context);
    BlocProvider.of<UpdateFinishTaskBloc>(context)
        .add(DoTaskrDetailEvent(id: widget.orderId));
    BlocProvider.of<ProcessOrderBloc>(context)
        .add(DoProcessOrderDetailEvent(email: widget.orderId));
    BlocProvider.of<ManageStaffBloc>(context).add(DoListStaffEvent());
    BlocProvider.of<AssignOrderBloc>(context)
        .add(DoAssignOrderDetailEvent(id: widget.orderId));
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
        title: Text('Quản lý đơn hàng'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<ProcessOrderBloc, ProcessOrderState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state.detailStatus == ProcessDetailStatus.init) {
                return CircularProgressIndicator();
              } else if (state.detailStatus == ProcessDetailStatus.loading) {
                return CircularProgressIndicator();
              } else if (state.detailStatus == ProcessDetailStatus.success) {
                if (state.processDetail != null &&
                    state.processDetail.isNotEmpty) {
                  // selectCrew = state.processDetail[0].crew.members;
                  print(selectCrew);
                  return Padding(
                    padding: EdgeInsets.all(12.0),
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      'Thời gian bắt đầu sửa chữa:',
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text(
                                      'Status:',
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
                                              state.processDetail[0].vehicle
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
                                              state.processDetail[0].vehicle
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
                                              state.processDetail[0].vehicle
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
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black87,
                          height: 20,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        BlocListener<UpdateFinishTaskBloc,
                            UpdateFinishTaskState>(
                          listener: (context, sstate) {
                            // if (sstate.updateFinishIdStatus ==
                            //     UpdateFinishIdStatus.loading) {
                            //   return CircularProgressIndicator();
                            // } else
                            if (sstate.updateFinishIdStatus ==
                                // ignore: unrelated_type_equality_checks
                                UpdateFinishIdStatus.success) {
                              _assignOrderBloc.add(
                                  DoAssignOrderDetailEvent(id: widget.orderId));
                            }
                          },
                          child: BlocBuilder<AssignOrderBloc, AssignOrderState>(
                            // ignore: missing_return
                            builder: (context, pstate) {
                              if (pstate.detailStatus ==
                                  AssignDetailStatus.init) {
                                return CircularProgressIndicator();
                              } else if (pstate.detailStatus ==
                                  AssignDetailStatus.loading) {
                                return CircularProgressIndicator();
                              } else if (pstate.detailStatus ==
                                  // ignore: unrelated_type_equality_checks
                                  AssignDetailStatus.success) {
                                return Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Cập nhật quy trình xử lí',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                        child: Column(
                                          children: [
                                            for (int j = 0;
                                                j <
                                                    pstate.assignDetail[0]
                                                        .packageLists.length;
                                                j++)
                                              for (int k = 0;
                                                  k <
                                                      pstate
                                                          .assignDetail[0]
                                                          .packageLists[j]
                                                          .orderDetails
                                                          .length;
                                                  k++)
                                                CheckboxListTile(
                                                  value: pstate
                                                          .assignDetail[0]
                                                          .packageLists[j]
                                                          .orderDetails[k]
                                                          .isFinished ==
                                                      true,
                                                  onChanged: (bool selected) {
                                                    if (selected == true) {
                                                      setState(() {
                                                        updateFinishBloc.add(
                                                            UpdateFinishedTaskOrderEvent(
                                                                orderId: widget
                                                                    .orderId,
                                                                selectedTaskId: pstate
                                                                    .assignDetail[
                                                                        0]
                                                                    .packageLists[
                                                                        j]
                                                                    .orderDetails[
                                                                        k]
                                                                    .id,
                                                                selected:
                                                                    true));
                                                      });
                                                    } else {
                                                      setState(() {
                                                        updateFinishBloc.add(
                                                            UpdateFinishedTaskOrderEvent(
                                                                orderId: widget
                                                                    .orderId,
                                                                selectedTaskId: pstate
                                                                    .assignDetail[
                                                                        0]
                                                                    .packageLists[
                                                                        j]
                                                                    .orderDetails[
                                                                        k]
                                                                    .id,
                                                                selected:
                                                                    false));
                                                        // selectService.remove(state
                                                        //     .processDetail[0]
                                                        //     .orderDetails[index]);
                                                      });
                                                    }
                                                  },
                                                  title: Text(pstate
                                                      .assignDetail[0]
                                                      .packageLists[j]
                                                      .orderDetails[k]
                                                      .name),
                                                ),
                                            for (int i = 0;
                                                i <
                                                    pstate.assignDetail[0]
                                                        .orderDetails.length;
                                                i++)
                                              CheckboxListTile(
                                                value: pstate
                                                        .assignDetail[0]
                                                        .orderDetails[i]
                                                        .isFinished ==
                                                    true,
                                                onChanged: (bool selected) {
                                                  if (selected == true) {
                                                    setState(() {
                                                      updateFinishBloc.add(
                                                          UpdateFinishedTaskOrderEvent(
                                                              orderId: widget
                                                                  .orderId,
                                                              selectedTaskId: pstate
                                                                  .assignDetail[
                                                                      0]
                                                                  .orderDetails[
                                                                      i]
                                                                  .id,
                                                              selected: true));
                                                      // selectService.add(state
                                                      //     .processDetail[0]
                                                      //     .orderDetails[index]);
                                                      // BlocProvider.of<
                                                      //             ProcessorderCubit>(
                                                      //         context)
                                                      //     .addItem(stafflist[index]);
                                                    });
                                                  } else {
                                                    setState(() {
                                                      updateFinishBloc.add(
                                                          UpdateFinishedTaskOrderEvent(
                                                              orderId: widget
                                                                  .orderId,
                                                              selectedTaskId: pstate
                                                                  .assignDetail[
                                                                      0]
                                                                  .orderDetails[
                                                                      i]
                                                                  .id,
                                                              selected: false));
                                                      // selectService.remove(state
                                                      //     .processDetail[0]
                                                      //     .orderDetails[index]);
                                                    });
                                                  }
                                                },
                                                title: Text(pstate
                                                    .assignDetail[0]
                                                    .orderDetails[i]
                                                    .name),
                                              ),
                                          ],
                                        ),
                                      ),

                                      // ElevatedButton(
                                      //     onPressed: () {
                                      //       // processOrderBloc.add(
                                      //       //     UpdateFinishedTaskOrderEvent(
                                      //       //         selectedTaskId: selectService));

                                      //       // print(selectService[0].name);
                                      //     },
                                      //     child: Text('Cập nhật')),
                                    ],
                                  ),
                                );
                              } else if (pstate.detailStatus ==
                                  AssignDetailStatus.error) {
                                return ErrorWidget(pstate.message.toString());
                              }
                            },
                          ),
                        ),
                        Container(height: 16),
                        Divider(
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
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: BlocBuilder<CrewBloc, CrewState>(
                                    // ignore: missing_return
                                    builder: (builder, staffState) {
                                  if (staffState.status ==
                                      ListCrewStatus.init) {
                                    return CircularProgressIndicator();
                                  } else if (staffState.status ==
                                      ListCrewStatus.loading) {
                                    return CircularProgressIndicator();
                                  } else if (staffState.status ==
                                      ListCrewStatus.success) {
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
                                                'Tổ đội phụ trách',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                      ListTile(
                                                        leading: Image.asset(
                                                            'lib/images/logo_blue.png'),
                                                        title: Text(state
                                                            .processDetail[0]
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        AppTheme.colors.blue,
                                                  ),
                                                  child: Text('Chọn tổ đội'),
                                                  onPressed: () => setState(() {
                                                        showInformationDialog(
                                                                context,
                                                                staffState
                                                                    .crewList,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: AppTheme.colors.blue),
                                      child: Text('Hoàn tất xử lí',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (_) => CheckoutOrderUi(
                                                      orderId: state
                                                          .processDetail[0].id,
                                                      selectService:
                                                          selectService,
                                                    )));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else
                  return Center(child: Text('Empty'));
              } else if (state.detailStatus == ProcessStatus.error) {
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

  Future showInformationDialog(
      BuildContext context, List<CrewModel> crewlist, String orderId) async {
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
                                  return CircularProgressIndicator();
                                } else if (stateOfPackage.status ==
                                    ListCrewStatus.loading) {
                                  return CircularProgressIndicator();
                                } else if (stateOfPackage.status ==
                                    ListCrewStatus.success) {
                                  if (stateOfPackage.crewList != null &&
                                      stateOfPackage.crewList.isNotEmpty)
                                    return ListView.builder(
                                      itemCount: stateOfPackage.crewList.length,
                                      shrinkWrap: true,
                                      // ignore: missing_return
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            title: Text(
                                              stateOfPackage.crewList[index]
                                                  .leaderFullname,
                                              style: TextStyle(
                                                  color: (_crewId ==
                                                              stateOfPackage
                                                                  .crewList[
                                                                      index]
                                                                  .id ||
                                                          _crewId != '')
                                                      ? AppTheme.colors.deepBlue
                                                      : Colors.grey),
                                            ),
                                            subtitle: Text(stateOfPackage
                                                .crewList[index]
                                                .leaderFullname),
                                            onTap: () {
                                              setState(() {
                                                _crewId = stateOfPackage
                                                    .crewList[index].id;
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
                  },
                ),
              ],
            );
          });
        });
  }
}
