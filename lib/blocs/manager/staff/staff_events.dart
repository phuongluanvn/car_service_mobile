import 'package:equatable/equatable.dart';

abstract class ManageStaffEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListStaffEvent extends ManageStaffEvent {}
class DoListServiceEvent extends ManageStaffEvent {}

class DoStaffDetailEvent extends ManageStaffEvent {
  final String username;
  DoStaffDetailEvent({this.username});
}

class StaffTabPressed extends ManageStaffEvent {}
