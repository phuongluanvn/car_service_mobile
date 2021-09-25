import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_bloc.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CustomerMainUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/tabbar.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;

class ConfirmOrderDetailUi extends StatefulWidget {
  final String orderId;
  ConfirmOrderDetailUi({@required this.orderId});

  @override
  _ConfirmOrderDetailUiState createState() => _ConfirmOrderDetailUiState();
}

class _ConfirmOrderDetailUiState extends State<ConfirmOrderDetailUi> {
  UpdateStatusOrderBloc updateStatusBloc;
  bool _visibleByDenied = false;
  bool textButton = true;
  String reasonReject;
  num total = cusConstants.TOTAL_PRICE;
  num _totalPriceAll = cusConstants.TOTAL_PRICE;

  @override
  void initState() {
    super.initState();
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    BlocProvider.of<CustomerOrderBloc>(context)
        .add(DoOrderDetailEvent(id: widget.orderId));
    BlocProvider.of<AccessoryBloc>(context).add(DoListAccessories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
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
                          state.orderDetail[0].note != null
                              ? state.orderDetail[0].checkinTime
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Visibility(
                          visible: _visibleByDenied,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              onChanged: (noteValue) {
                                setState(() {
                                  reasonReject = noteValue;
                                });
                              },
                              maxLines: 3,
                              decoration: InputDecoration.collapsed(
                                  hintText: cusConstants.REASON_REJECTED_LABLE),
                            ),
                          ),
                        ),
                      ),
                      BlocListener<UpdateStatusOrderBloc,
                          UpdateStatusOrderState>(
                        listener: (builder, statusState) {
                          if (statusState.status ==
                              UpdateStatus.updateConfirmFromCustomerSuccess) {
                            showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    title: Text(
                                      cusConstants.NOTI_TITLE,
                                      style:
                                          TextStyle(color: Colors.greenAccent),
                                    ),
                                    content: Text(cusConstants
                                        .CONFIRM_ORDER_SUCCESS_MESSAGE),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            // Close the dialog
                                            Navigator.of(context).pop();
                                            Navigator.pop(context);
                                            context
                                                .read<CustomerOrderBloc>()
                                                .add(DoOrderListEvent());
                                          },
                                          child: Text(
                                              cusConstants.BUTTON_OK_TITLE))
                                    ],
                                  );
                                });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                child: _visibleByDenied == false
                                    ? Text(cusConstants.BUTTON_DENY_TITLE,
                                        style: TextStyle(color: Colors.white))
                                    : Text(cusConstants.BUTTON_CANCEL_TITLE,
                                        style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  setState(() {
                                    _visibleByDenied = !_visibleByDenied;
                                    textButton = !textButton;
                                  });
                                  print(reasonReject);
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppTheme.colors.blue),
                                child: Text(
                                    textButton
                                        ? cusConstants.BUTTON_OK_TITLE
                                        : cusConstants.BUTTON_ACCEPT_TITLE,
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  if (textButton == false &&
                                      reasonReject != null) {
                                    updateStatusBloc.add(
                                        UpdateConfirmFromCustomerButtonPressed(
                                            id: state.orderDetail[0].id,
                                            isAccept: false,
                                            customerNote: reasonReject));
                                  } else {
                                    updateStatusBloc.add(
                                        UpdateConfirmFromCustomerButtonPressed(
                                            id: state.orderDetail[0].id,
                                            isAccept: true,
                                            customerNote: null));
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              else
                return Center(child: Text(cusConstants.NOT_FOUND_DETAIL_ORDER));
            } else if (state.detailStatus == CustomerOrderDetailStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }

  Widget cardInforCar(String manuName, String modelName, String licensePlace) {
    return Card(
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
    );
  }

  Widget cardInforOrder(
      String stautus, String bookingTime, String checkinTime, String note) {
    return Card(
      child: Column(
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
            title: Text(cusConstants.ORDER_INFO_CARD_STATUS),
            trailing: Text(stautus),
          ),
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
            trailing: Text(note),
          ),
        ],
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
                                      title: Text(
                                          cusConstants.ADDED_SERVICE_LABLE),
                                      children: orderDetails.map((service) {
                                        countPrice += service.price;
                                        _totalPriceAll = countPrice;
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
                                  children:
                                      e.orderDetails.map<Widget>((service) {
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
                                      title: Text(
                                          cusConstants.ADDED_SERVICE_LABLE),
                                      children: orderDetails.map((service) {
                                        countPrice += service.price;
                                        _totalPriceAll = countPrice;

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
                      trailing: Text(_convertMoney(totalPrice.toDouble())),
                    ),
                  ],
                );
              }
            })));
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
