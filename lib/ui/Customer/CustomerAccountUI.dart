import 'package:car_service/blocs/customer/customerProfile/CustomerEditProfile_bloc.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerEditProfile_event.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerEditProfile_state.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerProfile_bloc.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerProfile_event.dart';
import 'package:car_service/blocs/customer/customerProfile/CustomerProfile_state.dart';
import 'package:car_service/blocs/login/auth_bloc.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/LoginUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;

class CustomerAccountUi extends StatefulWidget {
  // CustomerAccountUi() : super(key: key);

  @override
  _CustomerAccountUiState createState() => _CustomerAccountUiState();
}

class _CustomerAccountUiState extends State<CustomerAccountUi> {
  String _fullName = '';
  String _phoneNumber = '';
  String _address = '';
  String _email = '';
  String _username = '';
  String username;
  bool _isEdit = false;
  AuthBloc authBloc;
  EditProfileBloc _editProfileBloc;

  @override
  void initState() {
    super.initState();
    _getStringFromSharedPref();
  }

  _getStringFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('Username');

    _editProfileBloc = BlocProvider.of<EditProfileBloc>(context);
    BlocProvider.of<ProfileBloc>(context)
        .add(GetProfileByUsername(username: prefs.getString('Username')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text(cusConstants.INFO_ACCOUNT),
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
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  overflow: Overflow.visible,
                  children: [
                    CircleAvatar(),
                    Positioned(
                      right: -16,
                      bottom: 0,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: OutlineButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.white),
                          ),
                          color: Color(0xFFF5F6F9),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            BlocListener<EditProfileBloc, EditProfileState>(
              listener: (context, state) {
                if (state.status == EditProfileStatus.editSuccess) {
                  print('thanh cong');
                }
              },
              child: BlocBuilder<ProfileBloc, ProfileState>(
                // ignore: missing_return
                builder: (context, stateProfile) {
                  if (stateProfile.status == ProfileStatus.init) {
                    return CircularProgressIndicator();
                  } else if (stateProfile.status == ProfileStatus.loading) {
                    return CircularProgressIndicator();
                  } else if (stateProfile.status ==
                      ProfileStatus.getProflieSuccess) {
                    if (stateProfile.cusProfile != null &&
                        stateProfile.cusProfile.isNotEmpty) {
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
                                    stateProfile.cusProfile.last.username =
                                        newUserName;
                                  },
                                  initialValue:
                                      stateProfile.cusProfile.last.username,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(color: Colors.black54),
                                    labelText: cusConstants.ACCOUNT,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                    stateProfile.cusProfile.last.fullname =
                                        newFullname;
                                  },
                                  initialValue:
                                      stateProfile.cusProfile.last.fullname,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(color: Colors.black54),
                                    labelText: cusConstants.FULL_NAME,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                    stateProfile.cusProfile.last.phoneNumber =
                                        newPhone;
                                  },
                                  initialValue:
                                      stateProfile.cusProfile.last.phoneNumber,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(color: Colors.black54),
                                    labelText: cusConstants.PHONE_NUMBER,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                    stateProfile.cusProfile.last.email =
                                        newEmail;
                                  },
                                  initialValue:
                                      stateProfile.cusProfile.last.email,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(color: Colors.black54),
                                    labelText: cusConstants.EMAIL,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                    stateProfile.cusProfile.last.address =
                                        newAddress;
                                  },
                                  initialValue:
                                      stateProfile.cusProfile.last.address,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(color: Colors.black54),
                                    labelText: cusConstants.ADDRESS,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                  child: Text(cusConstants.BUTTON_SAVE_UPDATE,
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    _editProfileBloc.add(
                                        EditProfileButtonPressed(
                                            username: stateProfile
                                                .cusProfile.last.username,
                                            fullname: stateProfile
                                                .cusProfile.last.fullname,
                                            phoneNumber: stateProfile
                                                .cusProfile.last.phoneNumber,
                                            email: stateProfile
                                                .cusProfile.last.email,
                                            address: stateProfile
                                                .cusProfile.last.address));
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
                                      cusConstants.FULL_NAME_LABLE,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      stateProfile.cusProfile.first.fullname,
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
                                      cusConstants.PHONE_NUMBER_LABLE,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      stateProfile.cusProfile.first.email,
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
                                      cusConstants.PHONE_NUMBER_LABLE,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      stateProfile.cusProfile.first.phoneNumber,
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
                                      cusConstants.ADDRESS_LABLE,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      stateProfile.cusProfile.first.address,
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
                                      cusConstants.POINT_LABLE,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      stateProfile
                                          .cusProfile.first.accumulatedPoint
                                          .toString(),
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
                        child: Text(cusConstants.NOT_FOUND_INFO_ACCOUNT),
                      );
                    }
                  }
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
