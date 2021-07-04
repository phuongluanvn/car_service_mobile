import 'package:car_service/utils/model/ServiceModel.dart';
import 'package:equatable/equatable.dart';

enum CustomerServiceStatus {
  init,
  loading,
  loadedServiceSuccess,
  error,
}

class CustomerServiceState extends Equatable {
  final CustomerServiceStatus status;
  final List<ServiceModel> serviceLists;
  final String message;
  const CustomerServiceState({
    this.status: CustomerServiceStatus.init,
    this.serviceLists:const [],
    this.message:'',
  });

  CustomerServiceState copyWith({
    CustomerServiceStatus status,
    List<ServiceModel> serviceLists,
    String message,
  }) =>
      CustomerServiceState(
        status: status ?? this.status,
        serviceLists: serviceLists ?? this.serviceLists,
        message: message??this.message,
      );
  @override
  List<Object> get props => [
        status,
        serviceLists,
        message,
      ];
}