import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

enum SelectStaffStatus {
  init,
  loading,
  success,
  error,
}

class SelectDataState extends Equatable {
  final SelectStaffStatus staffSelectStt;

  final List<StaffModel> staffSelect;

  final String message;
  const SelectDataState({
    this.staffSelectStt: SelectStaffStatus.init,
    this.staffSelect: const [],
    this.message: '',
  });

  SelectDataState copyWith({
    SelectStaffStatus staffSelectStt,
    List<StaffModel> staffSelect,
    String message,
  }) =>
      SelectDataState(
        staffSelectStt: staffSelectStt ?? this.staffSelectStt,
        staffSelect: staffSelect ?? this.staffSelect,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        staffSelectStt,
        staffSelect,
        message,
      ];
}
