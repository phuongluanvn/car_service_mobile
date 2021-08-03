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
  List selectService;
  CheckoutOrderUi({@required this.orderId, this.selectService});

  @override
  _CheckoutOrderUiState createState() => _CheckoutOrderUiState();
}

class _CheckoutOrderUiState extends State<CheckoutOrderUi> {
  final String processingStatus = 'Hoàn thành';
  UpdateStatusOrderBloc updateStatusBloc;
  bool _visible = false;
  bool checkedValue = false;
  String selectItem;
  String holder = '';
  @override
  void initState() {
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    super.initState();

    // BlocProvider.of<ProcessOrderBloc>(context)
    //     .add(DoProcessOrderDetailEvent(email: widget.orderId));
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
        title: Text('Quản lý đơn hàng'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        child: Container(
          child: BlocBuilder<ProcessOrderBloc, ProcessOrderState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state.detailStatus == ProcessDetailStatus.init) {
                return CircularProgressIndicator();
              } else if (state.detailStatus == ProcessDetailStatus.loading) {
                return CircularProgressIndicator();
              } else if (state.detailStatus == ProcessDetailStatus.success) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  // child: SingleChildScrollView(
                  child: Center(
                    child: FittedBox(
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 1,
                            child: Column(
                              children: [
                                Center(
                                  child: ExpansionPanelList(
                                    children: widget.selectService.map(
                                      (e) {
                                        return ExpansionPanel(
                                            headerBuilder:
                                                (context, isExpanded) {
                                              return ListTile(
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(e.name),
                                                    Text('${e.price}'),
                                                  ],
                                                ),
                                              );
                                            },
                                            body: SingleChildScrollView(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                                child: TextFormField(
                                                  maxLines: null,
                                                  autofocus: false,
                                                  decoration: InputDecoration(
                                                    prefixIcon:
                                                        Icon(Icons.search),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    hintStyle: TextStyle(
                                                        color: Colors.black54),
                                                    hintText:
                                                        'Nhập tên phụ tùng',
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            20, 10, 20, 10),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                  onChanged: (event) {
                                                    // createOrderBloc.add(
                                                    //     DoCreateOrderDetailEvent(
                                                    //         id: event));
                                                    // customerCarBloc.add(
                                                    //     DoCarListWithIdEvent(
                                                    //         vehicleId: event));

                                                    // print(event);
                                                  },
                                                  textInputAction:
                                                      TextInputAction.search,
                                                ),
                                              ),
                                              //     ListView(
                                              //   shrinkWrap: true,
                                              //   children: state.processDetail
                                              //       .map((service) {
                                              //     return ListTile(
                                              //       title: Text(service
                                              //           .orderDetails[0].name),
                                              //     );
                                              //   }).toList(),
                                              // ),
                                            ));
                                      },
                                    ).toList(),
                                  ),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: AppTheme.colors.blue),
                                          child: Text('Hoàn tất',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onPressed: () {
                                            updateStatusBloc.add(
                                                UpdateStatusButtonPressed(
                                                    id: state
                                                        .processDetail[0].id,
                                                    status: processingStatus));
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ManagerMain()));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ),
                  // ),
                  // ),
                );
              } else if (state.detailStatus == ProcessDetailStatus.error) {
                return ErrorWidget(state.message.toString());
              }
            },
          ),
        ),
      ),
    );
  }
}
