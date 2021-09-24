import 'package:car_service/utils/model/AbsencesWorkModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

abstract class AbsencesWorkEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AbsencesWorkButtonPressed extends AbsencesWorkEvent {
  final String username;
  final List<AbsencesWork> absences;

  AbsencesWorkButtonPressed({this.username, this.absences});
  @override
  List<Object> get props => [absences];
}

class AbsencesWorkButtonPressedTest extends AbsencesWorkEvent {
  final String username;
  final String timeStart;
  final String timeEnd;
  final String noteOfStaff;

  AbsencesWorkButtonPressedTest(
      {this.username, this.timeStart, this.timeEnd, this.noteOfStaff});
}

