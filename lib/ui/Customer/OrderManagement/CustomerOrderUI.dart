import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
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
                      'Thông tin đơn hàng',
                      style: TextStyle(fontSize: 12),
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.orderLists.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                              child: Column(children: [
                            ListTile(
                              trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.circle,
                                      color: Colors.red,
                                    ),
                                    Text('Đợi xác nhận'),
                                  ]),
                              leading: FlutterLogo(),
                              title: Text(
                                  state.orderLists[index].vehicle.licensePlate),
                              subtitle: Text(
                                  state.orderLists[index].vehicle.manufacturer),
                              onTap: () {
                                print(state.orderLists[index].id);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => CustomerOrderDetailUi(
                                        orderId: state.orderLists[index].id)));
                              },
                            ),
                          ]));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CreateBookingOrderUI()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue[600],
      ),
    );
  }
}
