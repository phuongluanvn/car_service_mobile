import 'package:equatable/equatable.dart';

abstract class AssignOrderReviewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListAssignReviewEvent extends AssignOrderReviewEvent {}

class DoAssignReviewDetailEvent extends AssignOrderReviewEvent {
  final String id;
  DoAssignReviewDetailEvent({this.id});
  @override
  List<Object> get props => [id];
}

class DoListAssignReviewStaffEvent extends AssignOrderReviewEvent {}

class AssignOrderTabPressed extends AssignOrderReviewEvent {}
