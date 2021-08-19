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

enum StaffSelectStatus {
  init,
  loading,
  success,
  error,
}

class ManageStaffState extends Equatable {
  final StaffStatus status;
  final StaffDetailStatus detailStatus;
  final StaffSelectStatus staffSelectStt;

  final List<StaffModel> staffList;
  final List<StaffModel> staffDetail;
  final List<StaffModel> staffSelect;

  final String message;
  const ManageStaffState({
    this.status: StaffStatus.init,
    this.detailStatus: StaffDetailStatus.init,
    this.staffSelectStt: StaffSelectStatus.init,
    this.staffSelect: const [],
    this.staffDetail: const [],
    this.staffList: const [],
    this.message: '',
  });

  ManageStaffState copyWith({
    StaffStatus status,
    StaffDetailStatus detailStatus,
    StaffSelectStatus staffSelectStt,
    List<StaffModel> staffList,
    List<StaffModel> staffDetail,
    List<StaffModel> staffSelect,
    String message,
  }) =>
      ManageStaffState(
        status: status ?? this.status,
        detailStatus: detailStatus ?? this.detailStatus,
        staffSelectStt: staffSelectStt ?? this.staffSelectStt,
        staffList: staffList ?? this.staffList,
        staffDetail: staffDetail ?? this.staffDetail,
        staffSelect: staffSelect ?? this.staffSelect,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        staffSelectStt,
        staffList,
        staffDetail,
        staffSelect,
        message,
      ];
}
