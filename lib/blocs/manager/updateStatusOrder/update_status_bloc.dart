import 'dart:convert';

import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateStatusOrderBloc extends Bloc<UpdateStatusOrderEvent, UpdateStatusOrderState> {
  ManagerRepository _repo;

  UpdateStatusOrderBloc({ManagerRepository repo})
      : _repo = repo,
        super(UpdateStatusOrderState());


  @override
  Stream<UpdateStatusOrderState> mapEventToState(UpdateStatusOrderEvent event) async* {
    if (event is UpdateStatusButtonPressed) {
      yield state.copyWith(status: UpdateStatus.loading);
      try{
        var data = await _repo.updateStatusOrder(event.id, event.status);
      // String jsonsDataString = data.toString();
      print(data);
      // final jsonData = jsonDecode(jsonsDataString);
      // print(jsonData);
      if (data != null) {
       
        yield state.copyWith(status: UpdateStatus.updateStatusSuccess);
      } else {
        yield state.copyWith(
          status: UpdateStatus.error,
          message: 'Error Update');
      }
      }catch(e){
        yield state.copyWith(
          status: UpdateStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
