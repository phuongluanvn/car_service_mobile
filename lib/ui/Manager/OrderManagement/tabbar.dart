import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderUi.dart';

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
          title: Text('Management'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Booking',
              ),
              Tab(
                text: 'Order',
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
