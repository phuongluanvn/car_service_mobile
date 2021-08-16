import 'package:car_service/blocs/assignOrderReview/assignOrderReview_events.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'assignOrderReview_state.dart';

class AssignReviewBloc extends Bloc<AssignOrderReviewEvent, AssignReviewState> {
  ManagerRepository _repo;

  AssignReviewBloc({ManagerRepository repo})
      : _repo = repo,
        super(AssignReviewState());

  @override
  Stream<AssignReviewState> mapEventToState(
      AssignOrderReviewEvent event) async* {
    if (event is DoListAssignReviewEvent) {
      yield state.copyWith(status: AssignReviewStatus.loading);
      try {
        print('Check ass list 1');
        List<OrderDetailModel> assignList = await _repo.getAssingReviewList();
        if (assignList != null) {
          print(assignList);
          yield state.copyWith(
              assignList: assignList, status: AssignReviewStatus.assignSuccess);
        } else {
          yield state.copyWith(
            status: AssignReviewStatus.error,
            message: 'Assin Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          status: AssignReviewStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is DoAssignReviewDetailEvent) {
      yield state.copyWith(detailStatus: AssignReviewDetailStatus.loading);
      try {
        List<OrderDetailModel> data =
            await _repo.getVerifyOrderDetail(event.id);
        if (data != null) {
          yield state.copyWith(
            detailStatus: AssignReviewDetailStatus.success,
            assignDetail: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: AssignReviewDetailStatus.error,
            message: 'Detail Error',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: AssignReviewDetailStatus.error,
            message: e.toString());
      }
    }
  }
}
