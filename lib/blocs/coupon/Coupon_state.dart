import 'package:car_service/utils/model/CouponModel.dart';
import 'package:equatable/equatable.dart';
// import '../../../utils/model/CarModel.dart';

enum CouponStatus {
  init,
  loading,
  loadedCouponSuccess,
  error,
}

enum ApplyCouponStatus {
  init,
  loading,
  applyCouponSuccess,
  error,
}

enum RemoveCouponStatus {
  init,
  loading,
  removeCouponSuccess,
  error,
}

class CouponState extends Equatable {
  final CouponStatus status;
  final ApplyCouponStatus applyStatus;
  final RemoveCouponStatus removeStatus;

  final List<CouponModel> couponLists;
  final String message;
  const CouponState({
    this.status: CouponStatus.init,
    this.applyStatus: ApplyCouponStatus.init,
    this.removeStatus: RemoveCouponStatus.init,
    this.couponLists: const [],
    this.message: '',
  });

  CouponState copyWith({
    CouponStatus status,
    ApplyCouponStatus applyStatus,
    RemoveCouponStatus removeStatus,
    List<CouponModel> vehicleDetail,
    List<CouponModel> couponLists,
    String message,
  }) =>
      CouponState(
        status: status ?? this.status,
        applyStatus: applyStatus ?? this.applyStatus,
        removeStatus: removeStatus ?? this.removeStatus,
        message: message ?? this.message,
        couponLists: couponLists ?? this.couponLists,
      );
  @override
  List<Object> get props => [
        status,
        removeStatus,
        applyStatus,
        couponLists,
        message,
      ];
}
