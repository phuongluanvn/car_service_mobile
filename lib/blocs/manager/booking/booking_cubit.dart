import 'package:bloc/bloc.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:equatable/equatable.dart';

class BookingCubit extends Cubit<VerifyBookingState> {
  ManagerRepository _repro;

  BookingCubit(VerifyBookingState initialState, this._repro)
      : super(initialState);

  // Get Data movie from json
  Future<void> getBookingList() async {
    var bookinglist = await _repro.getBookingList();
    try {
      if (bookinglist != null) {
        emit(VerifyBookingSuccessState(bookingList: bookinglist));
      } else {
        emit(VerifyBookingLoadingState());
      }
    } catch (e) {
      emit(VerifyBookingErrorState(message: e.toString()));
    }
  }

  Future<void> getBookingDetail(String email) async {
    List<BookingModel> data = await _repro.getVerifyBookingDetail(email);
    try {
      if (data != null) {
        emit(VerifyBookingDetailSucessState(data: data));
      } else {
        emit(VerifyBookingLoadingState());
      }
    } catch (e) {
      emit(VerifyBookingErrorState(message: e.toString()));
    }
  }
}
