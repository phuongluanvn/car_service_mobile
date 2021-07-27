import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/ReviewTaskUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignOrderReviewUi extends StatefulWidget {
  final String userId;
  final String staffId;
  AssignOrderReviewUi({@required this.userId, this.staffId});

  @override
  _AssignOrderReviewUiState createState() => _AssignOrderReviewUiState();
}

class _AssignOrderReviewUiState extends State<AssignOrderReviewUi> {
  final String processingStatus = 'Processing';
  UpdateStatusOrderBloc updateStatusBloc;
  bool _visible = false;
  String _selection = '';
  @override
  void initState() {
    super.initState();
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    setState(() {
      _selection = widget.staffId;
      print('staff =' + _selection);
    });
    BlocProvider.of<AssignOrderBloc>(context)
        .add(DoAssignOrderDetailEvent(id: widget.userId));
    BlocProvider.of<ManageStaffBloc>(context).add(DoListStaffEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Order Review'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                                'Checkin time:',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              child: Text(
                                state.assignDetail[0].checkinTime ?? 'empty',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue),
                                child: Text('Review Task',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ReviewTaskUi(
                                            orderId: state.assignDetail[0].id,
                                          )));
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue),
                                child: Text('Send Confirm',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  setState(() {});
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
                        Container(
                          child: BlocBuilder<ManageStaffBloc, ManageStaffState>(
                              // ignore: missing_return
                              builder: (builder, staffState) {
                            if (staffState.status == StaffStatus.init) {
                              return CircularProgressIndicator();
                            } else if (staffState.status ==
                                StaffStatus.loading) {
                              return CircularProgressIndicator();
                            } else if (staffState.status ==
                                StaffStatus.staffListsuccess) {
                              if (staffState.staffList != null &&
                                  staffState.staffList.isNotEmpty)
                                return Column(
                                  children: [
                                    DropdownButton<String>(
                                      hint: Text(_selection.toString()),
                                      items:
                                          staffState.staffList.map((valueItem) {
                                        return DropdownMenuItem<String>(
                                          child: Text(valueItem.fullname),
                                          value: valueItem.fullname,
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          this._selection = newValue;
                                        });
                                      },
                                      value: _selection,
                                    )

                                    // DropdownButton<String>(
                                    //   hint: Text('Select Staff'),
                                    //   items: TestList.map((valueItem) {
                                    //     return DropdownMenuItem<String>(
                                    //       child: Text(valueItem.toString()),
                                    //       value: valueItem.toString(),
                                    //     );
                                    //   }).toList(),
                                    //   onChanged: (newValue) {
                                    //     setState(() {
                                    //       this.selectItem = newValue;
                                    //     });
                                    //   },
                                    //   value: selectItem,
                                    // ),
                                    // DropdownButton<String>(
                                    //   hint: Text('Select Staff'),
                                    //   items: TestList.map((valueItem) {
                                    //     return DropdownMenuItem<String>(
                                    //       child: Text(valueItem.toString()),
                                    //       value: valueItem.toString(),
                                    //     );
                                    //   }).toList(),
                                    //   onChanged: (newValue) {
                                    //     setState(() {
                                    //       this.selectItem = newValue;
                                    //     });
                                    //   },
                                    //   value: selectItem,
                                    // ),
                                    // DropdownButton<String>(
                                    //   hint: Text('Select Staff'),
                                    //   items: TestList.map((valueItem) {
                                    //     return DropdownMenuItem<String>(
                                    //       child: Text(valueItem.toString()),
                                    //       value: valueItem.toString(),
                                    //     );
                                    //   }).toList(),
                                    //   onChanged: (newValue) {
                                    //     setState(() {
                                    //       this.selectItem = newValue;
                                    //     });
                                    //   },
                                    //   value: selectItem,
                                    // ),
                                  ],
                                );
                            } else if (staffState.status == StaffStatus.error) {
                              return ErrorWidget(staffState.message.toString());
                            }
                            ;
                          }),
                        ),
                        BlocListener<UpdateStatusOrderBloc,
                            UpdateStatusOrderState>(
                          // ignore: missing_return
                          listener: (builder, statusState) {
                            if (statusState.status ==
                                UpdateStatus.updateStatusStartSuccess) {
                              Navigator.pushNamed(context, '/manager');
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue),
                                  child: Text('Start Process',
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    updateStatusBloc.add(
                                        UpdateStatusStartButtonPressed(
                                            id: state.assignDetail[0].id,
                                            status: processingStatus));
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
              } else if (state.detailStatus == AssignDetailStatus.error) {
                return ErrorWidget(state.message.toString());
              }
            },
          ),
        ),
      ),
    );
  }
}
