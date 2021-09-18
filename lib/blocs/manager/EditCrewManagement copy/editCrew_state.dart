import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/createCrewModel.dart';
import 'package:equatable/equatable.dart';

enum EditCrewStatus {
  init,
  loading,
  success,
  error,
}

class EditCrewState extends Equatable {
  final bool loadSelectedListSuccess;
  final bool loadUnselectedListSuccess;
  final EditCrewStatus status;
  final List<CreateCrewModel> selectedList;
  final List<CreateCrewModel> unselectedList;
  final String message;
  EditCrewState(
      {this.status: EditCrewStatus.init,
      this.loadSelectedListSuccess: false,
      this.loadUnselectedListSuccess: false,
      this.selectedList: const [],
      this.unselectedList: const [],
      this.message: ''});

  EditCrewState copyWith({
    EditCrewStatus status,
    bool loadSelectedListSuccess,
    bool loadUnselectedListSuccess,
    List<CreateCrewModel> selectedList,
    List<CreateCrewModel> unselectedList,
    String message,
  }) {
    bool loadSelected = loadSelectedListSuccess ?? this.loadSelectedListSuccess;
    bool loadUnselected =
        loadUnselectedListSuccess ?? this.loadUnselectedListSuccess;
    EditCrewStatus sstatus = EditCrewStatus.loading;
    if (loadSelected == true && loadUnselected == true) {
      sstatus = EditCrewStatus.success;
    }
    print(status);
    return EditCrewState(
      status: status ?? sstatus,
      loadSelectedListSuccess:
          loadSelectedListSuccess ?? this.loadSelectedListSuccess,
      loadUnselectedListSuccess:
          loadUnselectedListSuccess ?? this.loadUnselectedListSuccess,
      selectedList: selectedList ?? this.selectedList,
      unselectedList: unselectedList ?? this.unselectedList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        loadUnselectedListSuccess,
        loadSelectedListSuccess,
        selectedList,
        unselectedList,
        message
      ];
}
