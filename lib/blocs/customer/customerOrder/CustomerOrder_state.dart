import 'package:car_service/utils/model/OrderModel.dart';
import 'package:equatable/equatable.dart';

enum CustomerOrderStatus {
  init,
  loading,
  loadedOrderSuccess,
  loadedOrderDetailSuccess,
  error,
}

enum CustomerOrderDetailStatus{
  init,
  loading,
  success,
  error,
}

class CustomerOrderState extends Equatable {
  final CustomerOrderStatus status;
  final CustomerOrderDetailStatus detailStatus;
  final List<OrderModel> orderLists;
  final List<OrderModel> orderDetail;
  final String message;
  const CustomerOrderState({
    this.status: CustomerOrderStatus.init,
    this.detailStatus:CustomerOrderDetailStatus.init,
    this.orderDetail:const [],
    this.orderLists:const [],
    this.message:'',
  });

  CustomerOrderState copyWith({
    CustomerOrderStatus status,
    CustomerOrderDetailStatus detailStatus,
    List<OrderModel> orderLists,
    List<OrderModel> orderDetail,
    String message,
  }) =>
      CustomerOrderState(
        status: status ?? this.status,
        detailStatus: detailStatus??this.detailStatus,
        orderLists: orderLists ?? this.orderLists,
        orderDetail: orderDetail ?? this.orderDetail,
        message: message??this.message,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        orderLists,
        orderDetail,
        message,
      ];
}