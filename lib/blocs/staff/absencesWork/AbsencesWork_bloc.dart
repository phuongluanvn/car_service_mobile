
import 'package:car_service/blocs/customer/customerCar/CreateCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CreateCar_state.dart';
import 'package:car_service/blocs/staff/absencesWork/AbsencesWork_event.dart';
import 'package:car_service/blocs/staff/absencesWork/AbsencesWork_state.dart';
import 'package:car_service/utils/repository/staff_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsencesWorkBloc extends Bloc<AbsencesWorkEvent, AbsencesWorkState> {
  StaffRepository _repo;

  AbsencesWorkBloc({StaffRepository repo})
      : _repo = repo,
        super(AbsencesWorkState());

  @override
  Stream<AbsencesWorkState> mapEventToState(AbsencesWorkEvent event) async* {
    if (event is AbsencesWorkButtonPressed) {
      yield state.copyWith(status: AbsencesWorkStatus.loading);
      try {
        var data = await _repo.absentWork(event.username, event.absences);
        print(data);
        if (data != null) {
          yield state.copyWith(status: AbsencesWorkStatus.absencesWorkSuccess);
        } else {
          yield state.copyWith(
              status: AbsencesWorkStatus.error, 
              message: 'Error');
              print('success');
        }
      } catch (e) {
        yield state.copyWith(
          status: AbsencesWorkStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is AbsencesWorkButtonPressedTest) {
      yield state.copyWith(status: AbsencesWorkStatus.loading);
      try {
        var data = await _repo.absentWorkTest(event.username, event.timeStart, event.timeEnd, event.noteOfStaff);
        print(data);
        if (data != null) {
          yield state.copyWith(status: AbsencesWorkStatus.absencesWorkSuccess);
        } else {
          yield state.copyWith(
              status: AbsencesWorkStatus.error, message: 'Error SignUp');
        }
      } catch (e) {
        yield state.copyWith(
          status: AbsencesWorkStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
