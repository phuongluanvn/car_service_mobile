import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignOrderDetailUi extends StatefulWidget {
  final String emailId;
  AssignOrderDetailUi({@required this.emailId});

  @override
  _AssignOrderDetailUiState createState() => _AssignOrderDetailUiState();
}

class _AssignOrderDetailUiState extends State<AssignOrderDetailUi> {
  bool _visible = false;

  String selectItem;
  @override
  void initState() {
    super.initState();

    BlocProvider.of<AssignOrderBloc>(context)
        .add(DoAssignOrderDetailEvent(email: widget.emailId));
    BlocProvider.of<StaffBloc>(context).add(DoListStaffEvent());
  }

  @override
  Widget build(BuildContext context) {
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue),
                              child: Text('Check-in',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                setState(() {
                                  _visible = !_visible;
                                });
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
                          child: BlocBuilder<StaffBloc, StaffState>(
                              // ignore: missing_return
                              builder: (builder, state) {
                            if (state is StaffInitState) {
                              return CircularProgressIndicator();
                            } else if (state is StaffLoadingState) {
                              return CircularProgressIndicator();
                            } else if (state is StaffListSuccessState) {
                              return Column(
                                children: [
                                  DropdownButton<String>(
                                    items: state.staffList.map((valueItem) {
                                      return DropdownMenuItem<String>(
                                        child: Text(valueItem.hoTen),
                                        value: valueItem.hoTen,
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        this.selectItem = newValue;
                                      });
                                    },
                                    value: selectItem,
                                  ),
                                ],
                              );
                            } else if (state is StaffListErrorState) {
                              return ErrorWidget(state.message.toString());
                            }
                            ;
                          }),
                        ),
                      )
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
    );
  }
}
