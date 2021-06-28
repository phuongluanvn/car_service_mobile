import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
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
  bool _visible = false;

  String selectItem;
  String holder = '';
  String _selection = '';
  @override
  void initState() {
    super.initState();
    setState(() {
      _selection = widget.staffId.toString();
      print('staff =' + _selection);
    });
    BlocProvider.of<AssignOrderBloc>(context)
        .add(DoAssignOrderDetailEvent(email: widget.userId));
    BlocProvider.of<StaffBloc>(context).add(DoListStaffEvent());
  }

  void getDropDownItem(String ids) {
    // setState(() {
    //   holder = selectItem;
    // });
    if (ids != null) {
      print('null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(
                                'A:',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              child: Text(
                                state.assignDetail[0].taiKhoan,
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
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(
                                'B:',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              child: Text(
                                state.assignDetail[0].hoTen,
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
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(
                                'C:',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              child: Text(
                                state.assignDetail[0].email,
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
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(
                                'D:',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              child: Text(
                                state.assignDetail[0].soDt,
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
                                  setState(() {});
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
                          child: BlocBuilder<StaffBloc, StaffState>(
                              // ignore: missing_return
                              builder: (builder, staffState) {
                            if (staffState is StaffInitState) {
                              return CircularProgressIndicator();
                            } else if (staffState is StaffLoadingState) {
                              return CircularProgressIndicator();
                            } else if (staffState is StaffListSuccessState) {
                              if (staffState.staffList != null &&
                                  staffState.staffList.isNotEmpty)
                                return Column(
                                  children: [
                                    DropdownButton<String>(
                                      hint: Text(_selection.toString()),
                                      items:
                                          staffState.staffList.map((valueItem) {
                                        return DropdownMenuItem<String>(
                                          child: Text(valueItem.toString()),
                                          value: valueItem.toString(),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          this.selectItem = newValue;
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
                            } else if (staffState is StaffListErrorState) {
                              return ErrorWidget(staffState.message.toString());
                            }
                            ;
                          }),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.blue),
                            child: Text('Start Process',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {},
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
