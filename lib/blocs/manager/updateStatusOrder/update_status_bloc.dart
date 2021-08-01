import 'dart:convert';

import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateStatusOrderBloc
    extends Bloc<UpdateStatusOrderEvent, UpdateStatusOrderState> {
  ManagerRepository _repo;

  UpdateStatusOrderBloc({ManagerRepository repo})
      : _repo = repo,
        super(UpdateStatusOrderState());

  @override
  Stream<UpdateStatusOrderState> mapEventToState(
      UpdateStatusOrderEvent event) async* {
    if (event is UpdateStatusButtonPressed) {
      yield state.copyWith(status: UpdateStatus.loading);
      try {
        var data = await _repo.updateStatusOrder(event.id, event.status);
        // String jsonsDataString = data.toString();
        print(data);
        // final jsonData = jsonDecode(jsonsDataString);
        // print(jsonData);
        if (data != null) {
          yield state.copyWith(status: UpdateStatus.updateStatusSuccess);
        } else {
          yield state.copyWith(
              status: UpdateStatus.error, message: 'Error Update');
        }
      } catch (e) {
        yield state.copyWith(
          status: UpdateStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is UpdateStatusStartButtonPressed) {
      print('loading');
      yield state.copyWith(status: UpdateStatus.loading);
      try {
        var data = await _repo.updateStatusOrder(event.id, event.status);

        // String jsonsDataString = data.toString();
        print(data);
        // final jsonData = jsonDecode(jsonsDataString);
        // print(jsonData);
        if (data != null) {
          yield state.copyWith(status: UpdateStatus.updateStatusStartSuccess);
          print('Start Success');
        } else {
          yield state.copyWith(
              status: UpdateStatus.error, message: 'Error Update');
        }
      } catch (e) {
        yield state.copyWith(
          status: UpdateStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is UpdateStatusCheckinButtonPressed) {
      print('loading');
      yield state.copyWith(status: UpdateStatus.loading);
      try {
        var data = await _repo.updateStatusOrder(event.id, event.status);
        // String jsonsDataString = data.toString();
        print(data);
        // final jsonData = jsonDecode(jsonsDataString);
        // print(jsonData);
        if (data != null) {
          yield state.copyWith(status: UpdateStatus.updateStatusCheckinSuccess);
          print('Start Success');
        } else {
          yield state.copyWith(
              status: UpdateStatus.error, message: 'Error Update');
        }
      } catch (e) {
        yield state.copyWith(
          status: UpdateStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is UpdateStatusCheckingButtonPressed) {
      print('loading');
      yield state.copyWith(status: UpdateStatus.loading);
      try {
        var data = await _repo.updateStatusOrder(event.id, event.status);

        // String jsonsDataString = data.toString();
        print(data);
        // final jsonData = jsonDecode(jsonsDataString);
        // print(jsonData);
        if (data != null) {
          yield state.copyWith(
              status: UpdateStatus.updateStatusCheckingSuccess);
          print('Start Success');
        } else {
          yield state.copyWith(
              status: UpdateStatus.error, message: 'Error Update');
        }
      } catch (e) {
        yield state.copyWith(
          status: UpdateStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is UpdateAbsentStatusButtonPressed) {
      print('loading');
      yield state.copyWith(status: UpdateStatus.loading);
      try {
        var data =
            await _repo.updateStaffStatusOrder(event.username, event.status);
        // String jsonsDataString = data.toString();
        print(data);
        // final jsonData = jsonDecode(jsonsDataString);
        // print(jsonData);
        if (data != null) {
          yield state.copyWith(status: UpdateStatus.updateStatusAbsentSuccess);
          print('Staff status updated');
        } else {
          yield state.copyWith(
              status: UpdateStatus.error, message: 'Error Update');
        }
      } catch (e) {
        yield state.copyWith(
          status: UpdateStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is UpdateStatusWorkingButtonPress) {
      print('loading2');
      var data;
      yield state.copyWith(status: UpdateStatus.loading);
      try {
        for (var i = 0; i <= event.listdata.length; i++) {
          data = await _repo.updateStaffStatusOrder(
              event.listdata[i].username, event.status);
          print(event.listdata[i].username);
        }

        // String jsonsDataString = data.toString();
        print(data);
        // final jsonData = jsonDecode(jsonsDataString);
        // print(jsonData);
        if (data != null) {
          yield state.copyWith(status: UpdateStatus.updateStatusWorkingSuccess);
          print('Staff working status updated');
        } else {
          yield state.copyWith(
              status: UpdateStatus.error, message: 'Error Update');
        }
      } catch (e) {
        yield state.copyWith(
          status: UpdateStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is UpdateStatusStartAndWorkingButtonPressed) {
      print('loading');
      var data2;
      yield state.copyWith(status: UpdateStatus.loading);
      try {
        var data = await _repo.updateStatusOrder(event.id, event.status);
        for (var i = 0; i <= event.listData.length; i++) {
          data2 = await _repo.updateStaffStatusOrder(
              event.listData[i].username, event.status);
          print(event.listData[i].username);
        }

        // String jsonsDataString = data.toString();
        print(data);
        print(data2);
        // final jsonData = jsonDecode(jsonsDataString);
        // print(jsonData);
        if (data != null) {
          yield state.copyWith(status: UpdateStatus.updateStatusStartSuccess);
          print('Start Success');
        } else {
          yield state.copyWith(
              status: UpdateStatus.error, message: 'Error Update');
        }
      } catch (e) {
        yield state.copyWith(
          status: UpdateStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
