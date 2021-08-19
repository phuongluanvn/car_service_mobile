import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/model/VehicleModel.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerCarBloc extends Bloc<CustomerCarEvent, CustomerCarState> {
  CustomerRepository _repo;

  CustomerCarBloc({CustomerRepository repo})
      : _repo = repo,
        super(CustomerCarState());

  @override
  Stream<CustomerCarState> mapEventToState(CustomerCarEvent event) async* {
    if (event is DoCarListEvent) {
      yield state.copyWith(status: CustomerCarStatus.loading);
      try {
        final prefs = await SharedPreferences.getInstance();
        final _username = prefs.getString('Username');
        if (_username != null) {
          var carLists = await _repo.getCarListOfCustomer(_username);
          if (carLists != null) {
            yield state.copyWith(
                vehicleLists: carLists,
                status: CustomerCarStatus.loadedCarSuccess);
          }
        } else {
          yield state.copyWith(
            status: CustomerCarStatus.error,
            message: 'Error load car of ' + _username + ' customer car bloc',
          );
        }
      } catch (e) {
        yield state.copyWith(
          status: CustomerCarStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is DoCarDetailEvent) {
      yield state.copyWith(detailStatus: CustomerCarDetailStatus.loading);
      try {
        List<VehicleModel> data = await _repo.getVehicleDetail(event.vehicleId);
        if (data != null) {
          yield state.copyWith(
            detailStatus: CustomerCarDetailStatus.success,
            vehicleDetail: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: CustomerCarDetailStatus.error,
            message: 'Error load car detail - customer car bloc',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: CustomerCarDetailStatus.error, message: e.toString());
      }
    } else if (event is DoCarListWithIdEvent) {
      yield state.copyWith(withIdstatus: CustomerCarWithIdStatus.loading);
      try {
        final prefs = await SharedPreferences.getInstance();

        var carLists = await _repo.getCarListOfCustomer(event.vehicleId);
        if (carLists != null) {
          yield state.copyWith(
              vehicleLists: carLists,
              withIdstatus: CustomerCarWithIdStatus.loadedCarSuccess);
        }
      } catch (e) {
        yield state.copyWith(
          withIdstatus: CustomerCarWithIdStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is DoDelCarEvent) {
      yield state.copyWith(deleteStatus: CustomerCarDeleteStatus.loading);
      try {
        var data = await _repo.deleteVehicle(event.vehicleId);
        if (data != null) {
          yield state.copyWith(
              message: data,
              deleteStatus: CustomerCarDeleteStatus.deleteDetailSuccess);
        }
      } catch (e) {
        yield state.copyWith(
          deleteStatus: CustomerCarDeleteStatus.error,
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
