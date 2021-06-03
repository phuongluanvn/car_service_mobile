import 'package:car_service/blocs/manager/booking/booking_bloc.dart';
import 'package:car_service/blocs/manager/booking/booking_events.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyBookingUi extends StatefulWidget {
  @override
  _VerifyBookingUiState createState() => _VerifyBookingUiState();
}

class _VerifyBookingUiState extends State<VerifyBookingUi> {
  VerifyBookingBloc verifyBloc;

  @override
  void initState() {
    verifyBloc = BlocProvider.of<VerifyBookingBloc>(context);
    verifyBloc.add(DoListBookingEvent());
    super.initState();
  }

  @override
  void dispose() {
    verifyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocBuilder<VerifyBookingBloc, VerifyBookingState>(
          builder: (context, state) {
            if (state is VerifyBookingInitState) {
              return CircularProgressIndicator();
            } else if (state is VerifyBookingLoadingState) {
              return CircularProgressIndicator();
            } else if (state is VerifyBookingSuccessState) {
              return ListView.builder(
                itemCount: state.bookingList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.bookingList[index].hoTen),
                  );
                },
              );
            } else if (state is VerifyBookingErrorState) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
