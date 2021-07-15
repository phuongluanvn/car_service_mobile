import 'package:car_service/blocs/manager/orderHistory/orderHistory_events.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'orderHistory_state.dart';
import 'orderHistory_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  ManagerRepository _repo;

  OrderHistoryBloc({ManagerRepository repo})
      : _repo = repo,
        super(OrderHistoryState());

  @override
  Stream<OrderHistoryState> mapEventToState(OrderHistoryEvent event) async* {
    if (event is DoListOrderHistoryEvent) {
      yield state.copyWith(status: OrderHistoryStatus.loading);
      try {
        List<OrderDetailModel> historyList = await _repo.getOrderHistoryList();
        if (historyList != null) {
          yield state.copyWith(
              historyList: historyList,
              status: OrderHistoryStatus.historySuccess);
        } else {
          yield state.copyWith(
            status: OrderHistoryStatus.error,
            message: 'Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          status: OrderHistoryStatus.error,
          message: e.toString(),
        );
        ;
      }
    } else if (event is DoOrderHistoryDetailEvent) {
      yield state.copyWith(detailStatus: OrderHistoryDetailStatus.loading);
      try {
        print('check 1: ' + event.id);
        List<OrderDetailModel> data =
            await _repo.getVerifyOrderDetail(event.id);
        if (data != null) {
          print("Not null");
          yield state.copyWith(
            detailStatus: OrderHistoryDetailStatus.success,
            historyDetail: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: OrderHistoryDetailStatus.error,
            message: 'Detail Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: OrderHistoryDetailStatus.error,
            message: e.toString());
      }
    }
    // else if (event is UpdateStatusButtonPressed) {
    //   // yield state.copyWith(detailStatus: BookingDetailStatus.loading);
    //   try {
    //     print('check 2: ' + event.id);
    //     var data =
    //         await _repo.updateStatusOrder(event.id, event.status);
    //         print(data);
    //     if (data != null) {
    //       print("Update Success");
    //       yield state.copyWith(
    //         detailStatus: BookingDetailStatus.updateStatusSuccess,
    //       );
    //     } else {
    //       yield state.copyWith(
    //         detailStatus: BookingDetailStatus.error,
    //         message: 'Update Error',
    //       );
    //     }
    //   } catch (e) {
    //     yield state.copyWith(
    //         detailStatus: BookingDetailStatus.error, message: e.toString());
    //   }
    // }
  }
}
