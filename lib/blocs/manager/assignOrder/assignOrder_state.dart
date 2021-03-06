import 'package:car_service/utils/model/AssignOrderModel.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/TestOrderModel.dart';
import 'package:equatable/equatable.dart';

enum AssignStatus {
  init,
  loading,
  assignSuccess,

  error,
}

enum AssignDetailStatus {
  init,
  loading,
  success,
  error,
}

class AssignOrderState extends Equatable {
  final AssignStatus status;
  final AssignDetailStatus detailStatus;

  final List<OrderDetailModel> assignList;
  final List<OrderDetailModel> assignDetail;
  final List<StaffModel> assignStaff;
  final String message;
  const AssignOrderState({
    this.status: AssignStatus.init,
    this.detailStatus: AssignDetailStatus.init,
    this.assignDetail: const [],
    this.assignList: const [],
    this.assignStaff: const [],
    this.message: '',
  });

  AssignOrderState copyWith({
    AssignStatus status,
    AssignDetailStatus detailStatus,
    List<OrderDetailModel> assignList,
    List<OrderDetailModel> assignDetail,
    List<StaffModel> assignStaff,
    String message,
  }) =>
      AssignOrderState(
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
