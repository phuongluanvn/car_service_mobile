import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ProcessOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListProcessOrderEvent extends ProcessOrderEvent {}

class DoProcessOrderDetailEvent extends ProcessOrderEvent {
  final String email;
  DoProcessOrderDetailEvent({@required this.email});
  @override
  List<Object> get props => [email];
}

class DoListAssignStaffEvent extends ProcessOrderEvent {}

class UpdateAccesIdToOrder extends ProcessOrderEvent {
  final String orderId;
  final String detailId;
  final String serviceId;
  final String accId;
  final int quantity;
  final int price;
  UpdateAccesIdToOrder(
      {this.orderId,
      this.accId,
      this.detailId,
      this.price,
      this.quantity,
      this.serviceId});
  @override
  List<Object> get props =>
      [orderId, detailId, serviceId, accId, quantity, price];
}

class ProcessOrderTabPressed extends ProcessOrderEvent {}
