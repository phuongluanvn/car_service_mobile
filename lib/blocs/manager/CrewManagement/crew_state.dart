import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/accessory_model.dart';
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

class CrewState extends Equatable {
  final ListCrewStatus status;
  final DoCrewDetailStatus statusDetail;
  final DoUpdateStatus updateStatus;
  final List<CrewModel> crewList;
  final String message;
  CrewState(
      {this.status: ListCrewStatus.init,
      this.statusDetail: DoCrewDetailStatus.init,
      this.updateStatus: DoUpdateStatus.init,
      this.crewList: const [],
      this.message: ''});

  CrewState copyWith({
    ListCrewStatus status,
    DoCrewDetailStatus statusDetail,
    DoUpdateStatus updateStatus,
    List<CrewModel> crewList,
    String message,
  }) =>
      CrewState(
        status: status ?? this.status,
        statusDetail: statusDetail ?? this.statusDetail,
        updateStatus: updateStatus ?? this.updateStatus,
        crewList: crewList ?? this.crewList,
        message: message ?? this.message,
      );
  @override
  List<Object> get props =>
      [status, updateStatus, crewList, message, statusDetail];
}
