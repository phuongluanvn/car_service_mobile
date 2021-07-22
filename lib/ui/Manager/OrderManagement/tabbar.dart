import 'package:car_service/ui/Manager/ManagerAccountUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/CreateOrderUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/ProcessOrderManagement/ProcessOrderUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingManagement/VerifyBookingUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderUi.dart';

import 'package:flutter/material.dart';

class TabManager extends StatefulWidget {
  @override
  _TabManagerState createState() => _TabManagerState();
}

class _TabManagerState extends State<TabManager> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    VerifyBookingUi(),
    AssignOrderUi(),
    ProcessOrderUi()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Management'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CreateOrderUI()));
                },
                child: Icon(Icons.create),
              ),
            )
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Booking',
              ),
              Tab(
                text: 'Order',
              ),
              Tab(
                text: 'Processing',
              )
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
