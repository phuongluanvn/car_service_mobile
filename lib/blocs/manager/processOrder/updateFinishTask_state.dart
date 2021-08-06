import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

enum UpdateFinishIdStatus {
  init,
  loading,
  success,
  error,
}
enum TaskDetailStatus {
  init,
  loading,
  success,
  error,
}

class UpdateFinishTaskState extends Equatable {
  final TaskDetailStatus taskDetailStatus;
  final UpdateFinishIdStatus updateFinishIdStatus;
  final List<OrderDetailModel> processList;
  final List<OrderDetailModel> taskDetail;
  final List<StaffModel> assignStaff;
  final String message;
  const UpdateFinishTaskState({
    this.taskDetailStatus: TaskDetailStatus.init,
    this.updateFinishIdStatus: UpdateFinishIdStatus.init,
    this.taskDetail: const [],
    this.processList: const [],
    this.assignStaff: const [],
    this.message: '',
  });

  UpdateFinishTaskState copyWith({
    TaskDetailStatus taskDetailStatus,
    UpdateFinishIdStatus updateFinishIdStatus,
    List<OrderDetailModel> processList,
    List<OrderDetailModel> taskDetail,
    List<StaffModel> assignStaff,
    String message,
  }) =>
      UpdateFinishTaskState(
        taskDetailStatus: taskDetailStatus ?? this.taskDetailStatus,
        updateFinishIdStatus: updateFinishIdStatus ?? this.updateFinishIdStatus,
        processList: processList ?? this.processList,
        taskDetail: taskDetail ?? this.taskDetail,
        assignStaff: assignStaff ?? this.assignStaff,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        taskDetailStatus,
        updateFinishIdStatus,
        processList,
        taskDetail,
        assignStaff,
        message,
      ];
}
