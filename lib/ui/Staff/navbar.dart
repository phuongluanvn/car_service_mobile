import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/NotificationUI.dart';
import 'package:car_service/ui/Manager/OrderManagement/ManagementBookingOrder.dart';
import 'package:car_service/ui/Manager/OrderManagement/VerifyBookingManagement/VerifyBookingUi.dart';
import 'package:car_service/ui/Manager/ManagerProfileUi.dart';
import 'package:car_service/ui/Manager/StaffManagement/StaffUi.dart';
import 'package:car_service/ui/Staff/OrderHistory/ScheduleListUi.dart';
import 'package:car_service/ui/Staff/StaffProfileUi.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    ScheduleListUi(),
    StaffProfileUi(),
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
