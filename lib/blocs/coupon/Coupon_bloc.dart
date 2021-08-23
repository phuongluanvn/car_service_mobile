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
        var couponList = await _repo.getCoupon();
        if (couponList != null) {
          yield state.copyWith(
              couponLists: couponList, status: CouponStatus.loadedCouponSuccess);
        }
      } catch (e) {
        yield state.copyWith(
          status: CouponStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is DoApplyCouponEvent) {
      yield state.copyWith(applyStatus: ApplyCouponStatus.loading);
      try {
        var couponList = await _repo.applyCoupon(event.id, event.orderDetailId)();
        if (couponList != null) {
          yield state.copyWith(
              couponLists: couponList, applyStatus: ApplyCouponStatus.applyCouponSuccess);
        }
      } catch (e) {
        yield state.copyWith(
          applyStatus: ApplyCouponStatus.error,
          message: e.toString(),
        );
      }
    } else if (event is DoRemoveCouponEvent) {
      yield state.copyWith(removeStatus: RemoveCouponStatus.loading);
      try {
        var couponList = await _repo.removeCoupon(event.orderDetailId);
        if (couponList != null) {
          yield state.copyWith(
              couponLists: couponList, removeStatus: RemoveCouponStatus.removeCouponSuccess);
        }
      } catch (e) {
        yield state.copyWith(
          removeStatus: RemoveCouponStatus.error,
          message: e.toString(),
        );
      }
    } 
  }
}
