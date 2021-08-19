import 'package:car_service/blocs/manager/processOrder/updateFinishTask_event.dart';
import 'package:car_service/blocs/manager/processOrder/updateFinishTask_state.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'processOrder_state.dart';

class UpdateFinishTaskBloc
    extends Bloc<UpdateFinishTaskEvent, UpdateFinishTaskState> {
  ManagerRepository _repo;

  UpdateFinishTaskBloc({ManagerRepository repo})
      : _repo = repo,
        super(UpdateFinishTaskState());

  @override
  Stream<UpdateFinishTaskState> mapEventToState(
      UpdateFinishTaskEvent event) async* {
    // if (event is DoListProcessOrderEvent) {
    //   yield state.copyWith(status: ProcessStatus.loading);
    //   try {
    //     var assignList = await _repo.getProcessOrderList();
    //     if (assignList != null) {
    //       yield state.copyWith(
    //         processList: assignList,
    //         status: ProcessStatus.processSuccess,
    //       );
    //       print('dada');
    //     } else {
    //       yield state.copyWith(
    //         status: ProcessStatus.error,
    //         message: 'Error',
    //       );
    //       print('no data');
    //     }
    //   } catch (e) {
    //     yield state.copyWith(
    //       status: ProcessStatus.error,
    //       message: e.toString(),
    //     );
    //     ;
    //   }
    // } else if (event is DoProcessOrderDetailEvent) {
    //   yield state.copyWith(detailStatus: ProcessDetailStatus.loading);
    //   try {
    //     List<OrderDetailModel> data =
    //         await _repo.getVerifyOrderDetail(event.email);
    //     if (data != null) {
    //       yield state.copyWith(
    //         updateAccIdStatus: UpdateAccIdStatus.init,
    //         detailStatus: ProcessDetailStatus.success,
    //         processDetail: data,
    //       );
    //     } else {
    //       yield state.copyWith(
    //         detailStatus: ProcessDetailStatus.error,
    //         message: 'Error',
    //       );
    //     }
    //   } catch (e) {
    //     yield state.copyWith(
    //         detailStatus: ProcessDetailStatus.error, message: e.toString());
    //   }
    // } else
    if (event is DoTaskrDetailEvent) {
      yield state.copyWith(
        taskDetailStatus: TaskDetailStatus.loading,
      );
      try {
        List<OrderDetailModel> data =
            await _repo.getVerifyOrderDetail(event.id);
        if (data != null) {
          yield state.copyWith(
            taskDetailStatus: TaskDetailStatus.success,
            taskDetail: data,
          );
        } else {
          yield state.copyWith(
            taskDetailStatus: TaskDetailStatus.error,
            message: 'Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            taskDetailStatus: TaskDetailStatus.error, message: e.toString());
      }
    }
    if (event is UpdateFinishedTaskOrderEvent) {
      yield state.copyWith(
        updateFinishIdStatus: UpdateFinishIdStatus.loading,
      );
      try {
        // for (int i = 0; i <= event.selectedTaskId.length; i++) {
        var data =
            await _repo.updateStatusTask(event.selectedTaskId, event.selected);

        if (data != null) {
          print('task event');
          // DoProcessOrderDetailEvent(email: event.orderId);
          yield state.copyWith(
            updateFinishIdStatus: UpdateFinishIdStatus.success,
          );
          print('Task updated');
        } else {
          yield state.copyWith(
            updateFinishIdStatus: UpdateFinishIdStatus.error,
            message: 'Error',
          );
          // }
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
