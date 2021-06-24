
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/utils/model/AssignOrderModel.dart';
import 'package:car_service/utils/model/BookingModel.dart';
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
        var assignList = await _repo.getOrderList();
        if (assignList != null) {
          yield state.copyWith(
              processList: assignList, status: ProcessStatus.processSuccess);
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
        List<AssignOrderModel> data = await _repo.getOrderDetail(event.email);
        if (data != null) {
          yield state.copyWith(
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
  }
}
