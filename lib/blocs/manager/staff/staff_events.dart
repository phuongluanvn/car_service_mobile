import 'package:equatable/equatable.dart';

abstract class StaffEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListStaffEvent extends StaffEvent {}

class DoStaffDetailEvent extends StaffEvent {
  final String email;
  DoStaffDetailEvent({this.email});
}

class StaffTabPressed extends StaffEvent {}
