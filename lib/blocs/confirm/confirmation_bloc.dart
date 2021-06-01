
import 'package:car_service/blocs/confirm/confirmation_events.dart';
import 'package:car_service/blocs/confirm/confirmation_state.dart';
import 'package:car_service/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmBloc extends Bloc<ConfirmEvents, ConfirmState> {
  AuthRepository repo;
  ConfirmBloc({this.repo}) : super(ConfirmState());

  @override
  Stream<ConfirmState> mapEventToState(ConfirmEvents event) async* {
    //Confirm code updated
    if(event is ConfirmationCodeChanged) {
      yield state.copy
    }
  }
}
