import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderUI.dart';
import 'package:car_service/ui/Manager/ManagerAccountUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/ProcessOrderManagement/ProcessOrderUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingManagement/VerifyBookingUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderUi.dart';

import 'package:flutter/material.dart';

class TabOrderCustomer extends StatefulWidget {
  @override
  _TabOrderState createState() => _TabOrderState();
}

class _TabOrderState extends State<TabOrderCustomer> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    CustomerOrderUi(),
    AssignOrderUi(),
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
          title: Text('Order'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ManagerAccountUi()));
                },
                child: Icon(Icons.create),
              ),
            )
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Đơn hàng',
              ),
              Tab(
                text: 'Lịch sử',
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
