import 'package:equatable/equatable.dart';

abstract class CouponEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListCouponEvent extends CouponEvent {}

class DoApplyCouponEvent extends CouponEvent {
  final String id;
  final String orderDetailId;

  DoApplyCouponEvent({this.id, this.orderDetailId});
}

class DoRemoveCouponEvent extends CouponEvent {
  final String orderDetailId;
  DoRemoveCouponEvent({this.orderDetailId});
}
