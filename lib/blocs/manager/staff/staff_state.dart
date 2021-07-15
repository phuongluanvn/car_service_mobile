
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

enum StaffStatus {
  init,
  loading,
  staffListsuccess,
  staffDetailsuccess,
  error,
}

enum StaffDetailStatus {
  init,
  loading,
  success,
  error,
}

class ManageStaffState extends Equatable {
  final StaffStatus status;
  final StaffDetailStatus detailStatus;
  final List<StaffModel> staffList;
  final List<StaffModel> staffDetail;
  final String message;
  const ManageStaffState({
    this.status: StaffStatus.init,
    this.detailStatus: StaffDetailStatus.init,
    this.staffDetail: const [],
    this.staffList: const [],
    this.message: '',
  });

  ManageStaffState copyWith({
    StaffStatus status,
    StaffDetailStatus detailStatus,
    List<StaffModel> staffList,
    List<StaffModel> staffDetail,
    String message,
  }) =>
      ManageStaffState(
        status: status ?? this.status,
        detailStatus: detailStatus ?? this.detailStatus,
        staffList: staffList ?? this.staffList,
        staffDetail: staffDetail ?? this.staffDetail,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        staffList,
        staffDetail,
        message,
      ];
}
