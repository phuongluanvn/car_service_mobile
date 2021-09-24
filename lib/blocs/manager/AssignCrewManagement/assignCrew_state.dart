import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/blocs/manager/EditCrewManagement%20copy/editCrew_state.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/accessory_model.dart';
import 'package:car_service/utils/model/createCrewModel.dart';
import 'package:equatable/equatable.dart';


enum DoAssignCrewStatus {
  init,
  loading,
  success,
  againsuccess,
  error,
}

enum DoListAssignCrewStatus {
  init,
  loading,
  success,

  error,
}


class AssignCrewState extends Equatable {
  final DoListAssignCrewStatus status;
  final DoAssignCrewStatus assignStatus;
  final List<CrewModel> assignCrewList;
  final List<CrewModel> crewAvailList;
  final List<CrewModel> crewDetails;
  final List<CreateCrewModel> createCrewList;
  final List<CreateCrewModel> editCrewList;
  final String message;
  AssignCrewState(
      {
        this.status: DoListAssignCrewStatus.init,
      this.assignStatus: DoAssignCrewStatus.init,
      this.assignCrewList: const [],
      this.crewAvailList: const [],
      this.createCrewList: const [],
      this.editCrewList: const [],
      this.crewDetails: const [],
      this.message: ''});

  AssignCrewState copyWith({
    
    DoAssignCrewStatus assignStatus,
    DoListAssignCrewStatus status,
    List<CrewModel> assignCrewList,
    List<CrewModel> crewAvailList,
    List<CreateCrewModel> createCrewList,
    List<CreateCrewModel> editCrewList,
    List<CrewModel> crewDetails,
    String message,
  }) =>
      AssignCrewState(
       status: status?? this.status,
        assignStatus: assignStatus ?? this.assignStatus,
        assignCrewList: assignCrewList ?? this.assignCrewList,
        crewAvailList: crewAvailList ?? this.crewAvailList,
        editCrewList: editCrewList ?? this.editCrewList,
        createCrewList: createCrewList ?? this.createCrewList,
        crewDetails: crewDetails ?? this.crewDetails,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        assignStatus,
      
        assignCrewList,
        crewAvailList,
        createCrewList,
        crewDetails,
        message,
        
        editCrewList
      ];
}
