import 'package:car_service/blocs/customer/manufacturers/Manufacturer_event.dart';
import 'package:car_service/blocs/customer/manufacturers/Manufacturer_state.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManufacturerBloc extends Bloc<ManufacturerEvent, ManufacturerState> {
  CustomerRepository _repo;

  ManufacturerBloc({CustomerRepository repo})
      : _repo = repo,
        super(ManufacturerState());

  @override
  Stream<ManufacturerState> mapEventToState(ManufacturerEvent event) async* {
    if (event is DoManufacturerListEvent) {
      yield state.copyWith(status: ManufacturerStatus.loading);
      try {
        var manufacturerLists = await _repo.getManufacturerList();
        if (manufacturerLists != null) {
          yield state.copyWith(
              manufacturerLists: manufacturerLists,
              status: ManufacturerStatus.loadedManufacturerSuccess);
        } else {
          yield state.copyWith(
            status: ManufacturerStatus.error,
            message: 'Error manufacturer',
          );
        }
      } catch (e) {
        yield state.copyWith(
          status: ManufacturerStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is DoModelListOfManufacturerEvent) {
      yield state.copyWith(modelStatus: ModelOfManufacturerStatus.loading);
      try {
        var data = await _repo.getListModelOfManufacturer(event.manuName);
        print(data);
        if (data != null) {
          yield state.copyWith(
            modelStatus:
                ModelOfManufacturerStatus.loadedModelOfManufacturerSuccess,
            modelOfManu: data,
          );
        } else {
          yield state.copyWith(
            modelStatus: ModelOfManufacturerStatus.error,
            message: 'Error aaa',
          );
        }
      } catch (e) {
        yield state.copyWith(
            modelStatus: ModelOfManufacturerStatus.error,
            message: e.toString());
      }
    }
  }
}
