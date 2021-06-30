import 'package:car_service/blocs/manager/createOrder/createOrder_bloc.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_state.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderUI extends StatefulWidget {
  @override
  _CreateOrderUIState createState() => _CreateOrderUIState();
}

class _CreateOrderUIState extends State<CreateOrderUI> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  CreateOrderBloc createOrderBloc;
  static const values = <String>['Sữa chữa', 'Bảo dưỡng'];
  String selectedValue = values.first;

  final selectedColor = Colors.blue[700];
  final unselectedColor = Colors.black;

  @override
  void initState() {
    createOrderBloc = BlocProvider.of<CreateOrderBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final logo = Center(
    //   child: Icon(Icons.supervised_user_circle, size: 150),
    // );

    final msg = BlocBuilder<CreateOrderBloc, CreateOrderState>(
        builder: (context, state) {
      if (state.status == CreateOrderStatus.error) {
        return Text(state.message.toString());
      } else if (state.status == CreateOrderStatus.loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Container();
      }
    });

    final name = TextField(
      controller: fullname,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Tài khoản',
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

    final createOrderButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          createOrderBloc.add(CreateOrderButtonPressed(
            manufacturer: fullname.text,
            licensePlateNumber: email.text,
          ));
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text(
          'Tạo đơn hàng',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    Widget buildRadios() => Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: unselectedColor,
          ),
          child: Column(
            children: values.map(
              (value) {
                final selected = this.selectedValue == value;
                final color = selected ? selectedColor : unselectedColor;

                return RadioListTile<String>(
                  value: value,
                  groupValue: selectedValue,
                  title: Text(
                    value,
                    style: TextStyle(color: color),
                  ),
                  activeColor: selectedColor,
                  onChanged: (value) =>
                      setState(() => this.selectedValue = value),
                );
              },
            ).toList(),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo đơn hàng'),
      ),
      backgroundColor: Colors.blue[100],
      body: BlocListener<CreateOrderBloc, CreateOrderState>(
          listener: (context, state) {
            if (state.status == CreateOrderStatus.createOrderSuccess) {
              print('object');
              Navigator.pushNamed(context, '/customer');
            }
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: name,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Họ Tên:'),
                              Text('1'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Email:'),
                              Text('2'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('SĐT:'),
                              Text('3'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Địa chỉ:'),
                              Text('4'),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: emailaddress,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Loại xe:'),
                                      Text('1'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Hãng xe:'),
                                      Text('2'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Màu sắc:'),
                                      Text('3'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          buildRadios(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              maxLines: 6,
                              decoration:
                                  InputDecoration.collapsed(hintText: 'Mô tả'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  createOrderButton,
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
