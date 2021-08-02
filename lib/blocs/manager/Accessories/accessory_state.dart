import 'package:car_service/utils/model/accessory_model.dart';
import 'package:equatable/equatable.dart';

enum ListAccessoryStatus {
  init,
  loading,
  success,
  error,
}

class AccessoryState extends Equatable {
  final ListAccessoryStatus status;
  final List<AccessoryModel> accessoryList;
  final String message;
  AccessoryState({this.status: ListAccessoryStatus.init,this.accessoryList: const [], this.message: ''});

  AccessoryState copyWith({
    ListAccessoryStatus status,
    List<AccessoryModel> accessoryList,
    String message,
  }) =>
      AccessoryState(
        status: status ?? this.status,
        accessoryList: accessoryList ?? this.accessoryList,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [status,accessoryList, message];
}
