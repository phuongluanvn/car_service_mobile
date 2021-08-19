import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

abstract class AccessoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListAccessories extends AccessoryEvent {}

class DoAccessoryDetailEvent extends AccessoryEvent {
  final String name;
  DoAccessoryDetailEvent({this.name});
  @override
  List<Object> get props => [name];
}
