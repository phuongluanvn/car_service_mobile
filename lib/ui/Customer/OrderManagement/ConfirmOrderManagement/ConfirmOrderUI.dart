import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
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
      backgroundColor: Colors.blue[100],
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
                return Column(
                  children: [
                    Divider(),
                    Text(
                      'Đơn cần xác nhận',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Divider(
                      thickness: 2,
                      endIndent: 20,
                      indent: 20,
                      color: Colors.black,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.orderLists.length,
                        shrinkWrap: true,
                        // ignore: missing_return
                        itemBuilder: (context, index) {
                          assert(context != null);
                          if (state.orderLists[index].status ==
                              'Waitting Confirm') {
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
                                        state.orderLists[index].status,
                                        style: TextStyle(
                                            color: Colors.orangeAccent),
                                      ),
                                    ]),
                                leading:
                                    Image.asset('lib/images/order_small.png'),
                                title: Text(state
                                    .orderLists[index].vehicle.licensePlate),
                                subtitle: Text(state
                                    .orderLists[index].vehicle.manufacturer),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ConfirmOrderDetailUi(
                                          orderId:
                                              state.orderLists[index].id)));
                                },
                              ),
                            ]));
                          }
                        },
                      ),
                      // ),
                    ),
                  ],
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
    );
  }
}
