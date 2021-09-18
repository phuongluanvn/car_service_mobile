import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/blocs/manager/EditCrewManagement%20copy/editCrew_state.dart';
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

enum UpdateCrewStatus {
  init,
  loading,
  success,
  error,
}

class CrewState extends Equatable {
  final ListCrewStatus status;
  final DoCrewDetailStatus statusDetail;
  final CreateCrewStatus createStatus;
  final UpdateCrewStatus updateCrewStatus;
  final DoUpdateStatus updateStatus;
  final List<CrewModel> crewList;
  final List<CrewModel> crewDetails;
  final List<CreateCrewModel> createCrewList;
  final List<CreateCrewModel> editCrewList;
  final String message;
  CrewState(
      {this.status: ListCrewStatus.init,
      this.updateCrewStatus: UpdateCrewStatus.init,
      this.statusDetail: DoCrewDetailStatus.init,
      this.createStatus: CreateCrewStatus.init,
      this.updateStatus: DoUpdateStatus.init,
      this.crewList: const [],
      this.createCrewList: const [],
      this.editCrewList: const [],
      this.crewDetails: const [],
      this.message: ''});

  CrewState copyWith({
    ListCrewStatus status,
    DoCrewDetailStatus statusDetail,
    UpdateCrewStatus updateCrewStatus,
    DoUpdateStatus updateStatus,
    CreateCrewStatus createStatus,
    List<CrewModel> crewList,
    List<CreateCrewModel> createCrewList,
    List<CreateCrewModel> editCrewList,
    List<CrewModel> crewDetails,
    String message,
  }) =>
      CrewState(
        status: status ?? this.status,
        updateCrewStatus: updateCrewStatus ?? this.updateCrewStatus,
        statusDetail: statusDetail ?? this.statusDetail,
        createStatus: createStatus ?? this.createStatus,
        updateStatus: updateStatus ?? this.updateStatus,
        crewList: crewList ?? this.crewList,
        editCrewList: editCrewList ?? this.editCrewList,
        createCrewList: createCrewList ?? this.createCrewList,
        crewDetails: crewDetails ?? this.crewDetails,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        updateStatus,
        updateCrewStatus,
        createStatus,
        crewList,
        createCrewList,
        crewDetails,
        message,
        statusDetail,
        editCrewList
      ];
}
