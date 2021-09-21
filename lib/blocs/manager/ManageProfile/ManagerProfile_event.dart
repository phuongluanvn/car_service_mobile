import 'package:equatable/equatable.dart';

abstract class ManagerProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}



class GetManagerProfileByUsername extends ManagerProfileEvent {
  final String username;

  GetManagerProfileByUsername(
      {this.username});
}
