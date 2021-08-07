import 'package:car_service/utils/model/VehicleModel.dart';
import 'package:equatable/equatable.dart';
import '../../../utils/model/CarModel.dart';

enum CarDeleteStatus { init, loading, error, deleteDetailSuccess }

enum CustomerCarUpdateDetailStatus {
  init,
  loading,
  error,
  updateDetailSuccess,
}

class DeleteCarState extends Equatable {
  final CarDeleteStatus deleteStatus;
  final String message;
  const DeleteCarState({
    this.deleteStatus: CarDeleteStatus.init,
    this.message: '',
  });

  DeleteCarState copyWith({
    CarDeleteStatus deleteStatus,
    String message,
  }) =>
      DeleteCarState(
        deleteStatus: deleteStatus ?? this.deleteStatus,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        deleteStatus,
        message,
      ];
}
