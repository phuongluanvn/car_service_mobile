import 'dart:convert';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignOrderBloc extends Bloc<AssignOrderEvent, AssignOrderState> {
  ManagerRepository repo;
  AssignOrderBloc(AssignOrderState initialState, this.repo)
      : super(initialState);

  @override
  Stream<AssignOrderState> mapEventToState(AssignOrderEvent event) async* {
    if (event is DoListAssignOrderEvent) {
      yield AssignOrderLoadingState();
      try {
        var orderList = await repo.getOrderList();
        if (orderList != null) {
          yield AssignOrderSuccessState(orderList: orderList);
          print('dada');
        } else {
          yield AssignOrderLoadingState();
          print('no data');
        }
      } catch (e) {
        yield AssignOrderErrorState(message: e.toString());
      }
    }
  }
}
