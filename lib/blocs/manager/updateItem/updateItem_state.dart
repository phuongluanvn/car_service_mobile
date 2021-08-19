import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/ServiceModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

enum DeleteByIdStatus {
  init,
  loading,
  success,
  error,
}

enum ListServiceStatus {
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
  final ListServiceStatus listServiceStatus;
  final List<ServiceModel> listServices;
  final List<OrderDetailModel> taskDetail;
  final String message;
  const UpdateItemState({
    // this.taskDetailStatus: TaskDetailStatus.init,
    this.deleteStatus: DeleteByIdStatus.init,
    this.listServiceStatus: ListServiceStatus.init,
    this.taskDetail: const [],
    this.listServices: const [],
    this.message: '',
  });

  UpdateItemState copyWith({
    // TaskDetailStatus taskDetailStatus,
    ListServiceStatus listServiceStatus,
    DeleteByIdStatus deleteStatus,
    final List<ServiceModel> listServices,
    List<OrderDetailModel> taskDetail,
    String message,
  }) =>
      UpdateItemState(
        // taskDetailStatus: taskDetailStatus ?? this.taskDetailStatus,
        listServiceStatus: listServiceStatus?? this.listServiceStatus,
        deleteStatus: deleteStatus ?? this.deleteStatus,
        taskDetail: taskDetail ?? this.taskDetail,
        listServices: listServices ?? this.listServices,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        listServiceStatus,
        deleteStatus,
        listServices,
        taskDetail,
        message,
      ];
}
