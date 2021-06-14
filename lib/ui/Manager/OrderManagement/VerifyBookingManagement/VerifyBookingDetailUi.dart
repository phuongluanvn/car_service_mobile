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
        title: Text('Edit note'),
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
                      Text(state.bookingDetail[0].email),
                      Container(height: 8),
                      Text(state.bookingDetail[0].soDt),
                      Container(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 35,
                        child: RaisedButton(
                          child: Text('Submit',
                              style: TextStyle(color: Colors.white)),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {},
                        ),
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
