import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/OrderManagement/CreateOrderManagement/CreateBookingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderDetailUI.dart';
import 'package:car_service/utils/model/OrderModel.dart';
import 'package:date_format/date_format.dart';
// import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;

class CustomerOrderUi extends StatefulWidget {
  @override
  _CustomerOrderUiState createState() => _CustomerOrderUiState();
}

class _CustomerOrderUiState extends State<CustomerOrderUi> {
  TextEditingController _textEditingController = TextEditingController();
  List<OrderModel> vehicleListsOnSearch = [];
  DateTime _selectedDay;

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
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: Colors.grey.shade200,
                        //       borderRadius: BorderRadius.circular(30)),
                        //   child: TextField(
                        //     controller: _textEditingController,
                        //     decoration: InputDecoration(
                        //         border: InputBorder.none,
                        //         errorBorder: InputBorder.none,
                        //         focusedBorder: InputBorder.none,
                        //         contentPadding: EdgeInsets.all(15),
                        //         hintText: 'Tìm kiếm'),
                        //     onChanged: (value) {
                        //       setState(() {
                        //         vehicleListsOnSearch = state.orderLists
                        //             .where((element) => element
                        //                 .vehicle.licensePlate
                        //                 .toLowerCase()
                        //                 .contains(value.toLowerCase()))
                        //             .toList();
                        //       });
                        //     },
                        //   ),
                        // ),

                        Text(
                          cusConstants.ORDER_DETAIL_TITLE,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Expanded(
                          child: _textEditingController.text.isNotEmpty &&
                                  vehicleListsOnSearch.isEmpty
                              ? Center(
                                  child: Text('Không tìm thấy xe'),
                                )
                              : ListView.builder(
                                  itemCount:
                                      _textEditingController.text.isNotEmpty
                                          ? vehicleListsOnSearch.length
                                          : state.orderLists.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    Color color;
                                    var status = state.orderLists[index].status;
                                    switch (status) {
                                      case cusConstants
                                          .WAITING_CONFIRM_ORDER_STATUS:
                                        color = Colors.orange[600];
                                        break;
                                      case cusConstants.ACCEPTED_ORDER_STATUS:
                                        color = Colors.green[200];
                                        break;
                                      case cusConstants.CHECKIN_ORDER_STATUS:
                                        color = Colors.blue[400];
                                        break;
                                      case cusConstants.CHECKING_ORDER_STATUS:
                                        color = Colors.blue[700];
                                        break;
                                      case cusConstants.IN_PROCESS_ORDER_STATUS:
                                        color = Colors.green[300];
                                        break;
                                      case cusConstants.CONFIRM_ORDER_STATUS:
                                        color = Colors.orange;
                                        break;
                                      case cusConstants.CONFIRMED_ORDER_STATUS:
                                        color = Colors.teal[300];
                                        break;
                                      case cusConstants.DENY_ORDER_STATUS:
                                        color = Colors.red[600];
                                        break;
                                      case cusConstants.PROCESSING_ORDER_STATUS:
                                        color = Colors.green[300];
                                        break;
                                      case cusConstants.COMPLETED_ORDER_STATUS:
                                        color = Colors.green[600];
                                        break;
                                      case cusConstants.CANCEL_ORDER_STATUS:
                                        color = Colors.red;
                                        break;
                                      case cusConstants.CANCEL_BOOKING_STATUS:
                                        color = Colors.red[400];
                                        break;
                                      case cusConstants.WAITING_PAYMENT_ORDER_STATUS:
                                        color = Colors.orange[400];
                                        break;
                                      case cusConstants.COMPLETED_PAYMENT_ORDER_STATUS:
                                        color = Colors.green[600];
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
                                        leading: Image.asset(
                                            cusConstants.IMAGE_URL_ORDER_LOGO_SMALL),
                                        title: Text(
                                            _textEditingController
                                                    .text.isNotEmpty
                                                ? vehicleListsOnSearch[index]
                                                    .vehicle
                                                    .licensePlate
                                                : state.orderLists[index]
                                                    .vehicle.licensePlate,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        subtitle: Text(
                                          _convertDate(state
                                              .orderLists[index].bookingTime),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
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
    );
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }
}
