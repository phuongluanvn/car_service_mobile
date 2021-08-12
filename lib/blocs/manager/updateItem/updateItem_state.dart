import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

enum DeleteByIdStatus {
  init,
  loading,
  success,
  error,
}
// enum TaskDetailStatus {
//   init,
//   loading,
//   success,
//   error,
// }

class UpdateItemState extends Equatable {
  // final TaskDetailStatus taskDetailStatus;
  final DeleteByIdStatus deleteStatus;

  final List<OrderDetailModel> taskDetail;
  final String message;
  const UpdateItemState({
    // this.taskDetailStatus: TaskDetailStatus.init,
    this.deleteStatus: DeleteByIdStatus.init,
    this.taskDetail: const [],
    this.message: '',
  });

  UpdateItemState copyWith({
    // TaskDetailStatus taskDetailStatus,
    DeleteByIdStatus deleteStatus,
    List<OrderDetailModel> taskDetail,
    String message,
  }) =>
      UpdateItemState(
        // taskDetailStatus: taskDetailStatus ?? this.taskDetailStatus,
        deleteStatus: deleteStatus ?? this.deleteStatus,
        taskDetail: taskDetail ?? this.taskDetail,

        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        deleteStatus,
        taskDetail,
        message,
      ];
}
