import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_bloc.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;

class CustomerOrderDetailUi extends StatefulWidget {
  final String orderId;
  CustomerOrderDetailUi({@required this.orderId});

  @override
  _CustomerOrderDetailUiState createState() => _CustomerOrderDetailUiState();
}

class _CustomerOrderDetailUiState extends State<CustomerOrderDetailUi> {
  Color color;
  int total = cusConstants.TOTAL_PRICE;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CustomerOrderBloc>(context)
        .add(DoOrderDetailEvent(id: widget.orderId));
  }

  _changeColorStt(status) {
    switch (status) {
      case 'Đợi xác nhận':
        color = Colors.orange[600];
        break;
      case 'Đã xác nhận':
        color = Colors.green[200];
        break;
      case 'Đã nhận xe':
        color = Colors.blue[400];
        break;
      case 'Kiểm tra':
        color = Colors.blue[700];
        break;
      case 'Đợi phản hồi':
        color = Colors.orange;
        break;
      case 'Đã phản hồi':
        color = Colors.teal[300];
        break;
      case 'Từ chối':
        color = Colors.red[600];
        break;
      case 'Đang tiến hành':
        color = Colors.green[300];
        break;
      case 'Hoàn thành':
        color = Colors.green[600];
        break;
      case 'Hủy đơn':
        color = Colors.red;
        break;
      case 'Hủy đặt lịch':
        color = Colors.red[400];
        break;
//con nhieu case nua lam sau
      default:
        color = Colors.greenAccent[400];
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Chi tiết đơn hàng'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: BlocBuilder<CustomerOrderBloc, CustomerOrderState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.detailStatus == CustomerOrderDetailStatus.init) {
              return CircularProgressIndicator();
            } else if (state.detailStatus ==
                CustomerOrderDetailStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.detailStatus ==
                CustomerOrderDetailStatus.success) {
              print('????');
              print(state.orderDetail[0].orderDetails);
              if (state.orderDetail != null && state.orderDetail.isNotEmpty)
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      cardInforOrder(
                          state.orderDetail[0].status,
                          _convertDate(state.orderDetail[0].bookingTime),
                          state.orderDetail[0].checkinTime != null
                              ? _convertDate(state.orderDetail[0].checkinTime)
                              : cusConstants.CHECKIN_NOT_YET_STATUS,
                          state.orderDetail[0].note != null
                              ? state.orderDetail[0].note
                              : cusConstants.NOT_FOUND_NOTE),
                      cardInforService(
                          state.orderDetail[0].vehicle.model,
                          state.orderDetail[0].vehicle.model,
                          state.orderDetail[0].vehicle.licensePlate,
                          state.orderDetail[0].packageLists,
                          state.orderDetail[0].orderDetails == []
                              ? state.orderDetail[0].orderDetails == []
                              : state.orderDetail[0].orderDetails,
                          state.orderDetail[0].note == null ? false : true,
                          state.orderDetail[0].note != null
                              ? state.orderDetail[0].note
                              : cusConstants.NOT_FOUND_NOTE,
                          total = state.orderDetail[0].orderDetails
                              .fold(0, (sum, element) => sum + element.price)),
                      cardInforCar(
                          state.orderDetail[0].vehicle.manufacturer,
                          state.orderDetail[0].vehicle.model,
                          state.orderDetail[0].vehicle.licensePlate),
                      cardInforCrew(state.orderDetail[0].crew.leaderFullname,
                          state.orderDetail[0].crew.members)
                    ],
                  ),
                );
              else
                return Center(child: Text('Không có thông tin đơn đặt lịch'));
            } else if (state.detailStatus == CustomerOrderDetailStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }

  Widget cardInforCrew(String leaderName, List members) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            Text('Thông tin tổ đội',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start),
            Column(
                children: members.map((e) {
              return ListTile(
                title: Text(e.fullname),
                // trailing: Text(_convertMoney(service.price.toDouble())),
              );
            }).toList()),
          ],
        ),
      ),
    );
  }

  Widget cardInforCar(String manuName, String modelName, String licensePlace) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            Text(cusConstants.VEHICLE_INFO_CARD_TITLE,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start),
            ListTile(
              title: Text(cusConstants.LICENSE_PLATE_LABLE),
              trailing: Text(licensePlace),
            ),
            ListTile(
              title: Text(cusConstants.MANU_LABLE),
              trailing: Text(manuName),
            ),
            ListTile(
              title: Text(cusConstants.MODEL_LABLE),
              trailing: Text(modelName),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardInforOrder(
      String status, String bookingTime, String checkinTime, String note) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            Text(
              cusConstants.ORDER_INFO_CARD_TITLE,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
            ),
            ListTile(
                title: Text(cusConstants.ORDER_INFO_CARD_STATUS),
                trailing: Text(
                  status,
                  style: TextStyle(color: _changeColorStt(status)),
                )),
            ListTile(
              title: Text(cusConstants.ORDER_INFO_CARD_TIME_CREATE),
              trailing: Text(bookingTime),
            ),
            ListTile(
              title: Text(cusConstants.ORDER_INFO_CARD_TIME_CHECKIN),
              trailing: Text(checkinTime),
            ),
            ListTile(
              title: Text(cusConstants.ORDER_INFO_CARD_CUS_NOTE),
              subtitle: Text(
                note,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              isThreeLine: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget cardInforService(
      String servicePackageName,
      String serviceName,
      String price,
      List packages,
      List orderDetails,
      bool serviceType,
      String note,
      int totalPrice) {
    int countPrice = 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: BlocBuilder<AccessoryBloc, AccessoryState>(
          // ignore: missing_return
          builder: (context, accState) {
            if (accState.status == ListAccessoryStatus.init) {
              return CircularProgressIndicator();
            } else if (accState.status == ListAccessoryStatus.loading) {
              return CircularProgressIndicator();
            } else if (accState.status == ListAccessoryStatus.success) {
              return Column(
                children: [
                  Text(
                    cusConstants.SERVICE_INFO_CARD_TITLE,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  ListTile(
                    title: Text(cusConstants.SERVICE_INFO_CARD_TYPE_LABLE),
                    trailing: serviceType
                        ? Text(cusConstants.SERVICE_INFO_CARD_TYPE_REPAIR)
                        : Text(cusConstants.SERVICE_INFO_CARD_TYPE_MANTAIN),
                  ),
                  serviceType
                      ? ListTile(
                          title: Text(cusConstants.SERVICE_INFO_CARD_CUS_NOTE),
                          subtitle: Text(
                            note,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ))
                      : Column(
                          children: [
                            Column(
                                children: packages.map((e) {
                              // return Text(e.orderDetails);
                              return ExpansionTile(
                                title: Text(e.name),
                                children: e.orderDetails.map<Widget>((service) {
                                  countPrice += service.price;
                                  return ListTile(
                                    title: Text(service.name),
                                    trailing: Text(_convertMoney(
                                        service.price.toDouble())),
                                  );
                                }).toList(),
                              );
                            }).toList()),
                            orderDetails.isEmpty
                                ? SizedBox()
                                : ExpansionTile(
                                    title: Text('Dịch vụ bổ sung: '),
                                    children: orderDetails.map((service) {
                                      return ExpansionTile(
                                        title: Text(service.name),
                                        trailing: Text(_convertMoney(
                                            service.price.toDouble())),
                                        children: [
                                          accState.accessoryList.indexWhere(
                                                      (element) =>
                                                          element.id ==
                                                          service
                                                              .accessoryId) >=
                                                  0
                                              ? ListTile(
                                                  title: Text(accState
                                                      .accessoryList
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
                                              : Text(cusConstants
                                                  .NOT_FOUND_ACCESSORY_IN_SERVICE),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                          ],
                        ),
                  Divider(
                    color: Colors.black,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  ListTile(
                    title: Text(cusConstants.SERVICE_INFO_CARD_PRICE_TOTAL),
                    trailing: Text(
                      _convertMoney(countPrice.toDouble()),
                      // style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                    // Column(
                    //   children: [
                    //     Text(
                    //       _convertMoney(countPrice.toDouble()),
                    //       style: TextStyle(decoration: TextDecoration.lineThrough),
                    //     ),
                    //     // Text(_convertMoney(totalPrice.toDouble())),
                    //   ],
                    // )
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
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
