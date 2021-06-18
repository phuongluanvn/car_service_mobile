import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        var carLists = await _repo.getCarList();
        if (carLists != null) {
          yield state.copyWith(
              carLists: carLists, status: CustomerCarStatus.loadedCarSuccess);
          print('dada');
        } else {
          yield state.copyWith(
            status: CustomerCarStatus.error,
            message: 'Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          status: CustomerCarStatus.error,
          message: e.toString(),
        );
        ;
      }
    } else if (event is DoCarDetailEvent) {
      yield state.copyWith(detailStatus: CustomerCarDetailStatus.loading);
      try {
        List<CarModel> data =
            await _repo.getCarDetail(event.email);
        if (data != null) {
          yield state.copyWith(
            detailStatus: CustomerCarDetailStatus.success,
            carDetail: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: CustomerCarDetailStatus.error,
            message: 'Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: CustomerCarDetailStatus.error, message: e.toString());
      }
    }
  }
}
