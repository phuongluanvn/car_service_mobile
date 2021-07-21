import 'package:equatable/equatable.dart';

abstract class PackageServiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoPackageServiceListEvent extends PackageServiceEvent {}


class GetPackageServiceListPressed extends PackageServiceEvent {}
