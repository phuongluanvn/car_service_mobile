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
                      style: TextStyle(fontSize: 12),
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.orderLists.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Color color;
                          var status = state.orderLists[index].status;
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
                              leading: FlutterLogo(),
                              title: Text(
                                  state.orderLists[index].vehicle.licensePlate),
                              subtitle: Text(
                                  state.orderLists[index].vehicle.manufacturer),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ConfirmOrderDetailUi(
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
