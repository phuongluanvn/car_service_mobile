import 'package:car_service/blocs/customer/customerOrder/CreateBooking_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CreateBooking_state.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateBookingBloc extends Bloc<CreateBookingEvent, CreateBookingState> {
  CustomerRepository _repo;

  CreateBookingBloc({CustomerRepository repo})
      : _repo = repo,
        super(CreateBookingState());

  @override
  Stream<CreateBookingState> mapEventToState(CreateBookingEvent event) async* {
    if (event is CreateBookingButtonPressed) {
      yield state.copyWith(status: CreateBookingStatus.loading);
      try {
        var data = await _repo.createNewBooking(event.carId, event.packageLists,
            event.note, event.timeBooking, event.imageUrl);
        print(data);
        if (data != null) {
          yield state.copyWith(
              message: data == 'Đặt lịch hẹn thành công' ? 'Đặt lịch hẹn thành công' : data.body,
              status: CreateBookingStatus.createBookingOrderSuccess);
        } else {
          yield state.copyWith(
              status: CreateBookingStatus.error,
              message: 'Đặt lịch dịch vụ không thành công');
        }
      } catch (e) {
        yield state.copyWith(
          status: CreateBookingStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
