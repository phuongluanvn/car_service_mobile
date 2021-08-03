import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/OrderModel.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerOrderBloc extends Bloc<CustomerOrderEvent, CustomerOrderState> {
  CustomerRepository _repo;

  CustomerOrderBloc({CustomerRepository repo})
      : _repo = repo,
        super(CustomerOrderState());

  @override
  Stream<CustomerOrderState> mapEventToState(CustomerOrderEvent event) async* {
    if (event is DoOrderListEvent) {
      List<OrderModel> currentOrderList = [];
      List<OrderModel> historyOrderList = [];

      yield state.copyWith(status: CustomerOrderStatus.loading);
      try {
        final prefs = await SharedPreferences.getInstance();
        final _username = prefs.getString('Username');
        if (_username != null) {
          var orderLists = await _repo.getOrderList(_username);
          //lay curent
          orderLists
              .map((order) => {
                    if (order.status != 'Checkin')
                      {currentOrderList.add(order)}
                    else if (order.status == 'Finish')
                      {historyOrderList.add(order)}
                  })
              .toList();
          if (orderLists != null) {
            yield state.copyWith(
                orderLists: orderLists,
                orderCurrentLists: currentOrderList,
                orderHistoryLists: historyOrderList,
                status: CustomerOrderStatus.loadedOrderSuccess);
          }
        } else {
          yield state.copyWith(
            status: CustomerOrderStatus.error,
            message: 'Error',
          );
          print('no data');
        }
      } catch (e) {
        yield state.copyWith(
          status: CustomerOrderStatus.error,
          message: e.toString(),
        );
        ;
      }
    } else if (event is DoOrderDetailEvent) {
      yield state.copyWith(detailStatus: CustomerOrderDetailStatus.loading);
      try {
        var data = await _repo.getOrderDetail(event.id);
        print('object');
        print(data);
        if (data != null) {
          yield state.copyWith(
            detailStatus: CustomerOrderDetailStatus.success,
            orderDetail: data,
          );
        } else {
          yield state.copyWith(
            detailStatus: CustomerOrderDetailStatus.error,
            message: 'Error ?????',
          );
        }
      } catch (e) {
        yield state.copyWith(
            detailStatus: CustomerOrderDetailStatus.error,
            message: e.toString());
      }
    } else if (event is DoConfirmOrderEvent) {
      print('vào đi được chưa');
    }
  }
}
