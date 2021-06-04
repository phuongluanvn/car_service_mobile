import 'package:equatable/equatable.dart';

abstract class AssignOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListAssignOrderEvent extends AssignOrderEvent {}

class AssignOrderTabPressed extends AssignOrderEvent {}
