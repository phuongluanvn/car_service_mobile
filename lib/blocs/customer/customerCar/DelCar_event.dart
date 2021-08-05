import 'package:equatable/equatable.dart';

abstract class DeleteCarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoDeleteCarEvent extends DeleteCarEvent {
  final String vehicleId;
  DoDeleteCarEvent({this.vehicleId});
  @override
  List<Object> get props => [vehicleId];
}

