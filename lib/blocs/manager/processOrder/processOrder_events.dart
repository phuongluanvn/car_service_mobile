import 'package:equatable/equatable.dart';

abstract class ProcessOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListProcessOrderEvent extends ProcessOrderEvent {}

class DoProcessOrderDetailEvent extends ProcessOrderEvent {
  final String email;
  DoProcessOrderDetailEvent({this.email});
  @override
  List<Object> get props => [email];
}

class DoListAssignStaffEvent extends ProcessOrderEvent {}

class ProcessOrderTabPressed extends ProcessOrderEvent {}
