import 'package:car_service/blocs/manager/booking/booking_bloc.dart';
import 'package:car_service/blocs/manager/booking/booking_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/LoginUi.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagerAccountUi extends StatefulWidget {
  // ManagerAccountUi() : super(key: key);

  @override
  _ManagerAccountUiState createState() => _ManagerAccountUiState();
}

class _ManagerAccountUiState extends State<ManagerAccountUi> {
  String _fullName = '';
  String _email = '';
  String _phoneNumber = '';
  String _dateOfBirth = '';
  String _status = '';
  bool _isShown = true;

  @override
  void initState() {
    super.initState();
    _getStringFromSharedPref();
  }

  _getStringFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final fullname = prefs.getString('Fullname');
    final phoneNumber = prefs.getString('PhoneNumber');
    final dateOfBirth = prefs.getString('DateOfBirth');
    final status = prefs.getString('Status');

    setState(() {
      _fullName = fullname;
      _phoneNumber = phoneNumber;
      _dateOfBirth = dateOfBirth;
      _status = status;
    });
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput), [dd, '-', mm, '-', yyyy]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Thông tin cá nhân'),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        overflow: Overflow.visible,
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.person),
                            backgroundColor: AppTheme.colors.deepBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppTheme.colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Thông tin tài khoản',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                'Họ tên:',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              child: Text(
                                _fullName,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                        Container(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                'Số điện thoại:',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              child: Text(
                                _phoneNumber,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                        Container(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                'Ngày sinh:',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              child: Text(
                                _convertDate(_dateOfBirth),
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Xác nhận'),
            content: Text('Bạn xác nhận muốn thoát ứng dụng?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // hide the box
                    setState(() {
                      _isShown = false;
                    });

                    // Close the dialog
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginUi()));
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
