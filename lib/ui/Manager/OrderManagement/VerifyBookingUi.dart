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
      backgroundColor: Colors.blue[100],
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
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 70.0,
                                  height: 70.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: CircleAvatar(
                                    radius: 5.0,
                                    backgroundColor: Colors.blue[300],
                                    foregroundColor: Colors.green[300],
                                  ),
                                ),
                                SizedBox(width: 30.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      state.bookingList[index].hoTen,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      state.bookingList[index].email,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 15.0),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ),
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
