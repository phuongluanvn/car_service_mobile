import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      case 'Booked':
        color = Colors.orange[600];
        break;
      case 'Accepted':
        color = Colors.green[200];
        break;
      case 'Checkin':
        color = Colors.blue[400];
        break;
      case 'Checking':
        color = Colors.blue[700];
        break;
      case 'Waiting confirm':
        color = Colors.orange;
        break;
      case 'Confirmed':
        color = Colors.teal[300];
        break;
      case 'Denied':
        color = Colors.red[600];
        break;
      case 'Working':
        color = Colors.green[300];
        break;
      case 'Complete':
        color = Colors.green[600];
        break;
      case 'Cancle':
        color = Colors.red;
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
                          state.orderDetail[0].bookingTime,
                          state.orderDetail[0].bookingTime,
                          state.orderDetail[0].note),
                      cardInforService(
                          state.orderDetail[0].vehicle.model,
                          state.orderDetail[0].vehicle.model,
                          state.orderDetail[0].vehicle.licensePlate,
                          state.orderDetail[0].orderDetails,
                          state.orderDetail[0].note == "null" ? false : true,
                          state.orderDetail[0].note),
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
      String status, String createTime, String checkinTime, String note) {
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
              trailing: Text(createTime),
            ),
            ListTile(
              title: Text('Thời gian nhận xe: '),
              trailing: Text(checkinTime),
            ),

            // ListTile(
            //   title: Text('Ghi chú từ người dùng: '),
            //   subtitle: Text(
            //     note,
            //     style:
            //         TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            //   ),
            //   isThreeLine: true,
            // ),
          ],
        ),
      ),
    );
  }

  Widget cardInforService(String servicePackageName, String serviceName,
      String price, List services, bool serviceType, String note) {
    print(serviceType);

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
                        trailing: Text('${service.price}'),
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
              trailing: Text('priceTotal'),
            ),
          ],
        ),
      ),
    );
  }
}
