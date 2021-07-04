import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/blocs/customer/customerService/CustomerService_event.dart';
import 'package:car_service/blocs/customer/customerService/CustomerService_state.dart';
import 'package:car_service/utils/model/OrderModel.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerServiceBloc
    extends Bloc<CustomerServiceEvent, CustomerServiceState> {
  CustomerRepository _repo;

  CustomerServiceBloc({CustomerRepository repo})
      : _repo = repo,
        super(CustomerServiceState());

  @override
  Stream<CustomerServiceState> mapEventToState(
      CustomerServiceEvent event) async* {
    if (event is DoServiceListEvent) {
      yield state.copyWith(status: CustomerServiceStatus.loading);
      try {
        var serviceLists = await _repo.getServiceList();
        if (serviceLists != null) {
          yield state.copyWith(
              serviceLists: serviceLists,
              status: CustomerServiceStatus.loadedServiceSuccess);
          print('service');
        } else {
          yield state.copyWith(
            status: CustomerServiceStatus.error,
            message: 'Error',
          );
          print('no service data');
        }
      } catch (e) {
        yield state.copyWith(
          status: CustomerServiceStatus.error,
          message: e.toString(),
        );
        ;
      }
    }
    //  else if (event is DoOrderDetailEvent) {
    //   yield state.copyWith(detailStatus: CustomerOrderDetailStatus.loading);
    //   try {
    //     List<OrderModel> data =
    //         await _repo.getOrderDetail(event.email);
    //     if (data != null) {
    //       yield state.copyWith(
    //         detailStatus: CustomerOrderDetailStatus.success,
    //         orderDetail: data,
    //       );
    //     } else {
    //       yield state.copyWith(
    //         detailStatus: CustomerOrderDetailStatus.error,
    //         message: 'Error',
    //       );
    //     }
    //   } catch (e) {
    //     yield state.copyWith(
    //         detailStatus: CustomerOrderDetailStatus.error, message: e.toString());
    //   }
    // }
  }
}
