import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/OrderManagement/ConfirmOrderManagement/ConfirmOrderDetailUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CreateOrderManagement/CreateBookingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderDetailUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProcessingOrderUI extends StatefulWidget {
  @override
  _ProcessingOrderUIState createState() => _ProcessingOrderUIState();
}

class _ProcessingOrderUIState extends State<ProcessingOrderUI> {
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
              if (state.orderProcessingLists != null &&
                  state.orderProcessingLists.isNotEmpty)
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
                        // Text(
                        //   'Đơn cần phản hồi',
                        //   style: TextStyle(
                        //       fontSize: 16, fontWeight: FontWeight.w600),
                        // ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.orderProcessingLists.length,
                            shrinkWrap: true,
                            // ignore: missing_return
                            itemBuilder: (context, index) {
                              assert(context != null);
                              if (state.orderProcessingLists[index].status ==
                                  'Đang tiến hành') {
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
                                            state.orderProcessingLists[index]
                                                .status,
                                            style: TextStyle(
                                                color: Colors.orangeAccent),
                                          ),
                                        ]),
                                    leading: Image.asset(
                                        'lib/images/order_small.png'),
                                    title: Text(state.orderProcessingLists[index]
                                        .vehicle.licensePlate),
                                    subtitle: Text(state
                                        .orderProcessingLists[index]
                                        .vehicle
                                        .manufacturer),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  CustomerOrderDetailUi(
                                                      orderId: state
                                                          .orderProcessingLists[
                                                              index]
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
