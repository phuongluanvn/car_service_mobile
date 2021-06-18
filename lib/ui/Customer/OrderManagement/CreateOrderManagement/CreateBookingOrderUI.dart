// import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
// import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
// import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CustomerCarDetailUi extends StatefulWidget {
//   final String emailId;
//   CustomerCarDetailUi({@required this.emailId});

//   @override
//   _CustomerCarDetailUiState createState() => _CustomerCarDetailUiState();
// }

// class _CustomerCarDetailUiState extends State<CustomerCarDetailUi> {
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<CustomerCarBloc>(context)
//         .add(DoCarDetailEvent(email: widget.emailId));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit note'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Center(
//         child: BlocBuilder<CustomerCarBloc, CustomerCarState>(
//           // ignore: missing_return
//           builder: (context, state) {
//             if (state.detailStatus == CustomerCarDetailStatus.init) {
//               return CircularProgressIndicator();
//             } else if (state.detailStatus == CustomerCarDetailStatus.loading) {
//               return CircularProgressIndicator();
//             } else if (state.detailStatus == CustomerCarDetailStatus.success) {
//               if (state.carDetail != null && state.carDetail.isNotEmpty)
//                 return Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     children: <Widget>[
//                       Text(state.carDetail[0].taiKhoan),
//                       Container(height: 8),
//                       Text(state.carDetail[0].soDt),
//                       Container(height: 16),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 35,
//                         child: RaisedButton(
//                           child: Text('Submit',
//                               style: TextStyle(color: Colors.white)),
//                           color: Theme.of(context).primaryColor,
//                           onPressed: () {},
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               else
//                 return Center(child: Text('Empty'));
//             } else if (state.detailStatus == CustomerCarDetailStatus.error) {
//               return ErrorWidget(state.message.toString());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
