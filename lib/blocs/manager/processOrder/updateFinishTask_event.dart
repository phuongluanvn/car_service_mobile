import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class UpdateFinishTaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class DoTaskrDetailEvent extends UpdateFinishTaskEvent {
  final String id;
  DoTaskrDetailEvent({@required this.id});
  @override
  List<Object> get props => [id];
}


class UpdateFinishedTaskOrderEvent extends UpdateFinishTaskEvent {
  final String selectedTaskId;
  final bool selected;
  final String orderId;
  UpdateFinishedTaskOrderEvent({this.selectedTaskId,this.selected,this.orderId});
  @override
  List<Object> get props => [selectedTaskId,selected, orderId];
}


