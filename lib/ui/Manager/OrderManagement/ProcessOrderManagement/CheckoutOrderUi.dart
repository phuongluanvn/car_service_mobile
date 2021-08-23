import 'package:car_service/blocs/manager/Accessories/accessory_bloc.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_state.dart';
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
import 'package:money_formatter/money_formatter.dart';

class CheckoutOrderUi extends StatefulWidget {
  final String orderId;
  List selectService;
  CheckoutOrderUi({@required this.orderId, this.selectService});

  @override
  _CheckoutOrderUiState createState() => _CheckoutOrderUiState();
}

class _CheckoutOrderUiState extends State<CheckoutOrderUi> {
  final String processingStatus = 'Đợi thanh toán';
  final String workingStatus = 'Đang hoạt động';

  UpdateStatusOrderBloc updateStatusBloc;
  bool _visible = false;
  bool checkedValue = false;
  String selectItem;
  String holder = '';
  int total = 0;
  @override
  void initState() {
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    super.initState();
    BlocProvider.of<AccessoryBloc>(context).add(DoListAccessories());
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
        title: Text('Thanh toán'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: BlocBuilder<ProcessOrderBloc, ProcessOrderState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state.detailStatus == ProcessDetailStatus.init) {
                  return CircularProgressIndicator();
                } else if (state.detailStatus == ProcessDetailStatus.loading) {
                  return CircularProgressIndicator();
                } else if (state.detailStatus == ProcessDetailStatus.success) {
                  return Column(
                    children: [
                      Text(
                        'Thông tin hóa đơn',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children:
                            state.processDetail[0].orderDetails.map((service) {
                          // countPrice += service.price;
                          total = state.processDetail[0].orderDetails
                              .fold(0, (sum, element) => sum + element.price);
                          return BlocBuilder<AccessoryBloc, AccessoryState>(
                              // ignore: missing_return
                              builder: (context, accState) {
                            if (accState.status == ListAccessoryStatus.init) {
                              return CircularProgressIndicator();
                            } else if (accState.status ==
                                ListAccessoryStatus.loading) {
                              return CircularProgressIndicator();
                            } else if (accState.status ==
                                ListAccessoryStatus.success) {
                              return ExpansionTile(
                                title: Text(service.name),
                                // trailing: Text(_convertMoney(
                                //     service.price.toDouble() != 0
                                //         ? service.price.toDouble()
                                //         : 0)),
                                children: [
                                  accState.accessoryList.indexWhere((element) =>
                                              element.id ==
                                              service.accessoryId) >=
                                          0
                                      ? ListTile(
                                          title: Text(accState.accessoryList
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  service.accessoryId)
                                              .name),
                                          trailing: Image.network(accState
                                              .accessoryList
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  service.accessoryId)
                                              .imageUrl),
                                        )
                                      : Text('Hiện tại không có phụ tùng'),
                                ],
                              );
                            }
                            ;
                          });
                        }).toList(),
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                          title: Text(
                            'Tổng cộng: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900),
                          ),
                          trailing: Text(
                            _convertMoney(
                                total.toDouble() != 0 ? total.toDouble() : 0),
                          )),
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
                                child: Text('Hoàn tất dịch vụ',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  updateStatusBloc.add(
                                      UpdateStatusStartAndWorkingButtonPressed(
                                          id: state.processDetail[0].id,
                                          listData: state
                                              .processDetail[0].crew.members,
                                          status: processingStatus,
                                          workingStatus: workingStatus));
                                  // updateStatusBloc.add(
                                  //     UpdateStatusButtonPressed(
                                  //         id: state.processDetail[0].id,
                                  //         status: processingStatus));
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ManagerMain()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state.detailStatus == ProcessDetailStatus.error) {
                  return ErrorWidget(state.message.toString());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  _convertMoney(double money) {
    MoneyFormatter fmf = new MoneyFormatter(
        amount: money,
        settings: MoneyFormatterSettings(
          symbol: 'VND',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 0,
          // compactFormatType: CompactFormatType.sort
        ));
    print(fmf.output.symbolOnRight);
    return fmf.output.symbolOnRight.toString();
  }
}
