import 'dart:convert';
import 'package:car_service/blocs/manager/createOrder/createOrder_event.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_state.dart';
import 'package:car_service/utils/model/CustomerModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  ManagerRepository _repo;

  CreateOrderBloc({ManagerRepository repo})
      : _repo = repo,
        super(CreateOrderState());

  @override
  Stream<CreateOrderState> mapEventToState(CreateOrderEvent event) async* {
    if (event is CreateOrderButtonPressed) {
      yield state.copyWith(status: CreateOrderStatus.loading);
      try {
        var data = await _repo.createOrder(
            event.carId, event.serviceId, event.note, event.timeBooking);
        String jsonsDataString = data.toString();
        // final jsonData = jsonDecode(jsonsDataString);
        if (data != null) {
          yield state.copyWith(
            message: data.body,
            status: CreateOrderStatus.createOrderSuccess);
        } else {
          yield state.copyWith(
              status: CreateOrderStatus.error, message: 'Không thêm được lịch');
        }
      } catch (e) {
        yield state.copyWith(
          status: CreateOrderStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is DoCreateOrderDetailEvent) {
      yield state.copyWith(detailStatus: CreateDetailStatus.loading);
      try {
        List<CustomerModel> data = await _repo.getCreateOrderDetail(event.id);
        if (data != null) {
          yield state.copyWith(
            detailStatus: CreateDetailStatus.success,
            listCus: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: CreateDetailStatus.error,
            message: 'Detail Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: CreateDetailStatus.error, message: e.toString());
      }
    }
  }
}
