import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/LoginUi.dart';
import 'package:car_service/ui/Manager/ManagerAccountUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/OrderHistory/OrderHistoryUi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagerProfile extends StatefulWidget {
  @override
  _ManagerProfileState createState() => _ManagerProfileState();
}

class _ManagerProfileState extends State<ManagerProfile> {
  String _fullName = '';
  bool _isShown = true;

  @override
  void initState() {
    super.initState();
    _getStringFromSharedPref();
  }

  _getStringFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final fullname = prefs.getString('Fullname');

    setState(() {
      _fullName = fullname;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin người dùng'),
        automaticallyImplyLeading: false,
        foregroundColor: AppTheme.colors.deepBlue,
        backgroundColor: AppTheme.colors.deepBlue,
        shadowColor: AppTheme.colors.deepBlue,
      ),
      backgroundColor: AppTheme.colors.deepBlue,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  overflow: Overflow.visible,
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.person,
                        color: AppTheme.colors.deepBlue,
                        size: 45,
                      ),
                      backgroundColor: AppTheme.colors.lightblue,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                height: 50,
                child: Text(
                  _fullName,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.colors.lightblue),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Container(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppTheme.colors.lightblue),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ManagerAccountUi()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.person, color: AppTheme.colors.deepBlue),
                      Padding(
                        padding: EdgeInsets.only(right: 150),
                        child: Text(
                          'Tài khoản',
                          style: TextStyle(
                              fontSize: 20, color: AppTheme.colors.deepBlue),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: AppTheme.colors.deepBlue),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Container(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppTheme.colors.lightblue),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => OrderHistoryUi()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.history,
                        color: AppTheme.colors.deepBlue,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 80),
                        child: Text(
                          'Lịch sử đơn hàng',
                          style: TextStyle(
                              fontSize: 20, color: AppTheme.colors.deepBlue),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: AppTheme.colors.deepBlue),
                    ],
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            //   child: Container(
            //     height: 50,
            //     child: ElevatedButton(
            //       style:
            //           ElevatedButton.styleFrom(primary: AppTheme.colors.blue),
            //       onPressed: () {},
            //       child: Row(
            //         children: [
            //           Expanded(child: Text('Đánh giá')),
            //           Icon(Icons.arrow_forward_ios),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Container(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppTheme.colors.lightblue),
                  onPressed: _isShown == true ? () => _logout(context) : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.logout, color: AppTheme.colors.deepBlue),
                      Padding(
                        padding: EdgeInsets.only(right: 150),
                        child: Text(
                          'Đăng xuất',
                          style: TextStyle(
                              fontSize: 20, color: AppTheme.colors.deepBlue),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: AppTheme.colors.deepBlue),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Xác nhận'),
            content: Text('Bạn có chắc muốn đăng xuất không?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // hide the box
                    setState(() {
                      _isShown = false;
                    });

                    // Close the dialog
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LoginUi(),
                        ),
                        (route) => false);
                  },
                  child: Text('Có')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Không'))
            ],
          );
        });
  }
}
