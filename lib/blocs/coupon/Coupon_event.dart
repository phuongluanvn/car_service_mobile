import 'package:equatable/equatable.dart';

abstract class CouponEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListCouponEvent extends CouponEvent {}
