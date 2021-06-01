import 'package:equatable/equatable.dart';

class ConfirmEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class ConfirmationCodeChanged extends ConfirmEvents {
  final String code;
  ConfirmationCodeChanged({this.code});
}

class ConfirmationSubmitted extends ConfirmEvents {}
