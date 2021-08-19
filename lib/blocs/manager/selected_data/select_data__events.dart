import 'package:car_service/utils/model/StaffModel.dart';
import 'package:equatable/equatable.dart';

abstract class SelectDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoListSelectStaffEvent extends SelectDataEvent {
  final List<StaffModel> listDataStaff;
  DoListSelectStaffEvent({this.listDataStaff});
}
