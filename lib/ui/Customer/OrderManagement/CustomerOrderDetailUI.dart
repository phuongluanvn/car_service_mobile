import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/blocs/customer/customerOrder/FeedbackOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/FeedbackOrder_event.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_bloc.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CustomerMainUI.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;
import 'package:rating_dialog/rating_dialog.dart';

class CustomerOrderDetailUi extends StatefulWidget {
  final String orderId;
  CustomerOrderDetailUi({@required this.orderId});

  @override
  _CustomerOrderDetailUiState createState() => _CustomerOrderDetailUiState();
}

class _CustomerOrderDetailUiState extends State<CustomerOrderDetailUi> {
  Color color;
  num total = cusConstants.TOTAL_PRICE;
  bool _isShowButtonFB = true;
  FeedbackOrderBloc _buttonFeedback;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CustomerOrderBloc>(context)
        .add(DoOrderDetailEvent(id: widget.orderId));
    _buttonFeedback = BlocProvider.of<FeedbackOrderBloc>(context);
    BlocProvider.of<AccessoryBloc>(context).add(DoListAccessories());
  }

  _changeColorStt(status) {
    switch (status) {
      case cusConstants.WAITING_CONFIRM_ORDER_STATUS: //'Đợi xác nhận':
        color = Colors.orange[600];
        break;
      case cusConstants.ACCEPTED_ORDER_STATUS: // 'Đã xác nhận':
        color = Colors.green[200];
        break;
      case cusConstants.CHECKIN_ORDER_STATUS: // 'Đã nhận xe':
        color = Colors.blue[400];
        break;
      case cusConstants.CHECKING_ORDER_STATUS: // 'Kiểm tra':
        color = Colors.blue[700];
        break;
      case cusConstants.CONFIRM_ORDER_STATUS: // 'Đợi phản hồi':
        color = Colors.orange;
        break;
      case cusConstants.CONFIRMED_ORDER_STATUS: // 'Đã phản hồi':
        color = Colors.teal[300];
        break;
      case cusConstants.DENY_ORDER_STATUS: // 'Từ chối':
        color = Colors.red[600];
        break;
      case cusConstants.IN_PROCESS_ORDER_STATUS: // 'Đang tiến hành':
        color = Colors.green[300];
        break;
      case cusConstants.COMPLETED_ORDER_STATUS: // 'Hoàn thành':
        color = Colors.green[600];
        break;
      case cusConstants.CANCEL_ORDER_STATUS: // 'Hủy đơn':
        color = Colors.red;
        break;
      case cusConstants.CANCEL_BOOKING_STATUS: // 'Hủy đặt lịch':
        color = Colors.red[400];
        break;
//con nhieu case cusConstants. nua lam sau
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
        title: Text(cusConstants.ORDER_DETAIL_TITLE),
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
                          state.orderDetail[0].status == 'Đã từ chối'
                              ? state.orderDetail[0].noteCustomer
                              : state.orderDetail[0].note != null
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
                      state.orderDetail[0].crew != null
                          ? cardInforCrew(
                              state.orderDetail[0].crew.leaderFullname,
                              state.orderDetail[0].crew.members)
                          : SizedBox(),
                    ],
                  ),
                );
              else
                return Center(
                    child: Text(cusConstants.NOT_FOUND_ORDER_DETAIL_LABLE));
            } else if (state.detailStatus == CustomerOrderDetailStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }

  _showFBDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return RatingDialog(
              commentHint: cusConstants.FEEDBACK_COMMENT_HINT,
              title: cusConstants.BUTTON_FEEDBACK_LABLE,
              message: cusConstants.FEEDBACK_MESSAGE,
              image: Icon(
                Icons.star,
                size: 100,
                color: Colors.yellow,
              ),
              submitButton: cusConstants.SEND,
              onSubmitted: (res) {
                setState(() {
                  _isShowButtonFB = false;
                });
                _buttonFeedback.add(DoFeedbackButtonPressed(
                    ordeId: widget.orderId,
                    rating: res.rating,
                    description: res.comment));
              });
        });
  }

  Widget _showFeedback(int rating, String dess) {
    return Card(
      child: Column(
        children: [
          Text(
            cusConstants.FEEDBACK_CARD_TITLE,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          ListTile(
            title: Text(cusConstants.STAR_LABLE),
            trailing: IconTheme(
              data: IconThemeData(color: Colors.yellow, size: 30),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return index < rating
                      ? Icon(Icons.star)
                      : Icon(Icons.star_border);
                }),
              ),
            ),
          ),
          ListTile(
            title: Text(cusConstants.DESCRIPTION_LABLE),
            trailing: Text(dess),
          ),
        ],
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
            Text(cusConstants.INFO_CREW_LABLE,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start),
            Column(
                children: members.map((e) {
              return ListTile(
                title: Text(e.fullname),
                trailing: leaderName == e.fullname
                    ? Text(cusConstants.LERDER_LABLE)
                    : Text(cusConstants.STAFF_LABLE),
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
      num totalPrice) {
    num countPrice = cusConstants.TOTAL_PRICE;
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
                      ? Column(
                          children: [
                            ListTile(
                                title: Text(
                                    cusConstants.SERVICE_INFO_CARD_CUS_NOTE),
                                subtitle: Text(
                                  note,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )),
                            orderDetails.isEmpty
                                ? SizedBox()
                                : ExpansionTile(
                                    title:
                                        Text(cusConstants.ADDED_SERVICE_LABLE),
                                    children: orderDetails.map((service) {
                                      countPrice += service.price;
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
                        )
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
                                    title:
                                        Text(cusConstants.ADDED_SERVICE_LABLE),
                                    children: orderDetails.map((service) {
                                      countPrice += service.price;
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
                    ),
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
    return fmf.output.symbolOnRight.toString();
  }
}
