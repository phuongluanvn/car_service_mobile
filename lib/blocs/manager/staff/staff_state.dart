import 'package:car_service/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

class StaffState extends Equatable {
  @override
  List<Object> get props => [];
}

class StaffInitState extends StaffState {}

class StaffLoadingState extends StaffState {}

class StaffListSuccessState extends StaffState {
  List<StaffModel> staffList;
  StaffListSuccessState({this.staffList});
}

class StaffDetailSucessState extends StaffState{
  StaffModel data;
  StaffDetailSucessState({this.data});
}

class StaffListErrorState extends StaffState {
  final String message;
  StaffListErrorState({this.message});
}
