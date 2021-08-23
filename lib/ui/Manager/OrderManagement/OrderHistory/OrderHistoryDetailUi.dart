import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/blocs/manager/booking/booking_cubit.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_bloc.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_events.dart';
import 'package:car_service/blocs/manager/orderHistory/orderHistory_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingManagement/VerifyBookingUi.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';

class OrderHistoryDetailUi extends StatefulWidget {
  final String orderId;

  OrderHistoryDetailUi({@required this.orderId});

  @override
  _OrderHistoryDetailUiState createState() => _OrderHistoryDetailUiState();
}

class _OrderHistoryDetailUiState extends State<OrderHistoryDetailUi> {
  // UpdateStatusOrderBloc updateStatusBloc;
  @override
  void initState() {
    // updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    super.initState();
    BlocProvider.of<OrderHistoryBloc>(context)
        .add(DoOrderHistoryDetailEvent(id: widget.orderId));
    print(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    final String acceptStatus = 'Accepted';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Chi tiết lịch sử đơn hàng'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state.detailStatus == OrderHistoryDetailStatus.init) {
                return CircularProgressIndicator();
              } else if (state.detailStatus ==
                  OrderHistoryDetailStatus.loading) {
                return CircularProgressIndicator();
              } else if (state.detailStatus ==
                  OrderHistoryDetailStatus.success) {
                if (state.historyDetail != null &&
                    state.historyDetail.isNotEmpty)
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                'Fullname:',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              child: Text(
                                state.historyDetail[0].customer.fullname,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                        Container(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                'Email:',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              child: Text(
                                state.historyDetail[0].customer.email,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                        Container(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                'Booking time:',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              child: Text(
                                state.historyDetail[0].bookingTime,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                        Container(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                'Status:',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              child: Text(
                                state.historyDetail[0].status,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                        Container(height: 16),
                        cardInforService(
                            state.historyDetail[0].vehicle.model,
                            state.historyDetail[0].vehicle.model,
                            state.historyDetail[0].vehicle.licensePlate,
                            state.historyDetail[0].orderDetails,
                            state.historyDetail[0].note == null ? false : true,
                            state.historyDetail[0].note != null
                                ? state.historyDetail[0].note
                                : 'Không có ghi chú',
                            state.historyDetail[0].note == null
                                ? state.historyDetail[0].package.price
                                : 0),
                        state.historyDetail[0].feedbacks.isNotEmpty
                            ? _showFeedback(
                                state.historyDetail[0].feedbacks.first.rating,
                                state.historyDetail[0].feedbacks.first
                                    .description)
                            : _showFeedback(0, 'Không có đánh giá')
                      ],
                    ),
                  );
                else
                  return Center(child: Text('Empty'));
              } else if (state.detailStatus == BookingDetailStatus.error) {
                return ErrorWidget(state.message.toString());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _showFeedback(int rating, String dess) {
    return Card(
      child: Column(
        children: [
          Text(
            'Đánh giá của khách hàng',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          ListTile(
            title: Text('Số sao'),
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
            title: Text('Nội dung'),
            trailing: Text(dess),
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
}
