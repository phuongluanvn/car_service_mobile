import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/OrderManagement/ConfirmOrderManagement/ConfirmOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CreateOrderManagement/CreateBookingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderUI.dart';
import 'package:flutter/material.dart';

class TabOrderCustomer extends StatefulWidget {
  @override
  _TabOrderState createState() => _TabOrderState();
}

class _TabOrderState extends State<TabOrderCustomer> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    CustomerOrderUi(),
    // ConfirmOrderUI(orderId: '7380a13f-bfc1-4cd8-9847-7c95ae7f8fc1',),
    ConfirmOrderUI(),
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
          title: Text('Đơn hàng'),
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
            tabs: <Widget>[
              Tab(
                text: 'Đơn hàng hiện tại',
              ),
              Tab(
                text: 'Đơn đợi phản hồi',
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
