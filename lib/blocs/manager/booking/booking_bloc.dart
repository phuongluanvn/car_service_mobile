import 'dart:convert';

import 'package:car_service/blocs/manager/booking/booking_events.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyBookingBloc extends Bloc<VerifyBookingEvent, VerifyBookingState> {
  ManagerRepository _repo;

  VerifyBookingBloc({ManagerRepository repo})
      : _repo = repo,
        super(VerifyBookingInitState());

  @override
  Stream<VerifyBookingState> mapEventToState(VerifyBookingEvent event) async* {
    if (event is DoListBookingEvent) {
      yield VerifyBookingLoadingState();
      try {
        var bookingList = await _repo.getBookingList();
        if (bookingList != null) {
          yield VerifyBookingSuccessState(bookingList: bookingList);
          print('dada');
        } else {
          yield VerifyBookingLoadingState();
          print('no data');
        }
      } catch (e) {
        yield VerifyBookingErrorState(message: e.toString());
      }
    } else if (event is DoVerifyBookingDetailEvent) {
      yield VerifyBookingLoadingState();
      try {
        List<BookingModel> data =
            await _repo.getVerifyBookingDetail(event.email);
        if (data != null) {
          yield VerifyBookingDetailSucessState(data: data);
        } else {
          yield VerifyBookingLoadingState();
        }
      } catch (e) {
        yield VerifyBookingErrorState(message: e.toString());
      }
    }
  }
}
