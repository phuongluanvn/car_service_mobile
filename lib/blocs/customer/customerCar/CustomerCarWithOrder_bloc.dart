import 'package:car_service/blocs/customer/customerCar/CustomerCarWithOrder_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCarWithOrder_state.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerCarWithOrderBloc
    extends Bloc<CustomerCarWithOrderEvent, CustomerCarWithOrderState> {
  CustomerRepository _repo;

  CustomerCarWithOrderBloc({CustomerRepository repo})
      : _repo = repo,
        super(CustomerCarWithOrderState());

  @override
  Stream<CustomerCarWithOrderState> mapEventToState(
      CustomerCarWithOrderEvent event) async* {
    if (event is DoVehicleListWithIdEvent) {
      yield state.copyWith(status: CustomerCarWithOrderStatus.loading);
      try {
        print(event.vehicleId);
        var carLists = await _repo.getVehicleWithOrder(event.vehicleId);
        print(carLists);
        if (carLists != null) {
          yield state.copyWith(
              message: carLists,
              orderLists: carLists,
              status: CustomerCarWithOrderStatus.loadedVehicleWithOrderSuccess);
        }
      } catch (e) {
        yield state.copyWith(
          status: CustomerCarWithOrderStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
