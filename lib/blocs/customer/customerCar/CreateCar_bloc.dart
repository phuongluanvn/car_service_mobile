import 'dart:convert';

import 'package:car_service/blocs/customer/customerCar/CreateCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CreateCar_state.dart';
import 'package:car_service/blocs/sign_up/sign_up_events.dart';
import 'package:car_service/blocs/sign_up/sign_up_state.dart';
import 'package:car_service/utils/repository/auth_repo.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateCarBloc extends Bloc<CreateCarEvent, CreateCarState> {
  CustomerRepository _repo;

  CreateCarBloc({CustomerRepository repo})
      : _repo = repo,
        super(CreateCarState());


  @override
  Stream<CreateCarState> mapEventToState(CreateCarEvent event) async* {
    if (event is CreateCarButtonPressed) {
      yield state.copyWith(status: CreateCarStatus.loading);
      try{
        var data = await _repo.createCar(event.manufacturer, event.model, event.licensePlateNumber);
      String jsonsDataString = data.toString();
      print(data);
      final jsonData = jsonDecode(jsonsDataString);
      print(jsonData);
      if (jsonData != null) {
       
        yield state.copyWith(status: CreateCarStatus.createCarSuccess);
      } else {
        yield state.copyWith(
          status: CreateCarStatus.error,
          message: 'Error SignUp');
      }
      }catch(e){
        yield state.copyWith(
          status: CreateCarStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
