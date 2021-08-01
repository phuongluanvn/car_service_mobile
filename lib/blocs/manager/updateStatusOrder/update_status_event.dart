import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/utils/model/StaffModel.dart';
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

class UpdateStatusStartButtonPressed extends UpdateStatusOrderEvent {
  final String id;

  final String status;

  UpdateStatusStartButtonPressed({this.id, this.status});
}

class UpdateStatusCheckinButtonPressed extends UpdateStatusOrderEvent {
  final String id;
  final String status;

  UpdateStatusCheckinButtonPressed({this.id, this.status});
}

class UpdateStatusCheckingButtonPressed extends UpdateStatusOrderEvent {
  final String id;
  final String status;

  UpdateStatusCheckingButtonPressed({this.id, this.status});
}

class UpdateAbsentStatusButtonPressed extends UpdateStatusOrderEvent {
  final String username;
  final String status;

  UpdateAbsentStatusButtonPressed({this.username, this.status});
}

class UpdateStatusWorkingButtonPress extends UpdateStatusOrderEvent {
  final List<StaffModel> listdata;
  final String status;

  UpdateStatusWorkingButtonPress({this.listdata, this.status});
}

class UpdateStatusStartAndWorkingButtonPressed extends UpdateStatusOrderEvent {
  final String id;
  final List<StaffModel> listData;
  final String status;

  UpdateStatusStartAndWorkingButtonPressed(
      {this.id, this.listData, this.status});
}
