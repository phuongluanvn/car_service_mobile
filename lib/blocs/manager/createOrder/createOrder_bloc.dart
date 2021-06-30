import 'dart:convert';
import 'package:car_service/blocs/manager/createOrder/createOrder_event.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_state.dart';
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
      try{
        var data = await _repo.createOrder(event.manufacturer, event.licensePlateNumber);
      String jsonsDataString = data.toString();
      print(data);
      final jsonData = jsonDecode(jsonsDataString);
      print(jsonData);
      if (jsonData != null) {
       
        yield state.copyWith(status: CreateOrderStatus.createOrderSuccess);
      } else {
        yield state.copyWith(
          status: CreateOrderStatus.error,
          message: 'Error SignUp');
      }
      }catch(e){
        yield state.copyWith(
          status: CreateOrderStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
