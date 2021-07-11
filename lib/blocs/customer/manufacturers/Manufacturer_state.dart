import 'package:car_service/utils/model/ManufacturerModel.dart';
import 'package:car_service/utils/model/ServiceModel.dart';
import 'package:equatable/equatable.dart';

enum ManufacturerStatus {
  init,
  loading,
  loadedManufacturerSuccess,
  error,
}

enum ModelOfManufacturerStatus {
  init,
  loading,
  loadedModelOfManufacturerSuccess,
  error,
}

class ManufacturerState extends Equatable {
  final ManufacturerStatus status;
  final ModelOfManufacturerStatus modelStatus;
  final List<ManufacturerModel> manufacturerLists;
  final List<String> modelOfManu;
  final String message;
  const ManufacturerState({
    this.status: ManufacturerStatus.init,
    this.modelStatus: ModelOfManufacturerStatus.init,
    this.manufacturerLists: const [],
    this.modelOfManu: const [],
    this.message: '',
  });

  ManufacturerState copyWith({
    ManufacturerStatus status,
    ModelOfManufacturerStatus modelStatus,
    List<ManufacturerModel> manufacturerLists,
    List<String> modelOfManu,
    String message,
  }) =>
      ManufacturerState(
        status: status ?? this.status,
        modelStatus: modelStatus ?? this.modelStatus,
        manufacturerLists: manufacturerLists ?? this.manufacturerLists,
        modelOfManu: modelOfManu ?? this.modelOfManu,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        modelStatus,
        manufacturerLists,
        modelOfManu,
        message,
      ];
}
