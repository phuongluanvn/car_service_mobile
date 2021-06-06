import 'package:equatable/equatable.dart';

class CustomerCarEvents extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw [];
}

class DoFetchEvent extends CustomerCarEvents {}

class DoFetchCarDetail extends CustomerCarEvents {
  final String name;
  DoFetchCarDetail({this.name});
}
