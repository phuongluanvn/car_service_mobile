import 'package:equatable/equatable.dart';

abstract class EmployeeProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}



class GetEmpProfileByUsername extends EmployeeProfileEvent {
  final String username;

  GetEmpProfileByUsername(
      {this.username});
}
