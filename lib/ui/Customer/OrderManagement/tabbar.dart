import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/OrderManagement/CheckingOrdermanagement/CheckingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/ConfirmOrderManagement/ConfirmOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CreateOrderManagement/CreateBookingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/ProcessingOrderManagement/ProcessingOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/WaitingConfirmOrderManagement/WaitingConfirmOrderUI.dart';
import 'package:flutter/material.dart';

class TabOrderCustomer extends StatefulWidget {
  @override
  _TabOrderState createState() => _TabOrderState();
}

class _TabOrderState extends State<TabOrderCustomer> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    CustomerOrderUi(),
    ConfirmOrderUI(),
    CheckingOrderUI(),
    ProcessingOrderUI(),
    WaitingConfirmOrderUI()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
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
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: 'Tất cả đơn hàng',
              ),
              Tab(
                text: 'Đợi phản hồi',
              ),
              Tab(
                text: 'Kiểm tra',
              ),
              Tab(
                text: 'Đang tiến hành',
              ),
              Tab(
                text: 'Đợi xác nhận',
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
