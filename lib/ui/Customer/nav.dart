import 'package:car_service/ui/Customer/CarManagement/CustomerCarUI.dart';
import 'package:car_service/ui/Customer/CustomerProfile.dart';
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description,
            ),
            title: Text(
              'Order',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              'Home',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text(
              'Profile',
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
      ),
    );
  }
}
