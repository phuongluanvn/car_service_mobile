import 'dart:async';
import 'package:car_service/blocs/manager/updateItem/updateItem_state.dart';
import 'package:car_service/blocs/manager/updateItem/updateItem_event.dart';
import 'package:bloc/bloc.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateItemBloc extends Bloc<UpdateItemEvent, UpdateItemState> {
  ManagerRepository _repo;

  UpdateItemBloc({ManagerRepository repo})
      : _repo = repo,
        super(UpdateItemState());
  @override
  Stream<UpdateItemState> mapEventToState(
    UpdateItemEvent event,
  ) async* {
    if (event is DeleteServiceByIdEvent) {
      yield state.copyWith(
        deleteStatus: DeleteByIdStatus.loading,
      );
      try {
        // for (int i = 0; i <= event.selectedTaskId.length; i++) {
        var data = await _repo.deleteItemById(event.detailId);

        if (data != null) {
          // DoProcessOrderDetailEvent(email: event.orderId);
          yield state.copyWith(
            deleteStatus: DeleteByIdStatus.success,
          );
          print('Delete success!!!');
        } else {
          yield state.copyWith(
            deleteStatus: DeleteByIdStatus.error,
            message: 'Error',
          );
          // }
        }
        ;
      } catch (e) {
        yield state.copyWith(
            deleteStatus: DeleteByIdStatus.error, message: e.toString());
      }
    }if (event is DoListServices) {
      yield state.copyWith(listServiceStatus: ListServiceStatus.loading);
      try {
        var data = await _repo.getServiceList();
        if (data != null) {
          // print(data);
          yield state.copyWith(
              listServices: data, listServiceStatus: ListServiceStatus.success);
        } else {
          yield state.copyWith(
            listServiceStatus: ListServiceStatus.error,
            message: 'Assin Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          listServiceStatus: ListServiceStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
