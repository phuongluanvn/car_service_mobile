import 'package:car_service/blocs/manager/booking/booking_cubit.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingManagement/VerifyBookingDetailUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/manager/booking/booking_bloc.dart';
import '../../../../blocs/manager/booking/booking_bloc.dart';
import '../../../../blocs/manager/booking/booking_events.dart';

class VerifyBookingUi extends StatefulWidget {
  @override
  _VerifyBookingUiState createState() => _VerifyBookingUiState();
}

class _VerifyBookingUiState extends State<VerifyBookingUi> {
  @override
  void initState() {
    super.initState();

    context.read<VerifyBookingBloc>().add(DoListBookingEvent());
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
        child: BlocBuilder<VerifyBookingBloc, VerifyBookingState>(
         
          builder: (context, state) {
            if (state.status == BookingStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == BookingStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == BookingStatus.bookingSuccess) {
              if(state.bookingList!= null && state.bookingList.isNotEmpty)
              return ListView.builder(
                itemCount: state.bookingList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.bookingList[index].taiKhoan),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => VerifyBookingDetailUi(
                              emailId: state.bookingList[index].taiKhoan)));
                    },
                  );
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  //   child: Card(
                  //     elevation: 5.0,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width,
                  //       padding: EdgeInsets.symmetric(
                  //           horizontal: 10.0, vertical: 10.0),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: <Widget>[
                  //               Container(
                  //                 width: 70.0,
                  //                 height: 70.0,
                  //                 decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(5.0)),
                  //                 child: CircleAvatar(
                  //                   radius: 5.0,
                  //                   backgroundColor: Colors.blue[300],
                  //                   foregroundColor: Colors.green[300],
                  //                 ),
                  //               ),
                  //               SizedBox(width: 30.0),
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: <Widget>[
                  //                   Text(
                  //                     state.bookingList[index].hoTen,
                  //                     style: TextStyle(
                  //                         color: Colors.black,
                  //                         fontSize: 25.0,
                  //                         fontWeight: FontWeight.bold),
                  //                   ),
                  //                   Text(
                  //                     state.bookingList[index].email,
                  //                     style: TextStyle(
                  //                         color: Colors.black45,
                  //                         fontSize: 15.0),
                  //                   ),
                  //                 ],
                  //               )
                  //             ],
                  //           ),
                  //           Container(),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
              );
              else return Center(child: Text('Empty'),);
            } else if (state.status == BookingStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
