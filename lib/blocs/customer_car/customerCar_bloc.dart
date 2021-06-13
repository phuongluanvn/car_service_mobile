// import 'package:car_service/blocs/customer_car/customerCar_event.dart';
// import 'package:car_service/blocs/customer_car/customerCar_state.dart';
// import 'package:car_service/utils/repository/customer_repo.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CustomerCarBloc extends Bloc<CustomerCarEvents, CustomerCarState> {
//   CustomerRepository repo;
//   CustomerCarBloc(CustomerCarState initialState, this.repo)
//       : super(initialState);

//   @override
//   Stream<CustomerCarState> mapEventToState(CustomerCarEvents event) async* {
//     if (event is DoFetchEvent) {
//       yield LoadingCusCarState();
//       try {
//         var cars = await repo.fetchCarList();
//         if (cars != null) {
//           yield FetchCusCarSuccess(cars: cars);
//         } else {
//           yield LoadingCusCarState();
//         }
//       } catch (e) {
//         yield ErrorCusCarState(mess: e.toString());
//       }
//     } else if (event is DoFetchCarDetail) {
//       yield LoadingCusCarState();
//       try {
//         var data = await repo.getCarDetail(event.name);
//         if (data != null) {
//           yield CusCarDetailSuccessState(data: data);
//         } else {
//           yield LoadingCusCarState();
//         }
//       } catch (e) {
//         yield ErrorCusCarState(mess: e.toString());
//       }
//     }
//   }
// }
