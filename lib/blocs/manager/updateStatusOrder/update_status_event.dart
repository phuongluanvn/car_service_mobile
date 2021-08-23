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
  final String workingStatus;

  UpdateStatusStartAndWorkingButtonPressed(
      {this.id, this.listData, this.status, this.workingStatus});
}

class UpdateStatusFinishAndAvailableButtonPressed
    extends UpdateStatusOrderEvent {
  final String id;
  final List<StaffModel> listData;
  final String status;
  final String availableStatus;

  UpdateStatusFinishAndAvailableButtonPressed(
      {this.id, this.listData, this.status, this.availableStatus});
}

class UpdateStatusSendConfirmButtonPressed extends UpdateStatusOrderEvent {
  final String id;
  final String status;

  UpdateStatusSendConfirmButtonPressed({this.id, this.status});
}

class UpdateStatusConfirmAcceptedButtonPressed extends UpdateStatusOrderEvent {
  final String id;
  final String status;

  UpdateStatusConfirmAcceptedButtonPressed({this.id, this.status});
}

class UpdateStatusCancelButtonPressed extends UpdateStatusOrderEvent {
  final String id;
  final String status;

  UpdateStatusCancelButtonPressed({this.id, this.status});
}

class UpdateConfirmFromCustomerButtonPressed extends UpdateStatusOrderEvent {
  final String id;
  final bool isAccept;
  final String customerNote;
  UpdateConfirmFromCustomerButtonPressed(
      {this.id, this.isAccept, this.customerNote});
}
