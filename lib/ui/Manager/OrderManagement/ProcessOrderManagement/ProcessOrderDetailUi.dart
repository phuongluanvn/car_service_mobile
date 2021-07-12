import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/ProcessOrderManagement/CheckoutOrderUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ProcessOrderBloc>(context)
        .add(DoProcessOrderDetailEvent(email: widget.orderId));
    BlocProvider.of<StaffBloc>(context).add(DoListStaffEvent());
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
        title: Text('Processing Orrder Detail'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                    state.processDetail.isNotEmpty)
                  return Padding(
                    padding: EdgeInsets.all(12.0),
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
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Text(
                                'B:',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              child: Text(
                                state.processDetail[0].customer.phoneNumber,
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
                                state.processDetail[0].checkinTime,
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
                                state.processDetail[0].note,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                        Container(height: 16),
                        Divider(
                          color: Colors.black87,
                          height: 20,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        DataTable(
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Tasks',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Status',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('Goi Service 1')),
                                DataCell(Checkbox(
                                    value: checkedValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        this.checkedValue = newValue;
                                      });
                                    })),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('Goi Service 2')),
                                DataCell(Checkbox(
                                    value: checkedValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        this.checkedValue = newValue;
                                      });
                                    })),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('Goi Service 3')),
                                DataCell(Checkbox(
                                    value: checkedValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        this.checkedValue = newValue;
                                      });
                                    })),
                              ],
                            ),
                          ],
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
                          child:
                              // BlocBuilder<StaffBloc, StaffState>(
                              //     // ignore: missing_return
                              //     builder: (builder, state) {
                              //   if (state is StaffInitState) {
                              //     return CircularProgressIndicator();
                              //   } else if (state is StaffLoadingState) {
                              //     return CircularProgressIndicator();
                              //   } else if (state is StaffListSuccessState) {
                              //     return
                              Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12)),
                            child: Column(
                              children: [
                                DropdownButton<String>(
                                  hint: Text('Select Staff'),
                                  items: TestList.map((valueItem) {
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
                                  value: selectItem,
                                ),
                                DropdownButton<String>(
                                  hint: Text('Select Staff'),
                                  items: TestList.map((valueItem) {
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
                                  value: selectItem,
                                ),
                                DropdownButton<String>(
                                  hint: Text('Select Staff'),
                                  items: TestList.map((valueItem) {
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
                                  value: selectItem,
                                ),
                                DropdownButton<String>(
                                  hint: Text('Select Staff'),
                                  items: TestList.map((valueItem) {
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
                                  value: selectItem,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      child: Text('Update'),
                                      onPressed: () {
                                        // getDropDownItem,
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      child: Text('Cancel'),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // } else if (state is StaffListErrorState) {
                          //   return ErrorWidget(state.message.toString());
                          // }
                          // ;
                          // }
                          // ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue),
                                child: Text('Process complete',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => CheckoutOrderUi()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                else
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
}
