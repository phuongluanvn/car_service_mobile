import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/NotificationUI.dart';
import 'package:car_service/ui/Manager/OrderManagement/ManagementBookingOrder.dart';
import 'package:car_service/ui/Manager/ManagerProfileUi.dart';
import 'package:car_service/ui/Manager/StaffManagement/StaffUi.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 1;
  List<Widget> _widgetOptions = <Widget>[
    StaffUi(),
    ManagementBookingOrder(),
    ManagerProfile(),
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
              Icons.engineering,
              color: AppTheme.colors.deepBlue,
            ),
            label: 'Nhân viên',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description,
              color: AppTheme.colors.deepBlue,
            ),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: AppTheme.colors.deepBlue,
            ),
            label: 'Thông tin',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.colors.deepBlue,
        onTap: _onItemTap,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
      ),
    );
  }
}
