import 'package:car_service/utils/model/CustomerModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/PackageServiceModel.dart';
import 'package:car_service/utils/model/UserModel.dart';
import 'package:equatable/equatable.dart';

enum CreateOrderStatus {
  init,
  loading,
  createOrderSuccess,
  error,
}
enum CreateDetailStatus {
  init,
  loading,
  success,
  error,
}

// ignore: must_be_immutable
class CreateOrderState extends Equatable {
  final CreateOrderStatus status;
  final CreateDetailStatus detailStatus;
  final String message;
  List<CustomerModel> listCus;
  List<PackageServiceModel> listPackageServices;

  CreateOrderState(
      {this.status: CreateOrderStatus.init,
      this.detailStatus: CreateDetailStatus.init,
      this.listCus: const [],
      this.listPackageServices: const [],
      this.message: ''});

  CreateOrderState copyWith({
    CreateOrderStatus status,
    CreateDetailStatus detailStatus,
    List<CustomerModel> listCus,
    List<PackageServiceModel> listPackageServices,
    String message,
  }) =>
      CreateOrderState(
        status: status ?? this.status,
        detailStatus: detailStatus ?? this.detailStatus,
        listCus: listCus ?? this.listCus,
        listPackageServices: listPackageServices ?? this.listPackageServices,
        message: message ?? this.message,
      );
  @override
  List<Object> get props =>
      [status, detailStatus, listCus, listPackageServices, message];
}
