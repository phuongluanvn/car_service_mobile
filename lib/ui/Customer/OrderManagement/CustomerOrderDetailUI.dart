import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';

class CustomerOrderDetailUi extends StatefulWidget {
  final String orderId;
  CustomerOrderDetailUi({@required this.orderId});

  @override
  _CustomerOrderDetailUiState createState() => _CustomerOrderDetailUiState();
}

class _CustomerOrderDetailUiState extends State<CustomerOrderDetailUi> {
  Color color;

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
      case 'Hủy':
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
              if (state.orderDetail != null && state.orderDetail.isNotEmpty)
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      cardInforOrder(
                          state.orderDetail[0].status,
                          _convertDate(state.orderDetail[0].bookingTime),
                          state.orderDetail[0].checkinTime != null
                              ? _convertDate(state.orderDetail[0].checkinTime)
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
            Text(
              'Thông tin xe',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
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
              'Thông tin đơn hàng',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
            ),
            ListTile(
                title: Text('Trạng thái đơn hàng: '),
                trailing: Text(
                  status,
                  style: TextStyle(color: _changeColorStt(status)),
                )),
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
      List services,
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
                      countPrice += service.price;
                      print('object');
                      print(_convertMoney(countPrice.toDouble()));
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
                trailing: Column(
                  children: [
                    Text(
                      _convertMoney(countPrice.toDouble()),
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                    Text(_convertMoney(totalPrice.toDouble())),
                  ],
                )),
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
