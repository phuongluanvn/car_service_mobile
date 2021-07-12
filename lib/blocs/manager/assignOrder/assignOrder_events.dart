import 'package:equatable/equatable.dart';

abstract class AssignOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListAssignOrderEvent extends AssignOrderEvent {}

class DoAssignOrderDetailEvent extends AssignOrderEvent {
  final String id;
  DoAssignOrderDetailEvent({this.id});
  @override
  List<Object> get props => [id];
}

class DoListAssignStaffEvent extends AssignOrderEvent{}
class AssignOrderTabPressed extends AssignOrderEvent {}
