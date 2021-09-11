import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/OrderManagement/ConfirmOrderManagement/ConfirmOrderDetailUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CreateOrderManagement/CreateBookingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderDetailUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/WaitingConfirmOrderManagement/WaitingConfirmOrderDetailUI.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;
class WaitingConfirmOrderUI extends StatefulWidget {
  @override
  _WaitingConfirmOrderUIState createState() => _WaitingConfirmOrderUIState();
}

class _WaitingConfirmOrderUIState extends State<WaitingConfirmOrderUI> {
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
              if (state.orderWaitingConfirmLists != null &&
                  state.orderWaitingConfirmLists.isNotEmpty)
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
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.orderWaitingConfirmLists.length,
                            shrinkWrap: true,
                            // ignore: missing_return
                            itemBuilder: (context, index) {
                              assert(context != null);
                              if (state
                                      .orderWaitingConfirmLists[index].status ==
                                  cusConstants.WAITING_CONFIRM_ORDER_STATUS) {
                                return Card(
                                    child: Column(children: [
                                  ListTile(
                                    trailing: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(
                                            Icons.circle,
                                            color: Colors.orange[600],
                                          ),
                                          Text(
                                            state
                                                .orderWaitingConfirmLists[index]
                                                .status,
                                            style: TextStyle(
                                                color: Colors.orange[600]),
                                          ),
                                        ]),
                                    leading: Image.asset(
                                        cusConstants.IMAGE_URL_ORDER_LOGO_SMALL),
                                    title: Text(state
                                        .orderWaitingConfirmLists[index]
                                        .vehicle
                                        .licensePlate),
                                    subtitle: Text(
                                      _convertDate(
                                          state.orderWaitingConfirmLists[index].bookingTime),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (_) =>
                                              WaitingConfirmOrderDetailUi(
                                                  orderId: state
                                                      .orderWaitingConfirmLists[
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
                  child: Text(cusConstants.NOT_FOUND_ORDER),
                );
            } else if (state.status == CustomerOrderStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ), //thêm mới xe
    );
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }
}
