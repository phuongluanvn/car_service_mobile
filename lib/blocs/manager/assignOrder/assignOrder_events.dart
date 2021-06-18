import 'package:equatable/equatable.dart';

abstract class AssignOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListAssignOrderEvent extends AssignOrderEvent {}

class DoAssignOrderDetailEvent extends AssignOrderEvent {
  final String email;
  DoAssignOrderDetailEvent({this.email});
  @override
  List<Object> get props => [email];
}

class DoListAssignStaffEvent extends AssignOrderEvent{}
class AssignOrderTabPressed extends AssignOrderEvent {}
