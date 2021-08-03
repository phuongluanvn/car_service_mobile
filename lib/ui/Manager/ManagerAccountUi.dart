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
        title: Text('Thông tin tài khoản'),
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
                    padding: const EdgeInsets.symmetric(vertical: 40),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          tileColor: Colors.white,
                          leading: Icon(Icons.person),
                          title: Text(_fullName),
                        ),
                        Container(height: 16),
                        ListTile(
                          tileColor: Colors.white,
                          leading: Icon(Icons.phone),
                          title: Text(_phoneNumber),
                        ),
                        Container(height: 16),
                        ListTile(
                          tileColor: Colors.white,
                          leading: Icon(Icons.email),
                          title: Text(_phoneNumber),
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
