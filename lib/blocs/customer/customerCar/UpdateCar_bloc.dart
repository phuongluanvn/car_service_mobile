import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/customer/customerCar/DelCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/DelCar_state.dart';
import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/model/VehicleModel.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteCarBloc extends Bloc<DeleteCarEvent, DeleteCarState> {
  CustomerRepository _repo;

  DeleteCarBloc({CustomerRepository repo})
      : _repo = repo,
        super(DeleteCarState());

  @override
  Stream<DeleteCarState> mapEventToState(DeleteCarEvent event) async* {
     if (event is DoDeleteCarEvent) {
      yield state.copyWith(deleteStatus: CarDeleteStatus.loading);
      try {
        var data = await _repo.deleteVehicle(event.vehicleId);
        if (data != null) {
          yield state.copyWith(
              message: data,
              deleteStatus: CarDeleteStatus.deleteDetailSuccess);
        }
      } catch (e) {
        yield state.copyWith(
          deleteStatus: CarDeleteStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is DoUpdateInfoCarEvent) {
      // yield state.copyWith(withIdstatus: CustomerCarWithIdStatus.loading);
      // try {
      //   final prefs = await SharedPreferences.getInstance();

      //   var carLists = await _repo.getCarListOfCustomer(event.vehicleId);
      //   if (carLists != null) {
      //     yield state.copyWith(
      //         vehicleLists: carLists,
      //         withIdstatus: CustomerCarWithIdStatus.loadedCarSuccess);
      //   }
      // } catch (e) {
      //   yield state.copyWith(
      //     withIdstatus: CustomerCarWithIdStatus.error,
      //     message: e.toString(),
      //   );
      // }
    }
  }
}
