import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/OrderManagement/ConfirmOrderManagement/ConfirmOrderDetailUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CreateOrderManagement/CreateBookingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderDetailUI.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;
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
                                  cusConstants.PROCESSING_ORDER_STATUS) {
                                return Card(
                                    child: Column(children: [
                                  ListTile(
                                    trailing: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(
                                            Icons.circle,
                                            color: Colors.green[300],
                                          ),
                                          Text(
                                            state.orderProcessingLists[index]
                                                .status,
                                            style: TextStyle(
                                                color: Colors.green[300]),
                                          ),
                                        ]),
                                    leading: Image.asset(
                                        cusConstants.IMAGE_URL_ORDER_LOGO_SMALL),
                                    title: Text(state
                                        .orderProcessingLists[index]
                                        .vehicle
                                        .licensePlate),
                                    subtitle: Text(
                                      _convertDate(state
                                          .orderProcessingLists[index]
                                          .bookingTime),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
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
