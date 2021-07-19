import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignOrderDetailUi extends StatefulWidget {
  final String orderId;
  AssignOrderDetailUi({@required this.orderId});

  @override
  _AssignOrderDetailUiState createState() => _AssignOrderDetailUiState();
}

class _AssignOrderDetailUiState extends State<AssignOrderDetailUi> {
  bool _visible = false;
  UpdateStatusOrderBloc updateStatusBloc;
  String selectItem;
  String holder = '';
  @override
  void initState() {
    super.initState();
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    BlocProvider.of<AssignOrderBloc>(context)
        .add(DoAssignOrderDetailEvent(id: widget.orderId));
    BlocProvider.of<ManageStaffBloc>(context).add(DoListStaffEvent());
  }

  void getDropDownItem() {
    setState(() {
      holder = selectItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String checkinStatus = 'Checkin';
    final String checkingStatus = 'Checking';
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Information'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
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
                              state.assignDetail[0].customer.fullname ??
                                  'empty',
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
                              state.assignDetail[0].customer.email ?? 'empty',
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
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              'Booking time:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            child: Text(
                              state.assignDetail[0].bookingTime ?? 'empty',
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
                              state.assignDetail[0].status ?? 'empty',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 16),
                      BlocListener<UpdateStatusOrderBloc,
                          UpdateStatusOrderState>(
                        // ignore: missing_return
                        listener: (builder, statusState) {
                          if (statusState.status ==
                              UpdateStatus.updateStatusCheckinSuccess) {
                            setState(() {
                              _visible = !_visible;
                            });
                          }else if(statusState.status ==
                              UpdateStatus.updateStatusCheckingSuccess){}
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue),
                                    child: Text('Checkin',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      updateStatusBloc.add(
                                          UpdateStatusCheckinButtonPressed(
                                              id: state.assignDetail[0].id,
                                              status: checkinStatus));
                                    },
                                  ),
                                ),
                              ],
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
                                        DropdownButton<String>(
                                          hint: Text('Select Staff'),
                                          items: staffState.staffList
                                              .map((valueItem) {
                                            return DropdownMenuItem<String>(
                                              child: Text(valueItem.fullname),
                                              value: valueItem.fullname,
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              this.selectItem = newValue;
                                            });
                                          },
                                          value: selectItem,
                                        ),
                                        ElevatedButton(
                                          child: Text('Checking'),
                                          onPressed: () {
                                            updateStatusBloc.add(
                                                UpdateStatusCheckingButtonPressed(
                                                    id: state
                                                        .assignDetail[0].id,
                                                    status: checkingStatus));
                                            // getDropDownItem,
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        AssignOrderReviewUi(
                                                            userId: state
                                                                .assignDetail[0]
                                                                .id,
                                                            staffId:
                                                                selectItem)));
                                          },
                                        ),
                                        Container(
                                          child: Text('$holder'),
                                        ),
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
                            ),
                          ],
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     SizedBox(
                      //       width: MediaQuery.of(context).size.width * 0.45,
                      //       child: ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //             primary: Colors.blue),
                      //         child: Text('Check-in',
                      //             style: TextStyle(color: Colors.white)),
                      //         onPressed: () {
                      //           setState(() {
                      //             _visible = !_visible;
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                );
              else
                return Center(child: Text('Empty'));
            } else if (state.detailStatus == AssignDetailStatus.error) {
              return Text(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
