import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutOrderUi extends StatefulWidget {
  final String orderId;
  CheckoutOrderUi({@required this.orderId});

  @override
  _CheckoutOrderUiState createState() => _CheckoutOrderUiState();
}

class _CheckoutOrderUiState extends State<CheckoutOrderUi> {
  final String processingStatus = 'Finish';
  UpdateStatusOrderBloc updateStatusBloc;
  bool _visible = false;
  bool checkedValue = false;
  String selectItem;
  String holder = '';
  @override
  void initState() {
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    super.initState();

    BlocProvider.of<ProcessOrderBloc>(context)
        .add(DoProcessOrderDetailEvent(email: widget.orderId));
    // BlocProvider.of<StaffBloc>(context).add(DoListStaffEvent());
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
        title: Text('Processing Orrder Detail'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: BlocBuilder<ProcessOrderBloc, ProcessOrderState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.detailStatus == ProcessDetailStatus.init) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == ProcessDetailStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == ProcessDetailStatus.success) {
              if (state.processDetail != null && state.processDetail.isNotEmpty)
                return Padding(
                  padding: const EdgeInsets.all(12.0),
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
                        rows: <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('Goi Service 1')),
                              DataCell(Text('1')),
                              DataCell(Text('1000')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('Goi Service 2')),
                              DataCell(Text('2')),
                              DataCell(Text('2000')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('Goi Service 3')),
                              DataCell(Text('3')),
                              DataCell(Text('3000')),
                            ],
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
                      SizedBox(
                        height: 20,
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
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppTheme.colors.blue),
                                child: Text('Finish',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  updateStatusBloc.add(
                                      UpdateStatusButtonPressed(
                                          id: state.processDetail[0].id,
                                          status: processingStatus));
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ManagerMain()));
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
            } else if (state.detailStatus == ProcessStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
