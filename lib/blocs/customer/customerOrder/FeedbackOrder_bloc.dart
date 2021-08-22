import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/blocs/customer/customerOrder/FeedbackOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/FeedbackOrder_state.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/OrderModel.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackOrderBloc extends Bloc<FeedbackOrderEvent, FeedbackOrderState> {
  CustomerRepository _repo;

  FeedbackOrderBloc({CustomerRepository repo})
      : _repo = repo,
        super(FeedbackOrderState());

  @override
  Stream<FeedbackOrderState> mapEventToState(FeedbackOrderEvent event) async* {
    if (event is DoFeedbackButtonPressed) {
      yield state.copyWith(status: FeedbackOrderStatus.loading);
      try {
        var data = await _repo.sendFeedbackOrder(
            event.ordeId, event.rating, event.description);
        if (data != null) {
          yield state.copyWith(
              message: data, status: FeedbackOrderStatus.successFeedback);
        } else {
          yield state.copyWith(
            status: FeedbackOrderStatus.error,
            message: 'Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          status: FeedbackOrderStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
