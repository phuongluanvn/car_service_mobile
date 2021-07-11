import 'package:equatable/equatable.dart';

abstract class ManufacturerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoManufacturerListEvent extends ManufacturerEvent {
   final String manuName;

  DoManufacturerListEvent({this.manuName});
}

class GetManufacturerListPressed extends ManufacturerEvent {}

class DoModelListOfManufacturerEvent extends ManufacturerEvent {
  final String manuName;

  DoModelListOfManufacturerEvent({this.manuName});
}
