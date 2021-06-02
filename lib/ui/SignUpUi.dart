import 'package:car_service/blocs/login/auth_bloc.dart';
import 'package:car_service/blocs/login/auth_events.dart';
import 'package:car_service/blocs/login/auth_state.dart';
import 'package:car_service/ui/LoginUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpUi extends StatefulWidget {
  @override
  _SignUpUiState createState() => _SignUpUiState();
}

class _SignUpUiState extends State<SignUpUi> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Center(
      child: Icon(Icons.supervised_user_circle, size: 150),
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
        prefixIcon: Icon(Icons.email),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final pass = TextField(
      controller: password,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final confirmpass = TextFormField(
      controller: confirmpassword,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Re-Enter Password',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (String value) {
        if (password.text != confirmpassword.text) {
          return "Password does not match";
        }
        return null;
      },
    );

    final signUpButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          authBloc.add(
              LoginButtonPressed(email: email.text, password: password.text));
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    final signInLink = SafeArea(
        child: TextButton(
      child: Text('Already have an account? Sign In.'),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginUi()));
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
          padding: EdgeInsets.only(left: 24, right: 24),
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
            confirmpass,
            SizedBox(
              height: 20,
            ),
            signUpButton,
            SizedBox(
              height: 20,
            ),
            signInLink,
          ],
        ),
      ),
    );
  }
}
