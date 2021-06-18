import 'package:equatable/equatable.dart';

abstract class CustomerCarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoCarListEvent extends CustomerCarEvent {}

class DoCarDetailEvent extends CustomerCarEvent {
  final String email;
  DoCarDetailEvent({this.email});
  @override
  List<Object> get props => [email];
}

class VerifyBookingTabPressed extends CustomerCarEvent {}
