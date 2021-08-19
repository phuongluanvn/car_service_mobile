import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

enum ProcessStatus {
  init,
  loading,
  processSuccess,

  assignStaffSuccess,
  error,
}

enum ProcessDetailStatus {
  init,
  loading,
  success,
  error,
}

enum UpdateAccIdStatus {
  init,
  loading,
  success,
  error,
}

enum UpdateCrewStatus {
  init,
  loading,
  success,
  error,
}

class ProcessOrderState extends Equatable {
  final ProcessStatus status;
  final ProcessDetailStatus detailStatus;
  final UpdateAccIdStatus updateAccIdStatus;
  final UpdateCrewStatus updateCrewStatus;
  final List<OrderDetailModel> processList;
  final List<OrderDetailModel> processDetail;
  final List<StaffModel> assignStaff;
  final String message;
  const ProcessOrderState({
    this.status: ProcessStatus.init,
    this.updateCrewStatus: UpdateCrewStatus.init,
    this.detailStatus: ProcessDetailStatus.init,
    this.updateAccIdStatus: UpdateAccIdStatus.init,
    // this.updateFinishIdStatus: UpdateFinishIdStatus.init,
    this.processDetail: const [],
    this.processList: const [],
    this.assignStaff: const [],
    this.message: '',
  });

  ProcessOrderState copyWith({
    ProcessStatus status,
    ProcessDetailStatus detailStatus,
    UpdateAccIdStatus updateAccIdStatus,
    UpdateCrewStatus updateCrewStatus,
    List<OrderDetailModel> processList,
    List<OrderDetailModel> processDetail,
    List<StaffModel> assignStaff,
    String message,
  }) =>
      ProcessOrderState(
        status: status ?? this.status,
        detailStatus: detailStatus ?? this.detailStatus,
        updateAccIdStatus: updateAccIdStatus ?? this.updateAccIdStatus,
        updateCrewStatus: updateCrewStatus?? this.updateCrewStatus,
        // updateFinishIdStatus: updateFinishIdStatus ?? this.updateFinishIdStatus,
        processList: processList ?? this.processList,
        processDetail: processDetail ?? this.processDetail,
        assignStaff: assignStaff ?? this.assignStaff,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        updateAccIdStatus,
        updateCrewStatus,
        // updateFinishIdStatus,
        processList,
        processDetail,
        assignStaff,
        message,
      ];
}
