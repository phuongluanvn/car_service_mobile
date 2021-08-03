import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/OrderManagement/CreateOrderManagement/CreateBookingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderDetailUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerOrderUi extends StatefulWidget {
  @override
  _CustomerOrderUiState createState() => _CustomerOrderUiState();
}

class _CustomerOrderUiState extends State<CustomerOrderUi> {
  @override
  void initState() {
    super.initState();

    context.read<CustomerOrderBloc>().add(DoOrderListEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: BlocBuilder<CustomerOrderBloc, CustomerOrderState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == CustomerOrderStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == CustomerOrderStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == CustomerOrderStatus.loadedOrderSuccess) {
              if (state.orderLists != null && state.orderLists.isNotEmpty)
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        // color: Colors.white,
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
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.orderLists.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Color color;
                              var status = state.orderLists[index].status;
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
                                case 'Được phản hồi':
                                  color = Colors.teal[300];
                                  break;
                                case 'Từ chối':
                                  color = Colors.red[600];
                                  break;
                                case 'Đang xử lý':
                                  color = Colors.green[300];
                                  break;
                                case 'Hoàn thành':
                                  color = Colors.green[600];
                                  break;
                                case 'Hủy đơn':
                                  color = Colors.red;
                                  break;
                                default:
                                  color = Colors.black;
                              }
                              return Card(
                                  child: Column(children: [
                                ListTile(
                                  trailing: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(
                                          Icons.circle,
                                          color: color,
                                        ),
                                        Text(
                                          state.orderLists[index].status,
                                          style: TextStyle(color: color),
                                        ),
                                      ]),
                                  leading:
                                      Image.asset('lib/images/order_small.png'),
                                  title: Text(state
                                      .orderLists[index].vehicle.licensePlate),
                                  subtitle: Text(state
                                      .orderLists[index].vehicle.manufacturer),
                                  onTap: () {
                                    print(state.orderLists[index].id);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                CustomerOrderDetailUi(
                                                    orderId: state
                                                        .orderLists[index]
                                                        .id)));
                                  },
                                ),
                              ]));
                            },
                          ),
                          // ),
                        ),
                      ],
                    ),
                  ),
                );
              else
                return Center(
                  child: Text('Empty'),
                );
            } else if (state.status == CustomerOrderStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ), //thêm mới xe
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (_) => CreateBookingOrderUI()));
      //   },
      //   child: const Icon(Icons.add),
      //   backgroundColor: Colors.blue[600],
      // ),
    );
  }
}
