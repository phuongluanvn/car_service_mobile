import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewTaskUi extends StatefulWidget {
  // CheckoutOrderUi(
  //   // {@required this.emailId}
  //   );

  @override
  _ReviewTaskUiState createState() => _ReviewTaskUiState();
}

class _ReviewTaskUiState extends State<ReviewTaskUi> {
  bool _visible = false;
  bool checkedValue = false;
  String selectItem;
  String holder = '';
  List results = [];
  @override
  void initState() {
    super.initState();

    // BlocProvider.of<ProcessOrderBloc>(context)
    //     .add(DoProcessOrderDetailEvent(email: widget.emailId));
    BlocProvider.of<StaffBloc>(context).add(DoListStaffEvent());
  }

  void onChanged(bool value) {
    setState(() {
      checkedValue = value;
    });
  }

  DataRow _getDataRow(result) {
    return DataRow(
      cells: <DataCell>[
        DataCell(TextField(
          decoration: InputDecoration(hintText: '1'),
        )),
        DataCell(TextField(
          decoration: InputDecoration(hintText: '2'),
        )),
        DataCell(TextField(
          decoration: InputDecoration(hintText: '2'),
        )),
      ],
    );
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
        title: Text('Dịch vụ'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<StaffBloc, StaffState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is StaffInitState) {
                return CircularProgressIndicator();
              } else if (state is StaffLoadingState) {
                return CircularProgressIndicator();
              } else if (state is StaffListSuccessState) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Column(
                      children: [
                        DataTable(
                          columns: <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Gói dịch vụ',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Số\nlượng',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Đơn\n giá',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                          ],
                          rows: state.staffList
                              .map((data) =>
                                  // we return a DataRow every time
                                  DataRow(
                                      // List<DataCell> cells is required in every row
                                      cells: [
                                        // DataCell((data.verified)
                                        //     ? Icon(
                                        //         Icons.verified_user,
                                        //         color: Colors.green,
                                        //       )
                                        //     : Icon(Icons.cancel, color: Colors.red)),
                                        // I want to display a green color icon when user is verified and red when unverified

                                        DataCell(Text(data.hoTen)),
                                        DataCell(Text(data.taiKhoan)),
                                        DataCell(Checkbox(
                                            value: checkedValue,
                                            onChanged: (bool value) {
                                              onChanged(value);
                                            })),
                                      ]))
                              .toList(),
                        ),

                        // ElevatedButton(onPressed: ,),
                        const Divider(
                          color: Colors.black87,
                          height: 20,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
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
                                child: Text('Lưu',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ManagerMain()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is StaffListErrorState) {
                return ErrorWidget(state.message.toString());
              }
            },
          ),
        ),
      ),
    );
  }
}
