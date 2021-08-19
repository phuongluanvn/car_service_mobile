import 'package:car_service/blocs/coupon/Coupon_bloc.dart';
import 'package:car_service/blocs/coupon/Coupon_event.dart';
import 'package:car_service/blocs/coupon/Coupon_state.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/OrderManagement/ConfirmOrderManagement/ConfirmOrderDetailUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CreateOrderManagement/CreateBookingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderDetailUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/WaitingPaymentOrderManagement/PaymentOrderDetailUI.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponUI extends StatefulWidget {
  @override
  _CouponUIState createState() => _CouponUIState();
}

class _CouponUIState extends State<CouponUI> {
  @override
  void initState() {
    super.initState();

    context.read<CouponBloc>().add(DoListCouponEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: BlocBuilder<CouponBloc, CouponState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == CouponStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == CouponStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == CouponStatus.loadedCouponSuccess) {
              if (state.couponLists != null &&
                  state.couponLists.isNotEmpty)
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(
                      children: [
                      
                      ],
                    ),
                  ),
                );
              else
                return Center(
                  child: Text('Hiện tại không có đơn'),
                );
            } else if (state.status == CouponStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ), //thêm mới xe
    );
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }
}
