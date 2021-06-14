import 'package:car_service/blocs/manager/booking/booking_events.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'booking_state.dart';
import 'booking_state.dart';

class VerifyBookingBloc extends Bloc<VerifyBookingEvent, VerifyBookingState> {
  ManagerRepository _repo;

  VerifyBookingBloc({ManagerRepository repo})
      : _repo = repo,
        super(VerifyBookingState());

  @override
  Stream<VerifyBookingState> mapEventToState(VerifyBookingEvent event) async* {
    if (event is DoListBookingEvent) {
      yield state.copyWith(status: BookingStatus.loading);
      try {
        var bookingList = await _repo.getBookingList();
        if (bookingList != null) {
          yield state.copyWith(
              bookingList: bookingList, status: BookingStatus.bookingSuccess);
          print('dada');
        } else {
          yield state.copyWith(
            status: BookingStatus.error,
            message: 'Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          status: BookingStatus.error,
          message: e.toString(),
        );
        ;
      }
    } else if (event is DoVerifyBookingDetailEvent) {
      yield state.copyWith(detailStatus: BookingDetailStatus.loading);
      try {
        List<BookingModel> data =
            await _repo.getVerifyBookingDetail(event.email);
        if (data != null) {
          yield state.copyWith(
            detailStatus: BookingDetailStatus.success,
            bookingDetail: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: BookingDetailStatus.error,
            message: 'Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: BookingDetailStatus.error, message: e.toString());
      }
    }
  }
}
