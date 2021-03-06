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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;
class CouponUI extends StatefulWidget {
  final String orderId;
  CouponUI({@required this.orderId});

  @override
  _CouponUIState createState() => _CouponUIState();
}

class _CouponUIState extends State<CouponUI> {
  int point;
  int _point;
  CouponBloc _couponBloc;

  @override
  void initState() {
    print(widget.orderId);
    super.initState();
    _getStringFromSharedPref();
    _couponBloc = BlocProvider.of<CouponBloc>(context);
    context.read<CouponBloc>().add(DoListCouponEvent());
  }

  _getStringFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    point = prefs.getInt('AccumulatedPoint');

    setState(() {
      _point = point;
    });
    print(_point);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text(cusConstants.OFFER_TITLE),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: BlocListener<CouponBloc, CouponState>(
          listener: (context, state) {
            if (state.applyStatus == ApplyCouponStatus.applyCouponSuccess) {
              return Text('data');
            }
          },
          child: BlocBuilder<CouponBloc, CouponState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state.status == CouponStatus.init) {
                return CircularProgressIndicator();
              } else if (state.status == CouponStatus.loading) {
                return CircularProgressIndicator();
              } else if (state.status == CouponStatus.loadedCouponSuccess) {
                if (state.couponLists != null && state.couponLists.isNotEmpty)
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(5)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: ListView.builder(
                          itemCount: state.couponLists.length,
                          // ignore: missing_return
                          itemBuilder: (context, index) {
                            return Card(
                                child: Column(
                              children: [
                                ListTile(
                                  title: Text(state.couponLists[index].name +
                                      cusConstants.PRE_PARENTHESES +
                                      state.couponLists[index].pointRequired
                                          .toString() +
                                      cusConstants.NEXT_PARENTHESES),
                                  subtitle: Text(
                                      state.couponLists[index].description),
                                  trailing: (_point -
                                              state.couponLists[index]
                                                  .pointRequired) >=
                                          cusConstants.POINT_BEGIN
                                      ? ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: AppTheme.colors.blue),
                                          onPressed: () {
                                            print(state.couponLists[index].id);
                                            _couponBloc.add(DoApplyCouponEvent(
                                                id: state.couponLists[index].id,
                                                orderDetailId: widget.orderId));
                                          },
                                          child: Text(cusConstants.APPLY_TITLE),
                                        )
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.grey),
                                          onPressed: () {},
                                          child: Text(cusConstants.APPLY_TITLE),
                                        ),
                                )
                              ],
                            ));
                          }),
                    ),
                  );
                else
                  return Center(
                    child: Text(cusConstants.NOT_FOUND_OFFER),
                  );
              } else if (state.status == CouponStatus.error) {
                return ErrorWidget(state.message.toString());
              }
            },
          ),
        ),
      ), //th??m m???i xe
    );
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }
}
