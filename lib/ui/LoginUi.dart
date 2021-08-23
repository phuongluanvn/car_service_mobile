import 'package:car_service/blocs/login/auth_bloc.dart';
import 'package:car_service/blocs/login/auth_events.dart';
import 'package:car_service/blocs/login/auth_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CustomerMainUI.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/SignUpUi.dart';
import 'package:car_service/ui/Staff/StaffHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginUi extends StatefulWidget {
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthBloc authBloc;
  bool _obscureText = true;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Center(
        child: Image.asset(
      'lib/images/logo_blue.png',
      height: 150,
      width: 150,
    )
        // Icon(Icons.supervised_user_circle, size: 130),
        );

    final msg = BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state.status == LoginStatus.error) {
        return Text(
          state.message,
          style: TextStyle(color: Colors.redAccent),
        );
      } else if (state.status == LoginStatus.loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Container();
      }
    });
    final username = TextField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person, color: Color.fromRGBO(8, 56, 99, 1)),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final pass = TextField(
      controller: password,
      obscureText: _obscureText,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Color.fromRGBO(8, 56, 99, 1),
        ),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? (Icons.visibility) : (Icons.visibility_off),
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.only(left: 50, right: 50),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.055,
        child: ElevatedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            authBloc.add(
                LoginButtonPressed(email: email.text, password: password.text));
          },
          // color: Color.fromRGBO(8, 56, 99, 1),
          style:
              ElevatedButton.styleFrom(primary: Color.fromRGBO(8, 56, 99, 1)),
          child: Text(
            'Đăng nhập',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    final signUpLink = Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 1),
      // child: SafeArea(
      child: TextButton(
        child: Text(
          'Tạo tài khoản mới!',
          // style: TextStyle(color: Color.fromRGBO(59, 102, 193, 1)),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpUi()));
        },
      ),
      // ),
    );

    final forgetPass = Padding(
        padding: EdgeInsets.zero,
        child: TextButton(
          child: Text(
            'Quên mật khẩu?',
            // style: TextStyle(color: Color.fromRGBO(59, 102, 193, 1)),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUpUi()));
          },
        ));

    Future showInformationDialog(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Form(
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.7,
                      // width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        children: [
                          Text(
                            'Sai tài khoản hoăc mật khẩu',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'Xác nhận',
                      style: TextStyle(color: AppTheme.colors.blue),
                    ),
                    onPressed: () {
                      // Do something like updating SharedPreferences or User Settings etc.

                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
          });
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == LoginStatus.managerSuccess) {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ManagerMain(),
                  ),
                  (route) => false);
            } else if (state.status == LoginStatus.staffSuccess) {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => StaffHomeUi(),
                  ),
                  (route) => false);
            } else if (state.status == LoginStatus.customerSuccess) {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => CustomerHome(),
                  ),
                  (route) => false);
            } else if (state.status == LoginStatus.error) {
              return SizedBox();
            }
          },
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24, right: 24, top: 50),
            children: <Widget>[
              logo,
              SizedBox(
                height: 20,
              ),
              msg,
              SizedBox(
                height: 5,
              ),
              username,
              SizedBox(
                height: 20,
              ),
              pass,
              SizedBox(
                height: 20,
              ),
              loginButton,
              // SizedBox(
              //   height: 20,
              // ),
              signUpLink,
              // forgetPass,
            ],
          ),
        ),
      ),
    );
  }
}
