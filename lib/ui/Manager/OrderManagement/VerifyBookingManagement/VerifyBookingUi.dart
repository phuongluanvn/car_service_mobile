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
