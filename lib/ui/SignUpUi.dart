import 'package:car_service/blocs/sign_up/sign_up_bloc.dart';
import 'package:car_service/blocs/sign_up/sign_up_events.dart';
import 'package:car_service/blocs/sign_up/sign_up_state.dart';
import 'package:car_service/ui/LoginUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpUi extends StatefulWidget {
  @override
  _SignUpUiState createState() => _SignUpUiState();
}

class _SignUpUiState extends State<SignUpUi> {
  TextEditingController username = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController _address = TextEditingController();

  TextEditingController confirmpassword = TextEditingController();
  SignUpBloc signUpBloc;

  @override
  void initState() {
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Center(
        child: Image.asset(
      'lib/images/logo_blue.png',
      height: 100,
      width: 100,
    ));

    final msg = BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      if (state.status == SignUpStatus.error) {
        return Text(state.message.toString());
      } else if (state.status == SignUpStatus.loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Container();
      }
    });

    final user = TextField(
      controller: username,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person, color: Color.fromRGBO(8, 56, 99, 1)),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Tên đăng nhập',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final name = TextField(
      controller: fullname,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.face, color: Color.fromRGBO(8, 56, 99, 1)),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Họ tên',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final emailaddress = TextField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email, color: Color.fromRGBO(8, 56, 99, 1)),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final address = TextField(
      controller: _address,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email, color: Color.fromRGBO(8, 56, 99, 1)),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Địa chỉ',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final phone = TextField(
      controller: phoneNumber,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone, color: Color.fromRGBO(8, 56, 99, 1)),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Số điện thoại',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final pass = TextField(
      controller: password,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: Color.fromRGBO(8, 56, 99, 1)),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Mật khẩu',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final confirmpass = TextFormField(
      controller: confirmpassword,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: Color.fromRGBO(8, 56, 99, 1)),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Xác nhận mật khẩu',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (String value) {
        if (password.text != confirmpassword.text) {
          return "Mật khẩu xác nhận không khớp! Vui lòng thử lại";
        }
        return null;
      },
    );

    final signUpButton = Padding(
      padding: EdgeInsets.only(left: 50, right: 50),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.055,
        child: ElevatedButton(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(24),
          // ),
          onPressed: () {
            signUpBloc.add(SignUpButtonPressed(
                username: username.text,
                password: password.text,
                email: email.text,
                fullname: fullname.text,
                phoneNumber: phoneNumber.text,
                address: _address.text));
          },
          style:
              ElevatedButton.styleFrom(primary: Color.fromRGBO(8, 56, 99, 1)),
          // padding: EdgeInsets.all(12),
          // color: Colors.lightBlueAccent,
          child: Text(
            'Tạo tài khoản',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    _showSuccessCreateCarDialog() {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                'Thông báo!',
                style: TextStyle(color: Colors.greenAccent),
              ),
              content: Text('Tạo tài khoản thành công!'),
              actions: [
                TextButton(
                    onPressed: () {
                      // Close the dialog
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => LoginUi()));
                    },
                    child: Text('Đồng ý'))
              ],
            );
          });
    }

    _showErrorCreateCarDialog(String message) {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(
                'Thông báo!',
                style: TextStyle(color: Colors.greenAccent),
              ),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      // Close the dialog
                      Navigator.pop(context);
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (_) => LoginUi()));
                    },
                    child: Text('Đồng ý'))
              ],
            );
          });
    }

    final signInLink = Padding(
        padding: EdgeInsets.zero,
        child: TextButton(
          child: Text('Bạn đã có tài khoản? Đăng nhập!'),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginUi()));
          },
        ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.status == SignUpStatus.signUpSuccess) {
            _showSuccessCreateCarDialog();
          } 
          // else {
          //   _showErrorCreateCarDialog(state.message);
          // }
        },
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24, right: 24),
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            logo,
            msg,
            SizedBox(
              height: 40,
            ),
            user,
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
            name,
            SizedBox(
              height: 20,
            ),
            emailaddress,
            SizedBox(
              height: 20,
            ),
            phone,
            SizedBox(
              height: 20,
            ),
            address,
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
