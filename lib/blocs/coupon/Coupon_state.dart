import 'package:car_service/utils/model/CouponModel.dart';
import 'package:equatable/equatable.dart';
import '../../../utils/model/CarModel.dart';

enum CouponStatus {
  init,
  loading,
  loadedCouponSuccess,
  error,
}

class CouponState extends Equatable {
  final CouponStatus status;

  final List<CouponModel> couponLists;
  final String message;
  const CouponState({
    this.status: CouponStatus.init,
    this.couponLists: const [],
    this.message: '',
  });

  CouponState copyWith({
    CouponStatus status,
    List<CouponModel> vehicleDetail,
    List<CouponModel> couponLists,
    String message,
  }) =>
      CouponState(
        status: status ?? this.status,
        message: message ?? this.message,
        couponLists: couponLists ?? this.couponLists,
      );
  @override
  List<Object> get props => [
        status,
        couponLists,
        message,
      ];
}
