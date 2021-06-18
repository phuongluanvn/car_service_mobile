import 'package:equatable/equatable.dart';

abstract class CustomerOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoOrderListEvent extends CustomerOrderEvent {}

class DoOrderDetailEvent extends CustomerOrderEvent {
  final String email;
  DoOrderDetailEvent({this.email});
  @override
  List<Object> get props => [email];
}

class VerifyBookingTabPressed extends CustomerOrderEvent {}
