import 'package:equatable/equatable.dart';

abstract class CustomerServiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoServiceListEvent extends CustomerServiceEvent {}


class GetServiceListPressed extends CustomerServiceEvent {}
