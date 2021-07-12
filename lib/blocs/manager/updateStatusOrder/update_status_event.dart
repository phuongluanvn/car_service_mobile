import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateStatusOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateStatusButtonPressed extends UpdateStatusOrderEvent {
  final String id;
  final String status;

  UpdateStatusButtonPressed({this.id, this.status});
}

