import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CustomerMainUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/WaitingPaymentOrderManagement/CouponUI.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String paymentCompleted = 'Đã thanh toán';
  int total = 0;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CustomerOrderBloc>(context)
        .add(DoOrderDetailEvent(id: widget.orderId));
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Chi tiết đơn hàng'),
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
                          state.orderDetail[0].orderDetails,
                          state.orderDetail[0].note == null ? false : true,
                          state.orderDetail[0].note != null
                              ? state.orderDetail[0].note
                              : 'Không có ghi chú',
                          total = state.orderDetail[0].orderDetails
                              .fold(0, (sum, element) => sum + element.price),
                          state.orderDetail[0].id),
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
                                  hintText: 'Lý do từ chối'),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            var request = BraintreeDropInRequest(
                              tokenizationKey:
                                  'sandbox_rzktbfv9_qgn7c8w395dwxz6h',
                              collectDeviceData: true,
                              paypalRequest: BraintreePayPalRequest(
                                amount: '10.00',
                                displayName: 'TestPay',
                              ),
                              cardEnabled: true,
                            );
                            BraintreeDropInResult result =
                                await BraintreeDropIn.start(request);
                            if (result != null) {
                              print(result.paymentMethodNonce.description);
                              print(result.paymentMethodNonce.nonce);
                            }
                          },
                          child: Text('Thanh toán')),
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
                                      'Thông báo!',
                                      style:
                                          TextStyle(color: Colors.greenAccent),
                                    ),
                                    content:
                                        Text('Cảm ơn bạn đã xử dụng dịch vụ!'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            // Close the dialog
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) => CustomerHome()),
                                            // );
                                            Navigator.of(context).pop();
                                            Navigator.pop(context);
                                            context
                                                .read<CustomerOrderBloc>()
                                                .add(DoOrderListEvent());
                                          },
                                          child: Text('Đồng ý'))
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
                              child: Text('Đã thanh toán',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                setState(() {
                                  updateStatusBloc.add(
                                      UpdateStatusConfirmAcceptedButtonPressed(
                                          id: state.orderDetail[0].id,
                                          status: paymentCompleted));
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                );
              else
                return Center(child: Text('Không có chi tiết đơn hàng'));
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
          Text(
            'Thông tin xe',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          ListTile(
            title: Text('Biển số xe'),
            trailing: Text(licensePlace),
          ),
          ListTile(
            title: Text('Hãng xe'),
            trailing: Text(manuName),
          ),
          ListTile(
            title: Text('Mẫu xe'),
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
          Text('Thông tin đơn hàng'),
          ListTile(
            title: Text('Trạng thái đơn hàng: '),
            trailing: Text(stautus),
          ),
          ListTile(
            title: Text('Thời gian đặt hẹn: '),
            trailing: Text(bookingTime),
          ),
          ListTile(
            title: Text('Thời gian nhận xe: '),
            trailing: Text(checkinTime),
          ),
          ListTile(
            title: Text('Ghi chú từ người dùng: '),
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
      List services,
      bool serviceType,
      String note,
      int totalPrice,
      String orderDetailId) {
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
            Text(
              'Thông tin dịch vụ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
            ),
            ListTile(
              title: Text('Loại dịch vụ: '),
              trailing: serviceType ? Text('Sửa chữa') : Text('Bảo dưỡng'),
            ),
            serviceType
                ? ListTile(
                    title: Text('Tình trạng xe từ người dùng: '),
                    subtitle: Text(
                      note,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ))
                : Column(
                    children: services.map((service) {
                      return ListTile(
                        title: Text(service.name),
                        trailing: Text(_convertMoney(service.price.toDouble())),
                      );
                    }).toList(),
                  ),
            Divider(
              color: Colors.black,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            // ListTile(
            //   title: Text('Khuyến mãi: '),
            //   trailing: IconButton(
            //     color: AppTheme.colors.white,
            //     icon: Icon(Icons.card_giftcard),
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) =>
            //                   CouponUI(orderId: orderDetailId)));
            //     },
            //   ),
            // ),
            ListTile(
              title: Text('Tổng: '),
              trailing: Text(_convertMoney(totalPrice.toDouble())),
            ),
          ],
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
