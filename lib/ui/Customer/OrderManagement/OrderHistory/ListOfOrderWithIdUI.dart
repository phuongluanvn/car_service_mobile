import 'package:car_service/blocs/customer/customerCar/CustomerCarWithOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCarWithOrder_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCarWithOrder_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;

class ListOfOrderWithIdUi extends StatefulWidget {
  final String orderId;
  ListOfOrderWithIdUi({@required this.orderId});

  @override
  _ListOfOrderWithIdUiState createState() => _ListOfOrderWithIdUiState();
}

class _ListOfOrderWithIdUiState extends State<ListOfOrderWithIdUi> {

  @override
  void initState() {
    super.initState();
    context
        .read<CustomerCarWithOrderBloc>()
        .add(DoVehicleListWithIdEvent(vehicleId: widget.orderId));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết các đơn'),
          backgroundColor: AppTheme.colors.deepBlue,
        ),
        backgroundColor: AppTheme.colors.lightblue,
        body: SingleChildScrollView(
          child:
              BlocBuilder<CustomerCarWithOrderBloc, CustomerCarWithOrderState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state.status == CustomerCarWithOrderStatus.init) {
                return CircularProgressIndicator();
              } else if (state.status == CustomerCarWithOrderStatus.loading) {
                return Text('???');
              } else if (state.status ==
                  CustomerCarWithOrderStatus.loadedVehicleWithOrderSuccess) {
                if (state.orderLists != null && state.orderLists.isNotEmpty)
                  return Center(
                    child: ListView.builder(
                      itemCount: state.orderLists.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        //hiển thị list xe
                        return Card(
                          child: Column(
                              children: state.orderLists.map((e) {
                            return ExpansionTile(
                              title: Text(e.licensePlate),
                              children: e.orders.map<Widget>((order) {
                                return ListTile(
                                  title: Text(order.orderDetails[0].name),
                                );
                              }).toList(),
                            );
                          }).toList()),
                        );
                      },
                    ),
                  );
                //   ],
                // );
                else
                  return Center(
                    child: Text('Không tìm thấy dịch vụ chi tiết của xe'),
                  );
              } else if (state.status == CustomerCarWithOrderStatus.error) {
                return ErrorWidget(state.message.toString());
              }
            },
          ),
        ));
  }
}
