import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/blocs/customer/customerOrder/FeedbackOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/FeedbackOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/FeedbackOrder_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CustomerMainUI.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rating_dialog/rating_dialog.dart';

class OrderHistoryDetailUi extends StatefulWidget {
  final String orderId;
  OrderHistoryDetailUi({@required this.orderId});

  @override
  _OrderHistoryDetailUiState createState() => _OrderHistoryDetailUiState();
}

class _OrderHistoryDetailUiState extends State<OrderHistoryDetailUi> {
  UpdateStatusOrderBloc updateStatusBloc;
  FeedbackOrderBloc _buttonFeedback;
  bool _visibleByDenied = false;
  bool textButton = true;
  String reasonReject;
  bool _isShowButtonFB = true;

  @override
  void initState() {
    print(widget.orderId);
    super.initState();
    BlocProvider.of<CustomerOrderBloc>(context)
        .add(DoOrderDetailEvent(id: widget.orderId));
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    _buttonFeedback = BlocProvider.of<FeedbackOrderBloc>(context);
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
      ),
      body: BlocListener<FeedbackOrderBloc, FeedbackOrderState>(
        listener: (context, stateFB) {
          // TODO: implement listener
          if (stateFB.status == FeedbackOrderStatus.successFeedback) {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
            title: Text(
              'Thông báo!',
              style: TextStyle(color: Colors.greenAccent),
            ),
            content: Text('Cảm ơn bạn đã đánh giá!'),
            actions: [
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('Đồng ý'))
            ],
          );
            });
            
          }
        },
        child: Center(
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
                                ? state.orderDetail[0].checkinTime
                                : 'Chưa nhận xe',
                            state.orderDetail[0].note != null
                                ? state.orderDetail[0].note
                                : 'Không có ghi chú'),
                        cardInforService(
                            state.orderDetail[0].vehicle.model,
                            state.orderDetail[0].vehicle.model,
                            state.orderDetail[0].vehicle.licensePlate,
                            state.orderDetail[0].orderDetails,
                            state.orderDetail[0].note == null ? false : true,
                            state.orderDetail[0].note != null
                                ? state.orderDetail[0].note
                                : 'Không có ghi chú',
                            state.orderDetail[0].note == null
                                ? state.orderDetail[0].package.price
                                : 0),
                        cardInforCar(
                            state.orderDetail[0].vehicle.manufacturer,
                            state.orderDetail[0].vehicle.model,
                            state.orderDetail[0].vehicle.licensePlate),
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
                        BlocListener<UpdateStatusOrderBloc,
                            UpdateStatusOrderState>(
                          listener: (builder, statusState) {
                            if (statusState.status ==
                                UpdateStatus
                                    .updateStatusConfirmAcceptedSuccess) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerHome()),
                              );
                            }
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: ElevatedButton(
                                style: _isShowButtonFB
                                    ? ElevatedButton.styleFrom(
                                        primary: AppTheme.colors.blue)
                                    : ElevatedButton.styleFrom(
                                        primary: Colors.grey),
                                child: Text('Đánh giá đơn',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  if (_isShowButtonFB) {
                                    _showFBDialog();
                                  }
                                }),
                          ),
                        )
                      ],
                    ),
                  );
                else
                  return Center(child: Text('Không có chi tiết đơn hàng'));
              } else if (state.detailStatus ==
                  CustomerOrderDetailStatus.error) {
                return ErrorWidget(state.message.toString());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget cardInforCar(String manuName, String modelName, String licensePlace) {
    return Card(
      child: Column(
        children: [
          Text('Thông tin xe'),
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
      int totalPrice) {
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
                : ExpansionTile(
                    title: Text('Chi tiết:'),
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

  _showFBDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return RatingDialog(
              commentHint: 'Hãy nhập đánh giá của bạn',
              title: 'Đánh giá đơn',
              message: 'Bạn có hài lòng với dịch vụ của chúng tôi?',
              image: Icon(
                Icons.star,
                size: 100,
                color: Colors.yellow,
              ),
              submitButton: 'Gửi',
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
}
