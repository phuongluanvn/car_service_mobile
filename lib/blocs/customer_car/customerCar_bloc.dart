
import 'package:car_service/blocs/customer_car/customerCar_event.dart';
import 'package:car_service/blocs/customer_car/customerCar_state.dart';
import 'package:car_service/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerCarBloc extends Bloc<CustomerCarEvents, CustomerCarState> {
  CustomerRepository repo;
  CustomerCarBloc(CustomerCarState initialState, this.repo)
      : super(initialState);

  @override
  Stream<CustomerCarState> mapEventToState(CustomerCarEvents event) async* {
    if (event is DoFetchEvent) {
      yield LoadingState();
      try{
        var cars = await repo.fetchCarList();
        yield FetchSuccess(cars: cars);
      }catch(e){
        yield ErrorState(mess: e.toString());
      }
    }
  }
}