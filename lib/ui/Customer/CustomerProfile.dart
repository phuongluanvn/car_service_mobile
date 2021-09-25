import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CustomerAccountUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/OrderHistory/ManageOrderHistoryTab.dart';
import 'package:car_service/ui/Customer/OrderManagement/OrderHistory/OrderHistoryUi.dart';
import 'package:car_service/ui/LoginUi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;
class CustomerProfile extends StatefulWidget {
  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
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
        title: Text(cusConstants.INFO_ACCOUNT_TITLE),
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
                        MaterialPageRoute(builder: (_) => CustomerAccountUi()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.person, color: AppTheme.colors.deepBlue),
                      Padding(
                        padding: EdgeInsets.only(right: 150),
                        child: Text(
                          cusConstants.ACCOUNT,
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
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (_) => ManageOrderHistoryTab()));
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
                          cusConstants.HISTORY_ORDER,
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
                  onPressed: _isShown == true ? () => _logout(context) : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.logout, color: AppTheme.colors.deepBlue),
                      Padding(
                        padding: EdgeInsets.only(right: 150),
                        child: Text(
                          cusConstants.LOG_OUT_LABLE,
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
            title: Text(cusConstants.BUTTON_ACCEPT_TITLE),
            content: Text(cusConstants.LOG_OUT_QUESTION),
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
                  child: Text(cusConstants.BUTTON_YES)),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text(cusConstants.BUTTON_NO))
            ],
          );
        });
  }
}
