import 'package:car_service/blocs/manager/createOrder/createOrder_bloc.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_state.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_event.dart';
import 'package:car_service/blocs/packageService/PackageService_bloc.dart';
import 'package:car_service/blocs/packageService/PackageService_state.dart';
import 'package:car_service/utils/model/CustomerModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderUI extends StatefulWidget {
  @override
  _CreateOrderUIState createState() => _CreateOrderUIState();
}

class _CreateOrderUIState extends State<CreateOrderUI> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  CreateOrderBloc createOrderBloc;

  final selectedColor = Colors.blue[700];
  final unselectedColor = Colors.black;

  @override
  void initState() {
    createOrderBloc = BlocProvider.of<CreateOrderBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String carId;
    bool _visibleBaoDuong = false;
    bool _visibleSuaChua = false;
    String selectItem;
    List<CustomerModel> listload;
    int _valueSelected = 0;
    bool _valueCheckbox = false;
    CreateOrderBloc _createOrderBloc;
    int _selectedTimeButton = 0;

    // final logo = Center(
    //   child: Icon(Icons.supervised_user_circle, size: 150),
    // );

    final name = TextFormField(
      maxLines: null,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black),
        hintText: 'Tài khoản',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value.contains('\n')) {
          createOrderBloc.add(DoCreateOrderDetailEvent(id: value));
        }
      },
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
            carId: '',
            cusId: '',
            serviceId: '',
            note: '',
          ));
        },
        padding: EdgeInsets.all(12),
        color: Colors.blue,
        child: Text(
          'Tạo đơn hàng',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo đơn hàng'),
      ),
      backgroundColor: Colors.blue[100],
      body: BlocListener<CreateOrderBloc, CreateOrderState>(
        listener: (context, state) {
          if (state.detailStatus == CreateDetailStatus.success) {
            listload = state.listCus;
            print(listload);
          }
        },
          child:
          SingleChildScrollView(
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
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Họ Tên:'),
                              Text(listload[0].fullname),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Email:'),
                              Text(listload[0].email),
                            ],
                          ),
                          Row(
                            children: [
                              Text('SĐT:'),
                              Text(listload[0].phoneNumber),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Địa chỉ:'),
                              Text(listload[0].address),
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
                                  color: Colors.white,
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
                  Visibility(
                      // visible: _visible,
                      child: Column(
                    children: <Widget>[
                      const Divider(
                        color: Colors.black87,
                        height: 20,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Text(
                        'Chọn dịch vụ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            RadioListTile(
                              value: 1,
                              groupValue: _valueSelected,
                              title: Text('Bảo Dưỡng'),
                              onChanged: (value) {
                                setState(() {
                                  _valueSelected = value;
                                  print(value);
                                  _visibleBaoDuong = true;
                                  _visibleSuaChua = false;
                                });
                              },
                            ),
                            Visibility(
                                visible: _visibleBaoDuong,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      // child: SingleChildScrollView(
                                      child: BlocBuilder<PackageServiceBloc,
                                          PackageServiceState>(
                                        // ignore: missing_return
                                        builder: (context, stateOfPackage) {
                                          if (stateOfPackage.status ==
                                              PackageServiceStatus.init) {
                                            return CircularProgressIndicator();
                                          } else if (stateOfPackage.status ==
                                              PackageServiceStatus.loading) {
                                            return CircularProgressIndicator();
                                          } else if (stateOfPackage.status ==
                                              PackageServiceStatus
                                                  .loadedPackagesSuccess) {
                                            if (stateOfPackage
                                                        .packageServiceLists !=
                                                    null &&
                                                stateOfPackage
                                                    .packageServiceLists
                                                    .isNotEmpty)
                                              return ListView.builder(
                                                itemCount: stateOfPackage
                                                    .packageServiceLists.length,
                                                shrinkWrap: true,
                                                // ignore: missing_return
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    child: ListTile(
                                                      title: Text(
                                                        stateOfPackage
                                                            .packageServiceLists[
                                                                index]
                                                            .name,
                                                        style: TextStyle(
                                                            color: (carId ==
                                                                    stateOfPackage
                                                                        .packageServiceLists[
                                                                            index]
                                                                        .name)
                                                                ? Colors.blue
                                                                : Colors.grey),
                                                      ),
                                                      subtitle: Text(stateOfPackage
                                                          .packageServiceLists[
                                                              index]
                                                          .name),
                                                      onTap: () {
                                                        setState(() {
                                                          carId = stateOfPackage
                                                              .packageServiceLists[
                                                                  index]
                                                              .name;
                                                        });
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                            else //nếu không có xe nào
                                              return Text(
                                                  'Không có thông tin xe');
                                          } else if (stateOfPackage.status ==
                                              PackageServiceStatus.error) {
                                            return ErrorWidget(stateOfPackage
                                                .message
                                                .toString());
                                          }
                                        },
                                      ),
                                      // ),
                                    )
                                  ],
                                )),
                            RadioListTile(
                              value: 2,
                              groupValue: _valueSelected,
                              title: Text('Sửa chữa'),
                              onChanged: (value) {
                                setState(() {
                                  _valueSelected = value;
                                  print(value);
                                  _visibleBaoDuong = false;
                                  _visibleSuaChua = true;
                                });
                              },
                            ),
                            Visibility(
                                visible: _visibleSuaChua, child: Text('data')),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                maxLines: 6,
                                decoration: InputDecoration.collapsed(
                                    hintText: 'Mô tả'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                  createOrderButton,
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        
      ),
    );
  }
}
