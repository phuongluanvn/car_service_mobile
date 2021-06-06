import 'package:car_service/utils/model/AssignOrderModel.dart';
import 'package:equatable/equatable.dart';

class AssignOrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class AssignOrderInitState extends AssignOrderState {}

class AssignOrderLoadingState extends AssignOrderState {}

class AssignOrderSuccessState extends AssignOrderState {
  List<AssignOrderModel> orderList;
  AssignOrderSuccessState({this.orderList});
}

class AssignOrderErrorState extends AssignOrderState {
  final String message;
  AssignOrderErrorState({this.message});
}
