import 'package:car_service/blocs/customer/manufacturers/Manufacturer_event.dart';
import 'package:car_service/blocs/customer/manufacturers/Manufacturer_state.dart';
import 'package:car_service/blocs/packageService/PackageService_event.dart';
import 'package:car_service/blocs/packageService/PackageService_state.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageServiceBloc extends Bloc<PackageServiceEvent, PackageServiceState> {
  CustomerRepository _repo;

  PackageServiceBloc({CustomerRepository repo})
      : _repo = repo,
        super(PackageServiceState());

  @override
  Stream<PackageServiceState> mapEventToState(PackageServiceEvent event) async* {
    if (event is DoPackageServiceListEvent) {
      yield state.copyWith(status: PackageServiceStatus.loading);
      try {
        var packageServiceLists = await _repo.getPackageServiceList();
        if (packageServiceLists != null) {
          yield state.copyWith(
              packageServiceLists: packageServiceLists,
              status: PackageServiceStatus.loadedPackagesSuccess);
          print('package in bloc');
        } else {
          yield state.copyWith(
            status: PackageServiceStatus.error,
            message: 'Error package',
          );
          print('no package data');
        }
      } catch (e) {
        yield state.copyWith(
          status: PackageServiceStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is DoDetailOfPackageServiceEvent) {
      yield state.copyWith(detailStatus: DetailOfPackageStatus.loading);
      try {
        var data = await _repo.getListModelOfManufacturer(event.packageId);
        print('Model');
        print(data);
        if (data != null) {
          yield state.copyWith(
            detailStatus:
                DetailOfPackageStatus.loadedDetailOfPackageSuccess,
            detailOfPackage: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: DetailOfPackageStatus.error,
            message: 'Error aaa',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: DetailOfPackageStatus.error,
            message: e.toString());
      }
    }
  }
}
