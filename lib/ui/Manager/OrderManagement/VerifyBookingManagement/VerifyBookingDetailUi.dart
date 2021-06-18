import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/blocs/manager/booking/booking_cubit.dart';
import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingManagement/VerifyBookingUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/manager/booking/booking_bloc.dart';
import '../../../../blocs/manager/booking/booking_bloc.dart';
import '../../../../blocs/manager/booking/booking_events.dart';
import '../../../../blocs/manager/booking/booking_state.dart';
import '../../../../blocs/manager/booking/booking_state.dart';

class VerifyBookingDetailUi extends StatefulWidget {
  final String emailId;
  VerifyBookingDetailUi({@required this.emailId});

  @override
  _VerifyBookingDetailUiState createState() => _VerifyBookingDetailUiState();
}

class _VerifyBookingDetailUiState extends State<VerifyBookingDetailUi> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VerifyBookingBloc>(context)
        .add(DoVerifyBookingDetailEvent(email: widget.emailId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Information'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: BlocBuilder<VerifyBookingBloc, VerifyBookingState>(
          builder: (context, state) {
            if (state.detailStatus == BookingDetailStatus.init) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == BookingDetailStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == BookingDetailStatus.success) {
              if (state.bookingDetail != null && state.bookingDetail.isNotEmpty)
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              'A:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            child: Text(
                              state.bookingDetail[0].taiKhoan,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              'B:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            child: Text(
                              state.bookingDetail[0].hoTen,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              'C:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            child: Text(
                              state.bookingDetail[0].email,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              'D:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            child: Text(
                              state.bookingDetail[0].soDt,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue),
                              child: Text('Accept',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              child: Text('Deny',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              else
                return Center(child: Text('Empty'));
            } else if (state.detailStatus == BookingDetailStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}