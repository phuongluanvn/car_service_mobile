import 'package:car_service/blocs/manager/booking/booking_cubit.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingManagement/VerifyBookingDetailUi.dart';
import 'package:date_format/date_format.dart';
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

  Future<void> _getData() async {
    setState(() {
      BlocProvider.of<VerifyBookingBloc>(context).add(DoListBookingEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
      body: RefreshIndicator(
        onRefresh: _getData,
        child: BlocBuilder<VerifyBookingBloc, VerifyBookingState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == BookingStatus.init) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == BookingStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == BookingStatus.bookingSuccess) {
              if (state.bookingList != null && state.bookingList.isNotEmpty)
                return ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: state.bookingList.length,
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
                        leading: Image.asset('lib/images/order_small.png'),
                        title:
                            Text(state.bookingList[index].vehicle.licensePlate),
                        subtitle: Text(
                            _convertDate(state.bookingList[index].bookingTime)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => VerifyBookingDetailUi(
                                  orderId: state.bookingList[index].id)));
                        },
                      ),
                    ]));
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
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.35),
                              child: Text('Hiện tại không có đơn')),
                        ],
                      ),
                    ),
                  ],
                );
            } else if (state.status == BookingStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }
}
