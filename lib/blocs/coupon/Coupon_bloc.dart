import 'package:car_service/blocs/coupon/Coupon_event.dart';
import 'package:car_service/blocs/coupon/Coupon_state.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/model/VehicleModel.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CustomerRepository _repo;

  CouponBloc({CustomerRepository repo})
      : _repo = repo,
        super(CouponState());

  @override
  Stream<CouponState> mapEventToState(CouponEvent event) async* {
    if (event is DoListCouponEvent) {
      yield state.copyWith(status: CouponStatus.loading);
      try {
        var carLists = await _repo.getCoupon();
        if (carLists != null) {
          yield state.copyWith(
              couponLists: carLists, status: CouponStatus.loadedCouponSuccess);
        }
      } catch (e) {
        yield state.copyWith(
          status: CouponStatus.error,
          message: e.toString(),
        );
      }
    }
  }
}
