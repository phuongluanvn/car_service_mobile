import 'package:equatable/equatable.dart';

abstract class CustomerCarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoCarListEvent extends CustomerCarEvent {}

class DoCarListWithIdEvent extends CustomerCarEvent {
  final String vehicleId;
  DoCarListWithIdEvent({this.vehicleId});
  @override
  List<Object> get props => [vehicleId];
}

class DoCarDetailEvent extends CustomerCarEvent {
  final String vehicleId;
  DoCarDetailEvent({this.vehicleId});
  @override
  List<Object> get props => [vehicleId];
}

class DoDelCarEvent extends CustomerCarEvent {
  final String vehicleId;
  DoDelCarEvent({this.vehicleId});
  @override
  List<Object> get props => [vehicleId];
}

class DoUpdateInfoCarEvent extends CustomerCarEvent {
  final int kilometer;
  DoUpdateInfoCarEvent({this.kilometer});
  @override
  List<Object> get props => [kilometer];
}

class VerifyBookingTabPressed extends CustomerCarEvent {}
