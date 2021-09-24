
import 'package:equatable/equatable.dart';

abstract class AssignCrewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListAssignCrew extends AssignCrewEvent {}

class UpdateCrewAgainEvent extends AssignCrewEvent {
  final String id;
  final String crewId;
  UpdateCrewAgainEvent({this.id, this.crewId});
  @override
  List<Object> get props => [id, crewId];
}
