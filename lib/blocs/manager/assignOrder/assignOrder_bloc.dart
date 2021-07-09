import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/utils/model/AssignOrderModel.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'assignOrder_state.dart';

class AssignOrderBloc extends Bloc<AssignOrderEvent, AssignOrderState> {
  ManagerRepository _repo;

  AssignOrderBloc({ManagerRepository repo})
      : _repo = repo,
        super(AssignOrderState());

  @override
  Stream<AssignOrderState> mapEventToState(AssignOrderEvent event) async* {
    if (event is DoListAssignOrderEvent) {
      yield state.copyWith(status: AssignStatus.loading);
      try {
        var assignList = await _repo.getBookingOrderList();
        if (assignList != null) {
          yield state.copyWith(
              assignList: assignList, status: AssignStatus.assignSuccess);
          print('dada');
        } else {
          yield state.copyWith(
            status: AssignStatus.error,
            message: 'Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          status: AssignStatus.error,
          message: e.toString(),
        );
        ;
      }
    } else if (event is DoAssignOrderDetailEvent) {
      yield state.copyWith(detailStatus: AssignDetailStatus.loading);
      try {
        List<AssignOrderModel> data = await _repo.getOrderDetail(event.email);
        if (data != null) {
          yield state.copyWith(
            detailStatus: AssignDetailStatus.success,
            assignDetail: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: AssignDetailStatus.error,
            message: 'Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: AssignDetailStatus.error, message: e.toString());
      }
    }
  }
}
