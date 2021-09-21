import 'package:car_service/blocs/manager/ManageProfile/ManagerEditProfile_bloc.dart';
import 'package:car_service/blocs/manager/ManageProfile/ManagerEditProfile_event.dart';
import 'package:car_service/blocs/manager/ManageProfile/ManagerEditProfile_state.dart';

import 'package:car_service/blocs/manager/ManageProfile/ManagerProfile_bloc.dart';
import 'package:car_service/blocs/manager/ManageProfile/ManagerProfile_event.dart';
import 'package:car_service/blocs/manager/ManageProfile/ManagerProfile_state.dart';

import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/LoginUi.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_service/utils/helpers/constants/ManagerConstants.dart'
    as manConstants;

class ManagerAccountUi extends StatefulWidget {
  // ManagerAccountUi() : super(key: key);

  @override
  _ManagerAccountUiState createState() => _ManagerAccountUiState();
}

class _ManagerAccountUiState extends State<ManagerAccountUi> {
  String username = '';
  bool _isShown = true;
  bool _isEdit = false;
  ManagerEditProfileBloc _editManagerProfileBloc;
  @override
  void initState() {
    super.initState();
    _getStringFromSharedPref();
  }

  _getStringFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('Username');
    print("Username is: + $username");
    _editManagerProfileBloc = BlocProvider.of<ManagerEditProfileBloc>(context);
    BlocProvider.of<ManagerProfileBloc>(context).add(
        GetManagerProfileByUsername(username: prefs.getString('Username')));
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
        actions: [
          _isEdit
              ? Text('')
              : IconButton(
                  onPressed: () {
                    setState(() {
                      _isEdit = true;
                    });
                  },
                  icon: Icon(Icons.edit))
        ],
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
                  BlocListener<ManagerEditProfileBloc, ManagerEditProfileState>(
                    listener: (context, state) {
                      if (state.status == EditProfileStatus.editSuccess) {
                        print('thanh cong');
                      }
                    },
                    child: BlocBuilder<ManagerProfileBloc, ManagerProfileState>(
                      // ignore: missing_return
                      builder: (context, stateProfile) {
                        if (stateProfile.status == ProfileStatus.init) {
                          return Center(child: CircularProgressIndicator());
                        } else if (stateProfile.status ==
                            ProfileStatus.loading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (stateProfile.status ==
                            ProfileStatus.getProflieSuccess) {
                          if (stateProfile.managerProfile != null &&
                              stateProfile.managerProfile.isNotEmpty) {
                            if (_isEdit) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 40),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        onChanged: (newUserName) {
                                          stateProfile.managerProfile.last
                                              .username = newUserName;
                                        },
                                        initialValue: stateProfile
                                            .managerProfile.last.username,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
                                          labelText: manConstants.ACCOUNT,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      TextFormField(
                                        onChanged: (newFullname) {
                                          stateProfile.managerProfile.last
                                              .fullname = newFullname;
                                        },
                                        initialValue: stateProfile
                                            .managerProfile.last.fullname,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
                                          labelText: manConstants.FULL_NAME,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      TextFormField(
                                        onChanged: (newPhone) {
                                          stateProfile.managerProfile.last
                                              .phoneNumber = newPhone;
                                        },
                                        initialValue: stateProfile
                                            .managerProfile.last.phoneNumber,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
                                          labelText: manConstants.PHONE_NUMBER,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      TextFormField(
                                        onChanged: (newEmail) {
                                          stateProfile.managerProfile.last
                                              .email = newEmail;
                                        },
                                        initialValue: stateProfile
                                            .managerProfile.last.email,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
                                          labelText: manConstants.EMAIL,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      TextFormField(
                                        onChanged: (newAddress) {
                                          stateProfile.managerProfile.last
                                              .address = newAddress;
                                        },
                                        initialValue: stateProfile
                                            .managerProfile.last.address,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
                                          labelText: manConstants.ADDRESS,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: AppTheme.colors.blue),
                                        child: Text(
                                            manConstants.BUTTON_SAVE_UPDATE,
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          _editManagerProfileBloc.add(
                                              EditManagerProfileButtonPressed(
                                                  username: stateProfile
                                                      .managerProfile
                                                      .last
                                                      .username,
                                                  fullname: stateProfile
                                                      .managerProfile
                                                      .last
                                                      .fullname,
                                                  phoneNumber: stateProfile
                                                      .managerProfile
                                                      .last
                                                      .phoneNumber,
                                                  email: stateProfile
                                                      .managerProfile
                                                      .last
                                                      .email,
                                                  address: stateProfile
                                                      .managerProfile
                                                      .last
                                                      .address));
                                          setState(() {
                                            _isEdit = false;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 40),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            manConstants.FULL_NAME_LABLE,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            stateProfile
                                                .managerProfile.first.fullname,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            manConstants.PHONE_NUMBER_LABLE,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            stateProfile
                                                .managerProfile.first.email,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            manConstants.PHONE_NUMBER_LABLE,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            stateProfile.managerProfile.first
                                                .phoneNumber,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            manConstants.ADDRESS_LABLE,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            stateProfile
                                                .managerProfile.first.address,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          } else {
                            return Center(
                              child: Text(manConstants.NOT_FOUND_INFO_ACCOUNT),
                            );
                          }
                        }
                      },
                    ),
                  )
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
