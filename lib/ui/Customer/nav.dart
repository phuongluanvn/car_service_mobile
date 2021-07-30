import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CarManagement/CustomerCarUI.dart';
import 'package:car_service/ui/Customer/CustomerProfile.dart';
import 'package:car_service/ui/Customer/NotificationUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/ManageOrderTab.dart';
import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 1;
  List<Widget> _widgetOptions = <Widget>[
    ManageOrderTab(),
    CustomerCarUi(),
    CustomerProfile(),
    NotificationUI(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description,
              color: AppTheme.colors.deepBlue,
            ),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.drive_eta,
              color: AppTheme.colors.deepBlue,
            ),
            label: 'Xe của tôi',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: AppTheme.colors.deepBlue,
            ),
            label: 'Thông tin',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: AppTheme.colors.deepBlue,
            ),
            label: 'Thông báo',
            // backgroundColor: Colors.blue87,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        // fixedColor: Colors.blue,
        selectedItemColor: AppTheme.colors.deepBlue,
      ),
    );
  }
}
