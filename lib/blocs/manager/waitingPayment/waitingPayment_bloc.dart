import 'package:car_service/blocs/manager/waitingPayment/waitingPayment_events.dart';
import 'package:car_service/blocs/manager/waitingPayment/waitingPayment_state.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaitingPaymentBloc
    extends Bloc<WaitingPaymentEvent, WaitingPaymentState> {
  ManagerRepository _repo;

  WaitingPaymentBloc({ManagerRepository repo})
      : _repo = repo,
        super(WaitingPaymentState());

  @override
  Stream<WaitingPaymentState> mapEventToState(
      WaitingPaymentEvent event) async* {
    if (event is DoListWaitingPaymentEvent) {
      yield state.copyWith(status: WaitingPaymentStatus.loading);
      try {
        List<OrderDetailModel> historyList =
            await _repo.getWaitingPaymentList();
        if (historyList != null) {
          yield state.copyWith(
              waitingPaymentList: historyList,
              status: WaitingPaymentStatus.waitingPaymentSuccess);
        } else {
          yield state.copyWith(
            status: WaitingPaymentStatus.error,
            message: 'Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          status: WaitingPaymentStatus.error,
          message: e.toString(),
        );
        ;
      }
    } else if (event is DoWaitingPaymentDetailEvent) {
      yield state.copyWith(detailStatus: WaitingPaymentDetailStatus.loading);
      try {
        print('check 1: ' + event.id);
        List<OrderDetailModel> data =
            await _repo.getVerifyOrderDetail(event.id);
        if (data != null) {
          print("Not null");
          yield state.copyWith(
            detailStatus: WaitingPaymentDetailStatus.success,
            waitingPaymentDetail: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: WaitingPaymentDetailStatus.error,
            message: 'Detail Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: WaitingPaymentDetailStatus.error,
            message: e.toString());
      }
    }
  }
}
