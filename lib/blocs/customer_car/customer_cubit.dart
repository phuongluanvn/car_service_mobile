import 'package:bloc/bloc.dart';
import 'package:car_service/blocs/customer_car/customer_state.dart';
import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:car_service/utils/services/services.dart';

class CarCustomerCubit extends Cubit<CustomerCarState> {
  CustomerRepository _repo;
  CarCustomerCubit() : super(CarInitial());
  List<CarModel> cars = [];

  // Get Data cars from json
  Future<void> getCars() async {
    // cars = await _repo.fetchCarList();
    ServiceResult<List<CarModel>> result = await CarServices.getCars();
    print("objectobjectobject");
    print(result.data);
    try {
      if (result != null) {
        emit(CarLoaded(carModel: result.data));
      } else {

      }
    } catch (e) {
      emit(CarLoadedFailed(message: e.toString()));
    }
  }
}
