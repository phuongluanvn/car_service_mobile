import 'package:car_service/blocs/confirm/confirmation_events.dart';
import 'package:car_service/blocs/confirm/confirmation_state.dart';
import 'package:car_service/form_submission_status.dart';
import 'package:car_service/utils/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmBloc extends Bloc<ConfirmEvents, ConfirmState> {
  AuthRepository repo;
  ConfirmBloc({this.repo}) : super(ConfirmState());

  @override
  Stream<ConfirmState> mapEventToState(ConfirmEvents event) async* {
    //Confirm code updated
    if (event is ConfirmationCodeChanged) {
      yield state.copyWith(code: event.code);

      //Form submitted
    } else if (event is ConfirmationSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        // await repo.login(email, password)
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
