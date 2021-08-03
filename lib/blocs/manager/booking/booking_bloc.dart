import 'package:car_service/blocs/manager/booking/booking_events.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
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
        List<OrderDetailModel> bookingList = await _repo.getTestList();
        if (bookingList != null) {
          print('hasdata');
          yield state.copyWith(
              bookingList: bookingList, status: BookingStatus.bookingSuccess);
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
        print('check 1: ' + event.email);
        List<OrderDetailModel> data =
            await _repo.getVerifyOrderDetail(event.email);
        if (data != null) {
          print("Not null");
          yield state.copyWith(
            detailStatus: BookingDetailStatus.success,
            bookingDetail: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: BookingDetailStatus.error,
            message: 'Detail Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: BookingDetailStatus.error, message: e.toString());
      }
    }
    // else if (event is UpdateStatusButtonPressed) {
    //   // yield state.copyWith(detailStatus: BookingDetailStatus.loading);
    //   try {
    //     print('check 2: ' + event.id);
    //     var data =
    //         await _repo.updateStatusOrder(event.id, event.status);
    //         print(data);
    //     if (data != null) {
    //       print("Update Success");
    //       yield state.copyWith(
    //         detailStatus: BookingDetailStatus.updateStatusSuccess,
    //       );
    //     } else {
    //       yield state.copyWith(
    //         detailStatus: BookingDetailStatus.error,
    //         message: 'Update Error',
    //       );
    //     }
    //   } catch (e) {
    //     yield state.copyWith(
    //         detailStatus: BookingDetailStatus.error, message: e.toString());
    //   }
    // }
  }
}
