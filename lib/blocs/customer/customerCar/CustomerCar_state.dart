import 'package:equatable/equatable.dart';
import '../../../utils/model/CarModel.dart';

enum CustomerCarStatus {
  init,
  loading,
  loadedCarSuccess,
  loadedCarDetailSuccess,
  error,
}

enum CustomerCarDetailStatus{
  init,
  loading,
  success,
  error,
}

class CustomerCarState extends Equatable {
  final CustomerCarStatus status;
  final CustomerCarDetailStatus detailStatus;
  final List<CarModel> carLists;
  final List<CarModel> carDetail;
  final String message;
  const CustomerCarState({
    this.status: CustomerCarStatus.init,
    this.detailStatus:CustomerCarDetailStatus.init,
    this.carDetail:const [],
    this.carLists:const [],
    this.message:'',
  });

  CustomerCarState copyWith({
    CustomerCarStatus status,
    CustomerCarDetailStatus detailStatus,
    List<CarModel> carLists,
    List<CarModel> carDetail,
    String message,
  }) =>
      CustomerCarState(
        status: status ?? this.status,
        detailStatus: detailStatus??this.detailStatus,
        carLists: carLists ?? this.carLists,
        carDetail: carDetail ?? this.carDetail,
        message: message??this.message,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        carLists,
        carDetail,
        message,
      ];
}