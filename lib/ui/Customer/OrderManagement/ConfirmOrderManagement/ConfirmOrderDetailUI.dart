import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/OrderManagement/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  String acceptStatus = 'Đã phản hồi';

  @override
  void initState() {
    super.initState();
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    BlocProvider.of<CustomerOrderBloc>(context)
        .add(DoOrderDetailEvent(id: widget.orderId));
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
                          state.orderDetail[0].checkinTime != null
                              ? state.orderDetail[0].checkinTime
                              : 'Chưa nhận xe',
                          state.orderDetail[0].note != null
                              ? state.orderDetail[0].checkinTime
                              : 'Không có ghi chú'),
                      cardInforService(
                          state.orderDetail[0].orderDetails[0].name,
                          state.orderDetail[0].orderDetails[0].name,
                          state.orderDetail[0].orderDetails[0].price
                              .toString()),
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
                                  // _packageId = null;
                                  // _note = noteValue;
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
                              UpdateStatus.updateStatusSuccess) {
                            Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TabOrderCustomer()),
                                    );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppTheme.colors.blue),
                                child: Text(textButton ? 'Đồng ý' : 'Xác nhận',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  updateStatusBloc.add(
                                      UpdateStatusButtonPressed(
                                          id: state.orderDetail[0].id,
                                          status: acceptStatus));
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                child: Text('Từ chối',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  setState(() {
                                    _visibleByDenied = !_visibleByDenied;
                                    textButton = !textButton;
                                  });
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
