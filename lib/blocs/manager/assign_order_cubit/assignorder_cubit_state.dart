import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

enum AssignCubitStatus {
  loading,
  loadingSuccess,
}

class AssignorderCubitState extends Equatable {
  final AssignCubitStatus status;
  final List<StaffModel> listStaff;
  const AssignorderCubitState({
    this.status: AssignCubitStatus.loadingSuccess,
    this.listStaff: const [],
  });

  AssignorderCubitState copyWith({
    AssignCubitStatus status,
    List<StaffModel> listStaff,
  }) =>
      AssignorderCubitState(
        status: status ?? this.status,
        listStaff: listStaff ?? this.listStaff,
      );

  @override
  List<Object> get props => [status, listStaff];
}
