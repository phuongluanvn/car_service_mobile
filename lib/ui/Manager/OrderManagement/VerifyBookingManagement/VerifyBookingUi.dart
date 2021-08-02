import 'package:car_service/blocs/manager/booking/booking_cubit.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/theme/app_theme.dart';
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
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: BlocBuilder<VerifyBookingBloc, VerifyBookingState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == BookingStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == BookingStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == BookingStatus.bookingSuccess) {
              if (state.bookingList != null && state.bookingList.isNotEmpty)
                return ListView.builder(
                  itemCount: state.bookingList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      child: (state.bookingList[index].status == 'Booked')
                          ? Column(children: [
                              ListTile(
                                trailing: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                      ),
                                      Text('Booked'),
                                    ]),
                                leading:
                                    Image.asset('lib/images/order_small.png'),
                                title: Text(state
                                    .bookingList[index].vehicle.licensePlate),
                                subtitle:
                                    Text(state.bookingList[index].bookingTime),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => VerifyBookingDetailUi(
                                          orderId:
                                              state.bookingList[index].id)));
                                },
                              ),
                            ])
                          : SizedBox(),
                      // : Column(children: [
                      //     ListTile(
                      //       trailing: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: <Widget>[
                      //             Icon(
                      //               Icons.circle,
                      //               color: Colors.green,
                      //             ),
                      //             Text('Đợi xác nhận'),
                      //           ]),
                      //       leading: FlutterLogo(),
                      //       title: Text(
                      //           state.orderLists[index].taiKhoan),
                      //       subtitle:
                      //           Text(state.orderLists[index].hoTen),
                      //       onTap: () {
                      //         Navigator.of(context).push(
                      //             MaterialPageRoute(
                      //                 builder: (_) =>
                      //                     CustomerCarDetailUi(
                      //                         emailId: state
                      //                             .orderLists[index]
                      //                             .taiKhoan)));
                      //       },
                      //     ),
                      //   ]),
                    );
                    // ListTile(
                    //   title: Text(state.bookingList[index].customer.fullname),
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (_) => VerifyBookingDetailUi(
                    //             emailId: state.bookingList[index].id)));
                    //   },
                    // );
                  },
                );
              else
                return Center(
                  child: Text('Hiện tại không có đơn'),
                );
            } else if (state.status == BookingStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
