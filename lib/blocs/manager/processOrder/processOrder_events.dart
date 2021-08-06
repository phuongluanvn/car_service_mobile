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

// class UpdateFinishedTaskOrderEvent extends ProcessOrderEvent {
//   final String selectedTaskId;
//   final bool selected;
//   final String orderId;
//   UpdateFinishedTaskOrderEvent({this.selectedTaskId,this.selected,this.orderId});
//   @override
//   List<Object> get props => [selectedTaskId,selected, orderId];
// }

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

class UpdateTest extends ProcessOrderEvent {
  final List acc;
  final String orderId;

  UpdateTest({this.orderId, this.acc});
  @override
  List<Object> get props => [acc];
}

class ProcessOrderTabPressed extends ProcessOrderEvent {}
