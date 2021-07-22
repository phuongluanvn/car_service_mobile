import 'package:car_service/blocs/login/auth_bloc.dart';
import 'package:car_service/blocs/login/auth_events.dart';
import 'package:car_service/blocs/login/auth_state.dart';
import 'package:car_service/ui/SignUpUi.dart';
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
      if (state is LoginErrorState) {
        return Text(state.message);
      } else if (state is LoginLoadingState) {
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
      obscureText: true,
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
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.only(left: 50, right: 50),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.055,
        child: ElevatedButton(
          onPressed: () {
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ManagerLoginSuccessState) {
            Navigator.pushNamed(context, '/manager');
          } else if (state is StaffLoginSuccessState) {
            Navigator.pushNamed(context, '/staff');
          } else if (state is CustomerLoginSuccessState) {
            Navigator.pushNamed(context, '/customer');
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
              height: 40,
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
            forgetPass,
          ],
        ),
      ),
    );
  }
}
