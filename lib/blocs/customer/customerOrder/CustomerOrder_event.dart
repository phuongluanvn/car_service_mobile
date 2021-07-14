import 'package:equatable/equatable.dart';

abstract class CustomerOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoOrderListEvent extends CustomerOrderEvent {}

class DoOrderDetailEvent extends CustomerOrderEvent {
  final String id;
  DoOrderDetailEvent({this.id});
  @override
  List<Object> get props => [id];
}



class DoConfirmOrderEvent extends CustomerOrderEvent {}
