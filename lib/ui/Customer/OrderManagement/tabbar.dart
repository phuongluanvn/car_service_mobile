import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/OrderManagement/AcceptedOrderManagement/AcceptedOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CheckingOrdermanagement/CheckingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/ConfirmOrderManagement/ConfirmOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CreateOrderManagement/CreateBookingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/ProcessingOrderManagement/ProcessingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/WaitingConfirmOrderManagement/WaitingConfirmOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/WaitingPaymentOrderManagement/WaitingPayment.dart';
import 'package:flutter/material.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;
class TabOrderCustomer extends StatefulWidget {
  @override
  _TabOrderState createState() => _TabOrderState();
}

class _TabOrderState extends State<TabOrderCustomer> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    WaitingConfirmOrderUI(),
    AcceptedOrderUI(),
    CheckingOrderUI(),
    ProcessingOrderUI(),
    ConfirmOrderUI(),
    WaitingPaymentUI(),
    CustomerOrderUi(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Text(cusConstants.TABAR_TITLE),
          backgroundColor: AppTheme.colors.deepBlue,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CreateBookingOrderUI()));
                },
                child: Icon(Icons.add_box_outlined),
              ),
            )
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: cusConstants.WAITING_CONFIRM_ORDER_STATUS,
              ),
              Tab(
                text: cusConstants.ACCEPTED_ORDER_STATUS,
              ),
              Tab(
                text:cusConstants.CHECKING_ORDER_STATUS,
              ),
              Tab(
                text: cusConstants.IN_PROCESS_ORDER_STATUS,
              ),
              Tab(
                text: cusConstants.CONFIRM_ORDER_STATUS,
              ),
              Tab(
                text: cusConstants.WAITING_PAYMENT_ORDER_STATUS,
              ),
              Tab(
                text: cusConstants.ALL_ORDER,
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
