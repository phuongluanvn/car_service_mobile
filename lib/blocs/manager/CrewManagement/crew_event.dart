import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

abstract class CrewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListAccessories extends CrewEvent {}

class DoCrewDetailEvent extends CrewEvent {
  final String name;
  DoCrewDetailEvent({this.name});
  @override
  List<Object> get props => [name];
}

class UpdateCrewToListEvent extends CrewEvent {
  final String id;
  final List listName;
  UpdateCrewToListEvent({this.id, this.listName});
  @override
  List<Object> get props => [id, listName];
}
