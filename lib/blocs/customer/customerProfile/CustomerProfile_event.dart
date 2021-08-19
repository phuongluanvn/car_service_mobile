import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}



class GetProfileByUsername extends ProfileEvent {
  final String username;

  GetProfileByUsername(
      {this.username});
}
