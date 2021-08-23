import 'dart:convert';

import 'package:car_service/blocs/manager/employeeProfile/EmployeeProfile_event.dart';
import 'package:car_service/blocs/manager/employeeProfile/EmployeeProfile_state.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeProfileBloc extends Bloc<EmployeeProfileEvent, EmployeeProfileState> {
  CustomerRepository _repo;

  EmployeeProfileBloc({CustomerRepository repo})
      : _repo = repo,
        super(EmployeeProfileState());

  @override
  Stream<EmployeeProfileState> mapEventToState(EmployeeProfileEvent event) async* {
    if (event is GetEmpProfileByUsername) {
      yield state.copyWith(status:  EmpProfileStatus.loading);
      try {
        var data = await _repo.getProfileEmployee(event.username);
        if (data != null) {
          yield state.copyWith(
            empProfile: data,
            status: EmpProfileStatus.getProflieSuccess);
        } else {
          yield state.copyWith(
              status: EmpProfileStatus.error, message: 'Error getprofile');
        }
      } catch (e) {
        yield state.copyWith(
          status: EmpProfileStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
