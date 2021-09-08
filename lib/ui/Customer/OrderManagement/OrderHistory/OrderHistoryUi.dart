// import 'package:car_service/blocs/manager/orderHistory/orderHistory_bloc.dart';
// import 'package:car_service/blocs/manager/orderHistory/orderHistory_events.dart';
// import 'package:car_service/blocs/manager/orderHistory/orderHistory_state.dart';
// import 'package:car_service/theme/app_theme.dart';
// import 'package:car_service/ui/Customer/OrderManagement/OrderHistory/OrderHistoryDetailUi.dart';
// import 'package:date_format/date_format.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
//     as cusConstants;
// class OrderHistoryUi extends StatefulWidget {
//   @override
//   _OrderHistoryUiState createState() => _OrderHistoryUiState();
// }

// class _OrderHistoryUiState extends State<OrderHistoryUi> {
//   @override
//   void initState() {
//     super.initState();

//     context.read<OrderHistoryBloc>().add(DoListOrderHistoryEvent());
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppTheme.colors.deepBlue,
//         title: Text('Lịch sử đơn hàng'),
//       ),
//       backgroundColor: AppTheme.colors.lightblue,
//       body: Center(
//         child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
//           // ignore: missing_return
//           builder: (context, state) {
//             if (state.status == OrderHistoryStatus.init) {
//               return CircularProgressIndicator();
//             } else if (state.status == OrderHistoryStatus.loading) {
//               return CircularProgressIndicator();
//             } else if (state.status == OrderHistoryStatus.historySuccess) {
//               if (state.historyList != null && state.historyList.isNotEmpty)
//                 return ListView.builder(
//                   itemCount: state.historyList.length,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     Color color;
//                     var status = state.historyList[index].status;
//                     switch (status) {
//                       case 'Hoàn thành':
//                         color = Colors.green[600];
//                         break;
//                       case 'Hủy đơn':
//                         color = Colors.red;
//                         break;
//                       case 'Hủy đặt lịch':
//                         color = Colors.red[400];
//                         break;
//                     }
//                     return Card(
//                         child: Column(children: [
//                       ListTile(
//                         trailing: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               Icon(
//                                 Icons.circle,
//                                 color: color,
//                               ),
//                               Text(
//                                 state.historyList[index].status,
//                                 style: TextStyle(color: color),
//                               ),
//                             ]),
//                         leading: Image.asset('lib/images/order_small.png'),
//                         title:
//                             Text(state.historyList[index].vehicle.licensePlate),
//                         subtitle: Text(
//                             _convertDate(state.historyList[index].bookingTime),
//                             style: TextStyle(fontWeight: FontWeight.bold,
//                             color: Colors.black)),
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (_) => OrderHistoryDetailUi(
//                                   orderId: state.historyList[index].id)));
//                         },
//                       ),
//                     ]));
//                   },
//                 );
//               else
//                 return Center(
//                   child: Text('Hiện tại không có đơn'),
//                 );
//             } else if (state.status == OrderHistoryStatus.error) {
//               return ErrorWidget(state.message.toString());
//             }
//           },
//         ),
//       ),
//     );
//   }

//   _convertDate(dateInput) {
//     return formatDate(DateTime.parse(dateInput),
//         [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
//   }
// }
