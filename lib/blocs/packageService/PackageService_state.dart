import 'package:car_service/utils/model/PackageServiceDetailModel.dart';
import 'package:car_service/utils/model/PackageServiceModel.dart';
import 'package:car_service/utils/model/ServiceModel.dart';
import 'package:equatable/equatable.dart';

enum PackageServiceStatus {
  init,
  loading,
  loadedPackagesSuccess,
  error,
}

enum DetailOfPackageStatus {
  init,
  loading,
  loadedDetailOfPackageSuccess,
  error,
}

class PackageServiceState extends Equatable {
  final PackageServiceStatus status;
  final DetailOfPackageStatus detailStatus;
  final List<PackageServiceModel> packageServiceLists;
  final List<PackageServiceDetailModel> detailOfPackage;
  final String message;
  const PackageServiceState({
    this.status: PackageServiceStatus.init,
    this.detailStatus: DetailOfPackageStatus.init,
    this.packageServiceLists: const [],
    this.detailOfPackage: const [],
    this.message: '',
  });

  PackageServiceState copyWith({
    PackageServiceStatus status,
    DetailOfPackageStatus detailStatus,
    List<PackageServiceModel> packageServiceLists,
    List<String> detailOfPackage,
    String message,
  }) =>
      PackageServiceState(
        status: status ?? this.status,
        detailStatus: detailStatus ?? this.detailStatus,
        packageServiceLists: packageServiceLists ?? this.packageServiceLists,
        detailOfPackage: detailOfPackage ?? this.detailOfPackage,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        packageServiceLists,
        detailOfPackage,
        message,
      ];
}
