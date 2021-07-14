import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmOrderDetailUi extends StatefulWidget {
  final String orderId;
  ConfirmOrderDetailUi({@required this.orderId});

  @override
  _ConfirmOrderDetailUiState createState() => _ConfirmOrderDetailUiState();
}

class _ConfirmOrderDetailUiState extends State<ConfirmOrderDetailUi> {
  @override
  bool _visibleByDenied = false;
  void initState() {
    super.initState();
    BlocProvider.of<CustomerOrderBloc>(context)
        .add(DoOrderDetailEvent(id: widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
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
                          state.orderDetail[0].checkinTime,
                          state.orderDetail[0].note),
                      cardInforService(
                          state.orderDetail[0].vehicle.model,
                          state.orderDetail[0].vehicle.model,
                          state.orderDetail[0].vehicle.licensePlate),
                      cardInforCar(
                          state.orderDetail[0].vehicle.manufacturer,
                          state.orderDetail[0].vehicle.model,
                          state.orderDetail[0].vehicle.licensePlate),
                      ListTile(
                        leading: RaisedButton(
                          child: Text('Đồng ý',
                              style: TextStyle(color: Colors.white)),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            _visibleByDenied = false;
                          },
                        ),
                        trailing: RaisedButton(
                          child: Text('Từ chối',
                              style: TextStyle(color: Colors.white)),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            _visibleByDenied = true;
                            print('object');
                          },
                        ),
                      ),
                      Visibility(visible: _visibleByDenied, child: Text('data'))
                    ],
                  ),
                );
              else
                return Center(child: Text('Empty'));
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
      String stautus, String createTime, String checkinTime, String note) {
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
            trailing: Text(createTime),
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
      String servicePackageName, String serviceName, String price) {
    return Card(
      child: Column(
        children: [
          Text('Thông tin dịch vụ'),
          ListTile(
            title: Text('Loại dịch vụ: '),
            trailing: Text(servicePackageName),
          ),
          ListTile(
            title: Text('Chi tiết: '),
            trailing: Text('Giá tiền'),
          ),
          Divider(
            color: Colors.black,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            title: Text('Tổng: '),
            trailing: Text('Giá tiền'),
          ),
        ],
      ),
    );
  }
}
