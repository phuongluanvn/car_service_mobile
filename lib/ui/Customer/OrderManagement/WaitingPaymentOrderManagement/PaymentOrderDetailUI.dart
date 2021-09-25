import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_bloc.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CustomerMainUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/WaitingPaymentOrderManagement/CouponUI.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;

class PaymentOrderDetailUi extends StatefulWidget {
  final String orderId;
  PaymentOrderDetailUi({@required this.orderId});

  @override
  _PaymentOrderDetailUiState createState() => _PaymentOrderDetailUiState();
}

class _PaymentOrderDetailUiState extends State<PaymentOrderDetailUi> {
  UpdateStatusOrderBloc updateStatusBloc;
  bool _visibleByDenied = false;
  bool textButton = true;
  String reasonReject;
  num total = cusConstants.TOTAL_PRICE;
  num _totalPriceAll = cusConstants.TOTAL_PRICE;
  String _username;
  ManagerRepository _repo = ManagerRepository();

  @override
  void initState() {
    super.initState();
    _getStringFromSharedPref();
    BlocProvider.of<CustomerOrderBloc>(context)
        .add(DoOrderDetailEvent(id: widget.orderId));
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
  }

  _getStringFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('Username');

    setState(() {
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String finishStatus = 'Hoàn thành';
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text(cusConstants.ORDER_DETAIL_TITLE),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            color: AppTheme.colors.white,
            icon: Icon(Icons.card_giftcard),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CouponUI(
                            orderId: widget.orderId,
                          )));
            },
          )
        ],
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
              print('object');
              print(state.orderDetail[0].images.first.imageUrl.toString());
              if (state.orderDetail != null && state.orderDetail.isNotEmpty)
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      cardInforCar(
                          state.orderDetail[0].vehicle.manufacturer,
                          state.orderDetail[0].vehicle.model,
                          state.orderDetail[0].vehicle.licensePlate),
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
                              .fold(0, (sum, element) => sum + element.price),
                          state.orderDetail[0].id),

                      // Image.network(state.orderDetail[0].images[0].imageUrl),
                      // state.orderDetail[0].images != []
                      //     ? cardImage(state.orderDetail[0].images)
                      //     : SizedBox(),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Visibility(
                      //     visible: _visibleByDenied,
                      //     child: Container(
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: 10, vertical: 10),
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           border: Border.all(),
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: TextField(
                      //         onChanged: (noteValue) {
                      //           setState(() {
                      //             reasonReject = noteValue;
                      //           });
                      //         },
                      //         maxLines: 3,
                      //         decoration: InputDecoration.collapsed(
                      //             hintText: cusConstants.REASON_REJECTED_LABLE),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // ElevatedButton(
                      //     onPressed: () async {
                      //       var request = BraintreeDropInRequest(
                      //         tokenizationKey:
                      //             'sandbox_rzktbfv9_qgn7c8w395dwxz6h',
                      //         collectDeviceData: true,
                      //         paypalRequest: BraintreePayPalRequest(
                      //           amount: _totalPriceAll.toString(),
                      //           displayName: _username,
                      //         ),
                      //         cardEnabled: true,
                      //       );
                      //       BraintreeDropInResult result =
                      //           await BraintreeDropIn.start(request);
                      //       if (result != null) {
                      //         print(result.paymentMethodNonce.description);
                      //         print(result.paymentMethodNonce.nonce);
                      //       }
                      //     },
                      //     child: Text(cusConstants.BUTTON_PAYMENT_TITLE)),
                      BlocListener<UpdateStatusOrderBloc,
                          UpdateStatusOrderState>(
                        listener: (builder, statusState) {
                          if (statusState.status ==
                              UpdateStatus.updateStatusConfirmAcceptedSuccess) {
                            showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    title: Text(
                                      cusConstants.NOTI_TITLE,
                                      style:
                                          TextStyle(color: Colors.greenAccent),
                                    ),
                                    content:
                                        Text(cusConstants.THANKYOU_USE_SERVICE),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.pop(context);
                                            context
                                                .read<CustomerOrderBloc>()
                                                .add(DoOrderListEvent());
                                          },
                                          child: Text(cusConstants
                                              .THANKYOU_USE_SERVICE))
                                    ],
                                  );
                                });
                          }
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppTheme.colors.blue),
                              child: Text(
                                  cusConstants.COMPLETED_PAYMENT_ORDER_LABLE,
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () async {
                                double _usd = await _convertCurrency(
                                    _totalPriceAll.toDouble());
                                Dialogs.bottomMaterialDialog(
                                    msg:
                                        cusConstants.SELECT_PAYMENT_ORDER_LABLE,
                                    title: cusConstants.PAYMENT_LABLE,
                                    context: context,
                                    actions: [
                                      IconsButton(
                                        onPressed: () async {
                                          if (_usd != 0 || _usd != null) {
                                            var request =
                                                BraintreeDropInRequest(
                                              tokenizationKey:
                                                  'sandbox_rzktbfv9_qgn7c8w395dwxz6h',
                                              collectDeviceData: true,
                                              paypalRequest:
                                                  BraintreePayPalRequest(
                                                amount: _usd.toString(),
                                                displayName: _username,
                                              ),
                                              cardEnabled: true,
                                            );
                                            BraintreeDropInResult result =
                                                await BraintreeDropIn.start(
                                                    request);
                                            if (result != null) {
                                              print('lolo1');
                                              print(result
                                                  .paymentMethodNonce.nonce);
                                              print('lolo2');
                                              print(result.paymentMethodNonce
                                                  .description);
                                              print('lolo3');
                                              print(result.deviceData);

                                              var result2 =
                                                  await _repo.paypalRequest(
                                                      result.paymentMethodNonce
                                                          .nonce,
                                                      _usd,
                                                      result.deviceData);

                                              print("lolo4");
                                              print(result2);
                                              setState(() {
                                                if (result2 == "Success") {
                                                  updateStatusBloc.add(
                                                      UpdateStatusFinishButtonPressed(
                                                          id: state
                                                              .orderDetail[0]
                                                              .id,
                                                          status:
                                                              finishStatus));
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext ctx) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            cusConstants
                                                                .DIALOG_NOTI_SUCCESS_LABLE,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .greenAccent),
                                                          ),
                                                          content: Text(
                                                              "Thanh toán thành công"),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    cusConstants
                                                                        .BUTTON_OK_TITLE))
                                                          ],
                                                        );
                                                      });
                                                }
                                              });
                                              // if (result2 == "Success") {
                                              //   showDialog(
                                              //       context: context,
                                              //       builder: (BuildContext ctx) {
                                              //         return AlertDialog(
                                              //           title: Text(
                                              //             cusConstants
                                              //                 .DIALOG_NOTI_LABLE,
                                              //             style: TextStyle(
                                              //                 color: Colors
                                              //                     .greenAccent),
                                              //           ),
                                              //           content: Text(
                                              //               "Thanh toán thành công"),
                                              //           actions: [
                                              //             TextButton(
                                              //                 onPressed: () {
                                              //                   Navigator.of(
                                              //                           context)
                                              //                       .pop();
                                              //                   Navigator.of(
                                              //                           context)
                                              //                       .pop();
                                              //                   Navigator.pop(
                                              //                       context);
                                              //                 },
                                              //                 child: Text(cusConstants
                                              //                     .BUTTON_OK_TITLE))
                                              //           ],
                                              //         );
                                              //       });
                                              // }
                                              // else if (result2 == "Not found") {
                                              //   showDialog(
                                              //       context: context,
                                              //       builder: (BuildContext ctx) {
                                              //         return AlertDialog(
                                              //           title: Text(
                                              //             cusConstants
                                              //                 .DIALOG_NOTI_LABLE,
                                              //             style: TextStyle(
                                              //                 color: Colors
                                              //                     .greenAccent),
                                              //           ),
                                              //           content: Text(
                                              //               "KHông tìm thấy tài khoản"),
                                              //           actions: [
                                              //             TextButton(
                                              //                 onPressed: () {
                                              //                   Navigator.of(
                                              //                           context)
                                              //                       .pop();
                                              //                   Navigator.of(
                                              //                           context)
                                              //                       .pop();
                                              //                   Navigator.pop(
                                              //                       context);
                                              //                 },
                                              //                 child: Text(cusConstants
                                              //                     .BUTTON_OK_TITLE))
                                              //           ],
                                              //         );
                                              //       });
                                              // } else {
                                              //   {
                                              //     showDialog(
                                              //         context: context,
                                              //         builder:
                                              //             (BuildContext ctx) {
                                              //           return AlertDialog(
                                              //             title: Text(
                                              //               cusConstants
                                              //                   .DIALOG_NOTI_LABLE,
                                              //               style: TextStyle(
                                              //                   color: Colors
                                              //                       .greenAccent),
                                              //             ),
                                              //             content: Text(
                                              //                 "Thanh toán thất bại"),
                                              //             actions: [
                                              //               TextButton(
                                              //                   onPressed: () {
                                              //                     Navigator.of(
                                              //                             context)
                                              //                         .pop();
                                              //                     Navigator.of(
                                              //                             context)
                                              //                         .pop();
                                              //                     Navigator.pop(
                                              //                         context);
                                              //                   },
                                              //                   child: Text(
                                              //                       cusConstants
                                              //                           .BUTTON_OK_TITLE))
                                              //             ],
                                              //           );
                                              //         });
                                              //   }
                                              // }
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext ctx) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        cusConstants
                                                            .DIALOG_NOTI_LABLE,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .greenAccent),
                                                      ),
                                                      content: Text(cusConstants
                                                          .PAYMENT_CONTENT_DIALOG_LABLE),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(cusConstants
                                                                .BUTTON_OK_TITLE))
                                                      ],
                                                    );
                                                  });
                                            }
                                          }
                                        },
                                        text: cusConstants.ONLINE_LABLE,
                                        iconData: Icons.payment,
                                        color: Colors.blue[600],
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                        iconColor: Colors.white,
                                      ),
                                      IconsButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return AlertDialog(
                                                  title: Text(
                                                    cusConstants
                                                        .DIALOG_NOTI_LABLE,
                                                    style: TextStyle(
                                                        color:
                                                            Colors.greenAccent),
                                                  ),
                                                  content: Text(cusConstants
                                                      .PAYMENT_CONTENT_DIALOG_LABLE),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(cusConstants
                                                            .BUTTON_OK_TITLE))
                                                  ],
                                                );
                                              });
                                        },
                                        text: cusConstants.CASH_LABLE,
                                        iconData: Icons.account_balance_wallet,
                                        color: Colors.green[600],
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                        iconColor: Colors.white,
                                      ),
                                    ]);
                              }),
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

  Widget cardImage(List images) {
    return Card(
      child: Column(
        children: [
          Text('Hình ảnh từ cửa hàng',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start),
          images.length > 1
              ?
          // ListView(
          //   children: images.map((e) {
          //     print(e.imageUrl);
          //     return  Image.network(e.imageUrl);
          //   }).toList(),
          // )
          //     :
          Image.network(
            images.firstWhere((element) => element.imageUrl),
            height: 300,
          ) : []
        ],
      ),
    );
  }

  Widget cardInforOrder(
      String stautus, String createTime, String checkinTime, String note) {
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
            trailing: Text(createTime),
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
      num totalPrice,
      String orderDetailId) {
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
          builder: (context, accState) {
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
                              title:
                                  Text(cusConstants.SERVICE_INFO_CARD_CUS_NOTE),
                              subtitle: Text(
                                note,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                          orderDetails.isEmpty
                              ? SizedBox()
                              : ExpansionTile(
                                  title: Text(cusConstants.ADDED_SERVICE_LABLE),
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
                                                        service.accessoryId) >=
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
                                  trailing: Text(
                                      _convertMoney(service.price.toDouble())),
                                );
                              }).toList(),
                            );
                          }).toList()),
                          orderDetails.isEmpty
                              ? SizedBox()
                              : ExpansionTile(
                                  title: Text(cusConstants.ADDED_SERVICE_LABLE),
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
                                                        service.accessoryId) >=
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
                  trailing: Text(_convertMoney(_totalPriceAll.toDouble())),
                ),
              ],
            );
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

  _convertCurrency(double vnd) async {
    double currency = await _repo.getCurrency();
    double usd = 0.0;
    if (vnd != null) {
      usd = vnd * currency;
    }
    return usd;
  }
}
