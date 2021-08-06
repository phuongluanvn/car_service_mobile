import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'processOrder_state.dart';

class ProcessOrderBloc extends Bloc<ProcessOrderEvent, ProcessOrderState> {
  ManagerRepository _repo;

  ProcessOrderBloc({ManagerRepository repo})
      : _repo = repo,
        super(ProcessOrderState());

  @override
  Stream<ProcessOrderState> mapEventToState(ProcessOrderEvent event) async* {
    if (event is DoListProcessOrderEvent) {
      yield state.copyWith(status: ProcessStatus.loading);
      try {
        var assignList = await _repo.getProcessOrderList();
        if (assignList != null) {
          yield state.copyWith(
            processList: assignList,
            status: ProcessStatus.processSuccess,
          );
          print('dada');
        } else {
          yield state.copyWith(
            status: ProcessStatus.error,
            message: 'Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          status: ProcessStatus.error,
          message: e.toString(),
        );
        ;
      }
    } else if (event is DoProcessOrderDetailEvent) {
      yield state.copyWith(detailStatus: ProcessDetailStatus.loading);
      try {
        List<OrderDetailModel> data =
            await _repo.getVerifyOrderDetail(event.email);
        if (data != null) {
          yield state.copyWith(
            updateAccIdStatus: UpdateAccIdStatus.init,
            detailStatus: ProcessDetailStatus.success,
            processDetail: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: ProcessDetailStatus.error,
            message: 'Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: ProcessDetailStatus.error, message: e.toString());
      }
    } 
    else if (event is UpdateAccesIdToOrder) {
      yield state.copyWith(
        updateAccIdStatus: UpdateAccIdStatus.loading,
      );
      try {
        var data = await _repo.updateAccIdToOrder(event.orderId, event.detailId,
            event.serviceId, event.accId, event.quantity, event.price);

        if (data != null) {
          yield state.copyWith(
            updateAccIdStatus: UpdateAccIdStatus.success,
          );
          print('AccId updated');
        } else {
          yield state.copyWith(
            updateAccIdStatus: UpdateAccIdStatus.error,
            message: 'Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            updateAccIdStatus: UpdateAccIdStatus.error, message: e.toString());
      }
    } else if (event is UpdateFinishedTaskOrderEvent) {
      yield state.copyWith(
        updateFinishIdStatus: UpdateFinishIdStatus.loading,
      );
      try {
        for (int i = 0; i <= event.selectedTaskId.length; i++) {
          var data = await _repo.updateStatusTask(event.selectedTaskId[i].id);

          if (data != null) {
            print('task event');
            yield state.copyWith(
              updateFinishIdStatus: UpdateFinishIdStatus.success,
            );
            print('Task updated');
          } else {
            yield state.copyWith(
              updateFinishIdStatus: UpdateFinishIdStatus.error,
              message: 'Error',
            );
          }
        }
        ;
      } catch (e) {
        yield state.copyWith(
            updateFinishIdStatus: UpdateFinishIdStatus.error,
            message: e.toString());
      }
    }
  }
}
