import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

enum ProcessCubitStatus {
  loading,
  loadingSuccess,
}

class ProcessorderCubitState extends Equatable {
  final ProcessCubitStatus status;
  final List<StaffModel> listStaff;
  const ProcessorderCubitState({
    this.status: ProcessCubitStatus.loadingSuccess,
    this.listStaff: const [],
  });

  ProcessorderCubitState copyWith({
    ProcessCubitStatus status,
    List<StaffModel> listStaff,
  }) =>
      ProcessorderCubitState(
        status: status ?? this.status,
        listStaff: listStaff ?? this.listStaff,
      );

  @override
  List<Object> get props => [status, listStaff];
}
