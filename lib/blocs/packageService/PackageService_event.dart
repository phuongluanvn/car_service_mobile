import 'package:equatable/equatable.dart';

abstract class PackageServiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoPackageServiceListEvent extends PackageServiceEvent {
  //  final String manuName;

  // DoPackageServiceListEvent({this.manuName});
}

class GetManufacturerListPressed extends PackageServiceEvent {}

class DoDetailOfPackageServiceEvent extends PackageServiceEvent {
  final String packageId;

  DoDetailOfPackageServiceEvent({this.packageId});
}
