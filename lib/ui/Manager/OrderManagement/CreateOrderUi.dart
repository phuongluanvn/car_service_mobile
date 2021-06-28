import 'package:car_service/blocs/customer/customerCar/CreateCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CreateCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CreateCar_state.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderUI extends StatefulWidget {
  @override
  _CreateOrderUIState createState() => _CreateOrderUIState();
}

class _CreateOrderUIState extends State<CreateOrderUI> {
  TextEditingController username = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  CreateCarBloc createCarBloc;

  @override
  void initState() {
    createCarBloc = BlocProvider.of<CreateCarBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final logo = Center(
    //   child: Icon(Icons.supervised_user_circle, size: 150),
    // );

    final msg =
        BlocBuilder<CreateCarBloc, CreateCarState>(builder: (context, state) {
      if (state.status == CreateCarStatus.error) {
        return Text(state.message.toString());
      } else if (state.status == CreateCarStatus.loading) {
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
        prefixIcon: Icon(Icons.email),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Hãng xe',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final name = TextField(
      controller: fullname,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Loại xe',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final emailaddress = TextField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Biển số',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final createCarButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          createCarBloc.add(CreateCarButtonPressed(
            manufacturer: username.text,
            model: fullname.text,
            licensePlateNumber: email.text,
          ));
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text(
          'Tạo đơn',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo đơn'),
      ),
      backgroundColor: Colors.blue[100],
      body: BlocListener<CreateCarBloc, CreateCarState>(
          listener: (context, state) {
            if (state.status == CreateCarStatus.createCarSuccess) {
              print('object');
              Navigator.pushNamed(context, '/customer');
            }
          },
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24, right: 24),
              children: <Widget>[
                msg,
                SizedBox(
                  height: 40,
                ),
                user,
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
                createCarButton,
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    );
  }
}
