import 'package:equatable/equatable.dart';

abstract class EditProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EditProfileButtonPressed extends EditProfileEvent {
  final String username;
  final String email;
  final String phoneNumber;
  final String address;
  final String fullname;

  EditProfileButtonPressed(
      {this.username, this.email, this.phoneNumber, this.address, this.fullname});
}
