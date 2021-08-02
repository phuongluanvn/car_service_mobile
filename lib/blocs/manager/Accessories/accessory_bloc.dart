import 'dart:convert';
import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_state.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccessoryBloc extends Bloc<AccessoryEvent, AccessoryState> {
  ManagerRepository _repo;

  AccessoryBloc({ManagerRepository repo})
      : _repo = repo,
        super(AccessoryState());

  @override
  Stream<AccessoryState> mapEventToState(AccessoryEvent event) async* {
    if (event is DoListAccessories) {
      yield state.copyWith(status: ListAccessoryStatus.loading);
      try {
        var data = await _repo.getAccessoryList();
        if (data != null) {
          print(data);
          yield state.copyWith(
              accessoryList: data, status: ListAccessoryStatus.success);
        } else {
          yield state.copyWith(
            status: ListAccessoryStatus.error,
            message: 'Assin Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          status: ListAccessoryStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
