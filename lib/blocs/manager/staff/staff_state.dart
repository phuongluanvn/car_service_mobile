import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

// enum StaffStatus{init,loading,}
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
  List<StaffModel> data;
  StaffDetailSucessState({this.data});
}

class StaffListErrorState extends StaffState {
  final String message;
  StaffListErrorState({this.message});
}
