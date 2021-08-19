import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

abstract class ManageStaffEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListStaffEvent extends ManageStaffEvent {}

class DoListSelectStaffEvent extends ManageStaffEvent {
  final List<StaffModel> listDataStaff;
  DoListSelectStaffEvent({this.listDataStaff});
}

class DoStaffDetailEvent extends ManageStaffEvent {
  final String username;
  DoStaffDetailEvent({this.username});
}

class StaffTabPressed extends ManageStaffEvent {}

class DoListStaffWithAvaiStatusEvent extends ManageStaffEvent{}
