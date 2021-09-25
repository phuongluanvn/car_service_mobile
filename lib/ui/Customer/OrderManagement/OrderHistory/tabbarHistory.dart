import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/OrderManagement/AcceptedOrderManagement/AcceptedOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CheckingOrdermanagement/CheckingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/ConfirmOrderManagement/ConfirmOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CreateOrderManagement/CreateBookingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/OrderHistory/CustomerCarWithOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/OrderHistory/OrderHistoryUi.dart';
import 'package:car_service/ui/Customer/OrderManagement/ProcessingOrderManagement/ProcessingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/WaitingConfirmOrderManagement/WaitingConfirmOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/WaitingPaymentOrderManagement/WaitingPayment.dart';
import 'package:flutter/material.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;
class TabOrderHistoryCustomer extends StatefulWidget {
  @override
  _TabOrderHistoryState createState() => _TabOrderHistoryState();
}

class _TabOrderHistoryState extends State<TabOrderHistoryCustomer> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    OrderHistoryUi(),
    CustomerCarWithOrderUi(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lịch sử'),
          backgroundColor: AppTheme.colors.deepBlue,
          // automaticallyImplyLeading: false,
          // actions: <Widget>[
          //   Padding(
          //     padding: EdgeInsets.only(right: 20),
          //     child: GestureDetector(
          //       onTap: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //             builder: (_) => CreateBookingOrderUI()));
          //       },
          //       child: Icon(Icons.add_box_outlined),
          //     ),
          //   )
          // ],
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: 'Theo đơn',
              ),
              Tab(
                text: 'Theo xe',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: _widgetOptions,
        ),
      ),
    );
  }
}
