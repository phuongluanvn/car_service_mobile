import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/OrderManagement/ConfirmOrderManagement/ConfirmOrderDetailUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CreateOrderManagement/CreateBookingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderDetailUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmOrderUI extends StatefulWidget {
  @override
  _ConfirmOrderUIState createState() => _ConfirmOrderUIState();
}

class _ConfirmOrderUIState extends State<ConfirmOrderUI> {
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
              if (state.orderCurrentLists != null && state.orderCurrentLists.isNotEmpty)
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
                          'Đơn cần phản hồi',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.orderCurrentLists.length,
                            shrinkWrap: true,
                            // ignore: missing_return
                            itemBuilder: (context, index) {
                              assert(context != null);
                              if (state.orderCurrentLists[index].status ==
                                  'Đợi phản hồi') {
                                return Card(
                                    child: Column(children: [
                                  ListTile(
                                    trailing: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(
                                            Icons.circle,
                                            color: Colors.orangeAccent,
                                          ),
                                          Text(
                                            state.orderCurrentLists[index].status,
                                            style: TextStyle(
                                                color: Colors.orangeAccent),
                                          ),
                                        ]),
                                    leading: Image.asset(
                                        'lib/images/order_small.png'),
                                    title: Text(state.orderCurrentLists[index].vehicle
                                        .licensePlate),
                                    subtitle: Text(state.orderCurrentLists[index]
                                        .vehicle.manufacturer),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ConfirmOrderDetailUi(
                                                      orderId: state
                                                          .orderCurrentLists[index]
                                                          .id)));
                                    },
                                  ),
                                ]));
                              }
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
                  child: Text('Hiện tại không có đơn'),
                );
            } else if (state.status == CustomerOrderStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ), //thêm mới xe
    );
  }
}
