import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/createCrewModel.dart';
import 'package:equatable/equatable.dart';

abstract class CrewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListCrew extends CrewEvent {}

class DoCrewDetailEvent extends CrewEvent {
  final String id;
  DoCrewDetailEvent({this.id});
  @override
  List<Object> get props => [id];
}
class CreateCrewEvent extends CrewEvent {
  final List<CreateCrewModel> listUsername;
  CreateCrewEvent({this.listUsername});
  @override
  List<Object> get props => [listUsername];
}
class UpdateCrewToListEvent extends CrewEvent {
  final String id;
  final String crewId;
  UpdateCrewToListEvent({this.id, this.crewId});
  @override
  List<Object> get props => [id, crewId];
}
