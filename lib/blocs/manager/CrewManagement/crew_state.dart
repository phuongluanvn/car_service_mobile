import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/accessory_model.dart';
import 'package:car_service/utils/model/createCrewModel.dart';
import 'package:equatable/equatable.dart';

enum ListCrewStatus {
  init,
  loading,
  success,
  error,
}

enum DoCrewDetailStatus {
  init,
  loading,
  success,
  error,
}

enum DoUpdateStatus {
  init,
  loading,
  success,
  error,
}

enum CreateCrewStatus {
  init,
  loading,
  success,
  error,
}

class CrewState extends Equatable {
  final ListCrewStatus status;
  final DoCrewDetailStatus statusDetail;
  final CreateCrewStatus createStatus;
  final DoUpdateStatus updateStatus;
  final List<CrewModel> crewList;
  final List<CreateCrewModel> createCrewList;
  final String message;
  CrewState(
      {this.status: ListCrewStatus.init,
      this.statusDetail: DoCrewDetailStatus.init,
      this.createStatus: CreateCrewStatus.init,
      this.updateStatus: DoUpdateStatus.init,
      this.crewList: const [],
      this.createCrewList: const [],
      this.message: ''});

  CrewState copyWith({
    ListCrewStatus status,
    DoCrewDetailStatus statusDetail,
    DoUpdateStatus updateStatus,
    CreateCrewStatus createStatus,
    List<CrewModel> crewList,
    List<CreateCrewModel> createCrewList,
    String message,
  }) =>
      CrewState(
        status: status ?? this.status,
        statusDetail: statusDetail ?? this.statusDetail,
        createStatus: createStatus ?? this.createStatus,
        updateStatus: updateStatus ?? this.updateStatus,
        crewList: crewList ?? this.crewList,
        createCrewList: createCrewList ?? this.createCrewList,
        message: message ?? this.message,
      );
  @override
  List<Object> get props =>
      [status, updateStatus, createStatus,crewList, createCrewList, message, statusDetail];
}
