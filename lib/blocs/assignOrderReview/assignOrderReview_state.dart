import 'package:car_service/utils/model/AssignOrderModel.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/TestOrderModel.dart';
import 'package:equatable/equatable.dart';

enum AssignReviewStatus {
  init,
  loading,
  assignSuccess,

  error,
}

enum AssignReviewDetailStatus {
  init,
  loading,
  success,
  error,
}

class AssignReviewState extends Equatable {
  final AssignReviewStatus status;
  final AssignReviewDetailStatus detailStatus;

  final List<OrderDetailModel> assignList;
  final List<OrderDetailModel> assignDetail;
  final List<StaffModel> assignStaff;
  final String message;
  const AssignReviewState({
    this.status: AssignReviewStatus.init,
    this.detailStatus: AssignReviewDetailStatus.init,
    this.assignDetail: const [],
    this.assignList: const [],
    this.assignStaff: const [],
    this.message: '',
  });

  AssignReviewState copyWith({
    AssignReviewStatus status,
    AssignReviewDetailStatus detailStatus,
    List<OrderDetailModel> assignList,
    List<OrderDetailModel> assignDetail,
    List<StaffModel> assignStaff,
    String message,
  }) =>
      AssignReviewState(
        status: status ?? this.status,
        detailStatus: detailStatus ?? this.detailStatus,
        assignList: assignList ?? this.assignList,
        assignDetail: assignDetail ?? this.assignDetail,
        assignStaff: assignStaff ?? this.assignStaff,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        assignList,
        assignDetail,
        assignStaff,
        message,
      ];
}
