import 'package:car_service/blocs/sign_up/sign_up_bloc.dart';
import 'package:car_service/blocs/sign_up/sign_up_events.dart';
import 'package:car_service/blocs/sign_up/sign_up_state.dart';
import 'package:car_service/ui/LoginUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCustomerCarUi extends StatefulWidget {
  @override
  _CreateCustomerCarUiState createState() => _CreateCustomerCarUiState();
}

class _CreateCustomerCarUiState extends State<CreateCustomerCarUi> {
  TextEditingController username = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  SignUpBloc signUpBloc;

  @override
  void initState() {
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thêm mới xe'),),
      body: Center(child: Text('hihihihi'),),
    );
    // final logo = Center(
    //   child: Icon(Icons.supervised_user_circle, size: 150),
    // );

    // final msg = BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
    //   if (state is SignUpErrorState) {
    //     return Text(state.message);
    //   } else if (state is SignUpLoadingState) {
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   } else {
    //     return Container();
    //   }
    // });

    // final user = TextField(
    //   controller: username,
    //   autofocus: false,
    //   decoration: InputDecoration(
    //     prefixIcon: Icon(Icons.email),
    //     filled: true,
    //     fillColor: Colors.white,
    //     hintStyle: TextStyle(color: Colors.black54),
    //     hintText: 'Username',
    //     contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    //   ),
    // );

    // final name = TextField(
    //   controller: fullname,
    //   autofocus: false,
    //   decoration: InputDecoration(
    //     prefixIcon: Icon(Icons.email),
    //     filled: true,
    //     fillColor: Colors.white,
    //     hintStyle: TextStyle(color: Colors.black54),
    //     hintText: 'Fullname',
    //     contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    //   ),
    // );

    // final emailaddress = TextField(
    //   controller: email,
    //   keyboardType: TextInputType.emailAddress,
    //   autofocus: false,
    //   decoration: InputDecoration(
    //     prefixIcon: Icon(Icons.email),
    //     filled: true,
    //     fillColor: Colors.white,
    //     hintStyle: TextStyle(color: Colors.black54),
    //     hintText: 'Email',
    //     contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    //   ),
    // );

    // final phone = TextField(
    //   controller: phonenumber,
    //   autofocus: false,
    //   decoration: InputDecoration(
    //     prefixIcon: Icon(Icons.email),
    //     filled: true,
    //     fillColor: Colors.white,
    //     hintStyle: TextStyle(color: Colors.black54),
    //     hintText: 'PhoneNumber',
    //     contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    //   ),
    // );

    // final pass = TextField(
    //   controller: password,
    //   obscureText: true,
    //   autofocus: false,
    //   decoration: InputDecoration(
    //     prefixIcon: Icon(Icons.lock),
    //     filled: true,
    //     fillColor: Colors.white,
    //     hintStyle: TextStyle(color: Colors.black54),
    //     hintText: 'Password',
    //     contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    //   ),
    // );

    // final confirmpass = TextFormField(
    //   controller: confirmpassword,
    //   obscureText: true,
    //   autofocus: false,
    //   decoration: InputDecoration(
    //     prefixIcon: Icon(Icons.lock),
    //     filled: true,
    //     fillColor: Colors.white,
    //     hintStyle: TextStyle(color: Colors.black54),
    //     hintText: 'Re-Enter Password',
    //     contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    //   ),
    //   validator: (String value) {
    //     if (password.text != confirmpassword.text) {
    //       return "Password does not match";
    //     }
    //     return null;
    //   },
    // );

    // final signUpButton = Padding(
    //   padding: EdgeInsets.symmetric(vertical: 16),
    //   child: RaisedButton(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(24),
    //     ),
    //     onPressed: () {
    //       signUpBloc.add(SignUpButtonPressed(
    //           user: username.text,
    //           name: fullname.text,
    //           email: email.text,
    //           phone: phonenumber.text,
    //           password: password.text));
    //     },
    //     padding: EdgeInsets.all(12),
    //     color: Colors.lightBlueAccent,
    //     child: Text(
    //       'Sign Up',
    //       style: TextStyle(color: Colors.white),
    //     ),
    //   ),
    // );

    // final signInLink = SafeArea(
    //     child: TextButton(
    //   child: Text('Already have an account? Sign In.'),
    //   onPressed: () {
    //     Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => LoginUi()));
    //   },
    // ));

    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: BlocListener<SignUpBloc, SignUpState>(
    //     listener: (context, state) {
    //       if (state is CustomerSignUpSuccessState) {
    //         Navigator.pushNamed(context, '/customer');
    //       }
    //     },
    //     child: ListView(
    //       shrinkWrap: true,
    //       padding: EdgeInsets.only(left: 24, right: 24),
    //       children: <Widget>[
    //         logo,
    //         SizedBox(
    //           height: 20,
    //         ),
    //         msg,
    //         SizedBox(
    //           height: 40,
    //         ),
    //         user,
    //         SizedBox(
    //           height: 20,
    //         ),
    //         name,
    //         SizedBox(
    //           height: 20,
    //         ),
    //         emailaddress,
    //         SizedBox(
    //           height: 20,
    //         ),
    //         phone,
    //         SizedBox(
    //           height: 20,
    //         ),
    //         pass,
    //         SizedBox(
    //           height: 20,
    //         ),
    //         confirmpass,
    //         SizedBox(
    //           height: 20,
    //         ),
    //         signUpButton,
    //         SizedBox(
    //           height: 20,
    //         ),
    //         signInLink,
    //       ],
    //     ),
    //   ),
    // );
  }
}
