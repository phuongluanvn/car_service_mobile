import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/OrderModel.dart';
import 'package:equatable/equatable.dart';

enum CustomerOrderStatus {
  init,
  loading,
  loadedOrderSuccess,
  error,
  loadingOrderWithBookingStatus,
  loadedOrderCurrentSuccess,
  loadedOrderWaitingConfirmSuccess,
  loadedOrderHistorySuccess
}

enum CustomerOrderDetailStatus {
  init,
  loading,
  success,
  error,
}

class CustomerOrderState extends Equatable {
  final CustomerOrderStatus status;
  final CustomerOrderDetailStatus detailStatus;
  final List<OrderModel> orderLists;
  final List<OrderModel> orderCurrentLists;
  final List<OrderModel> orderHistoryLists;
  final List<OrderModel> orderProcessingLists;
  final List<OrderModel> orderCheckingLists;
  final List<OrderModel> orderWaitingConfirmLists;
  final List<OrderModel> orderAcceptedLists;

  final List<OrderDetailModel> orderDetail;
  final String message;
  const CustomerOrderState({
    this.status: CustomerOrderStatus.init,
    this.detailStatus: CustomerOrderDetailStatus.init,
    this.orderDetail: const [],
    this.orderLists: const [],
    this.orderCurrentLists: const [],
    this.orderHistoryLists: const [],
    this.orderProcessingLists: const [],
    this.orderCheckingLists: const [],
    this.orderWaitingConfirmLists: const [],
    this.orderAcceptedLists: const [],
    this.message: '',
  });

  CustomerOrderState copyWith({
    CustomerOrderStatus status,
    CustomerOrderDetailStatus detailStatus,
    List<OrderModel> orderLists,
    List<OrderModel> orderCurrentLists,
    List<OrderModel> orderHistoryLists,
    List<OrderModel> orderProcessingLists,
    List<OrderModel> orderCheckingLists,
    List<OrderModel> orderWaitingConfirmLists,
    List<OrderModel> orderAcceptedLists,
    List<OrderDetailModel> orderDetail,
    String message,
  }) =>
      CustomerOrderState(
        status: status ?? this.status,
        detailStatus: detailStatus ?? this.detailStatus,
        orderLists: orderLists ?? this.orderLists,
        orderCurrentLists: orderCurrentLists ?? this.orderCurrentLists,
        orderHistoryLists: orderHistoryLists ?? this.orderHistoryLists,
        orderProcessingLists: orderProcessingLists ?? this.orderProcessingLists,
        orderCheckingLists: orderCheckingLists ?? this.orderCheckingLists,
        orderWaitingConfirmLists:
            orderWaitingConfirmLists ?? this.orderWaitingConfirmLists,
        orderAcceptedLists: orderAcceptedLists ?? this.orderAcceptedLists,
        orderDetail: orderDetail ?? this.orderDetail,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        detailStatus,
        orderLists,
        orderCurrentLists,
        orderHistoryLists,
        orderProcessingLists,
        orderCheckingLists,
        orderAcceptedLists,
        orderWaitingConfirmLists,
        orderDetail,
        message,
      ];
}
