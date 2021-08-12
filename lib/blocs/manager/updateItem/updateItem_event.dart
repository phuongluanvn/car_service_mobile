
import 'package:equatable/equatable.dart';

abstract class UpdateItemEvent extends Equatable {
  const UpdateItemEvent();


  @override
  List<Object> get props => [];
}

class DeleteServiceByIdEvent extends UpdateItemEvent {
  final String detailId;
  DeleteServiceByIdEvent(
      {this.detailId});
  @override
  List<Object> get props => [detailId];
}

