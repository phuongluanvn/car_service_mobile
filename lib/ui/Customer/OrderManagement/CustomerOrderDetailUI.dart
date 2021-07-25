import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerOrderDetailUi extends StatefulWidget {
  final String orderId;
  CustomerOrderDetailUi({@required this.orderId});

  @override
  _CustomerOrderDetailUiState createState() => _CustomerOrderDetailUiState();
}

class _CustomerOrderDetailUiState extends State<CustomerOrderDetailUi> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CustomerOrderBloc>(context)
        .add(DoOrderDetailEvent(id: widget.orderId));
  }

  List<Step> steps = [
    Step(
      title: Text('?????'),
      state: StepState.complete,
      isActive: false,
      content: Text('data'),
    ),
    Step(
      title: Text('?????'),
      isActive: true,
      content: Text('data'),
    )
  ];

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
                          state.orderDetail[0].bookingTime,
                          state.orderDetail[0].note),
                      cardInforService(
                          state.orderDetail[0].vehicle.model,
                          state.orderDetail[0].vehicle.model,
                          state.orderDetail[0].vehicle.licensePlate,
                          state.orderDetail[0].orderDetails),
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
            subtitle: Text(
              note,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            isThreeLine: true,
          ),
        ],
      ),
    );
  }

  Widget cardInforService(String servicePackageName, String serviceName,
      String price, List services) {
    return Card(
      child: Column(
        children: [
          Text('Thông tin dịch vụ'),
          ListTile(
            title: Text('Loại dịch vụ: '),
            trailing: Text(servicePackageName),
          ),
          // ListTile(
          //   title: Text('Chi tiết: '),
          //   trailing: Text('Giá tiền'),
          // ),
          ExpansionTile(
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
            trailing: Text('Giá tiền'),
          ),
        ],
      ),
    );
  }
}
