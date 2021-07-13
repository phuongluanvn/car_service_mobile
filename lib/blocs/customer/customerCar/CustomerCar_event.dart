import 'package:equatable/equatable.dart';

abstract class CustomerCarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoCarListEvent extends CustomerCarEvent {}

class DoCarDetailEvent extends CustomerCarEvent {
  final String vehicleId;
  DoCarDetailEvent({this.vehicleId});
  @override
  List<Object> get props => [vehicleId];
}

class VerifyBookingTabPressed extends CustomerCarEvent {}
