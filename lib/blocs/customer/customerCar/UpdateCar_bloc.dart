import 'package:car_service/blocs/customer/customerCar/UpdateCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/UpdateCar_state.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateCarBloc extends Bloc<UpdateCarEvent, UpdateCarState> {
  CustomerRepository _repo;

  UpdateCarBloc({CustomerRepository repo})
      : _repo = repo,
        super(UpdateCarState());

  @override
  Stream<UpdateCarState> mapEventToState(UpdateCarEvent event) async* {
    if (event is UpdateCarButtonPressed) {
      yield state.copyWith(updateStatus: UpdateCarStatus.loading);
      try {
        var data = await _repo.updateVehicle(
            event.carId,
            event.manufacturer,
            event.model,
            event.licensePlateNumber
            );
        if (data != null) {
          yield state.copyWith(
              message: data, updateStatus: UpdateCarStatus.updateDetailSuccess);
        }
      } catch (e) {
        yield state.copyWith(
          updateStatus: UpdateCarStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
