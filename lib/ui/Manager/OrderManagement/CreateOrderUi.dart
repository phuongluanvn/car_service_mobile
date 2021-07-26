import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_bloc.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_state.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_event.dart';
import 'package:car_service/blocs/packageService/PackageService_bloc.dart';
import 'package:car_service/blocs/packageService/PackageService_event.dart';
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
  CustomerCarBloc customerCarBloc;
  bool _testVi = false;
  String carId;
  bool _visibleBaoDuong = false;
  bool _visibleSuaChua = false;
  String selectItem;
  List<CustomerModel> listload;
  int _valueSelected = 0;
  bool _valueCheckbox = false;
  CreateOrderBloc _createOrderBloc;
  int _selectedTimeButton = 0;

  final selectedColor = Colors.blue[700];
  final unselectedColor = Colors.black;

  @override
  void initState() {
    BlocProvider.of<PackageServiceBloc>(context)
        .add(DoPackageServiceListEvent());
    createOrderBloc = BlocProvider.of<CreateOrderBloc>(context);
    customerCarBloc = BlocProvider.of<CustomerCarBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onChanged: (event) {
        createOrderBloc.add(DoCreateOrderDetailEvent(id: event));
        customerCarBloc.add(DoCarListWithIdEvent(vehicleId: event));

        print(event);
      },
      textInputAction: TextInputAction.search,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: name,
            ),
            BlocBuilder<CreateOrderBloc, CreateOrderState>(
              // ignore: missing_return
              builder: (context, state) {
                // return BlocListener<CreateOrderBloc, CreateOrderState>(
                //   listener: (context, state) {
                if (state.detailStatus == CreateDetailStatus.loading) {
                  return CircularProgressIndicator();
                } else if (state.detailStatus == CreateDetailStatus.success) {
                  listload = state.listCus;
                  _testVi = true;
                  print(listload[0].fullname);
                  return Visibility(
                    visible: _testVi,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
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
                                      horizontal: 0, vertical: 25),
                                  child: BlocBuilder<CustomerCarBloc,
                                      CustomerCarState>(
                                    // ignore: missing_return
                                    builder: (context, state) {
                                      if (state.withIdstatus ==
                                          CustomerCarWithIdStatus.init) {
                                        return CircularProgressIndicator();
                                      } else if (state.withIdstatus ==
                                          CustomerCarWithIdStatus.loading) {
                                        return CircularProgressIndicator();
                                      } else if (state.withIdstatus ==
                                          CustomerCarWithIdStatus
                                              .loadedCarSuccess) {
                                        if (state.vehicleLists != null &&
                                            state.vehicleLists.isNotEmpty)
                                          return Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black26),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Thông tin xe',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                GridView.builder(
                                                  itemCount:
                                                      state.vehicleLists.length,
                                                  shrinkWrap: true,
                                                  // ignore: missing_return
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio:
                                                        1.6, // Tỉ lệ chiều-ngang/chiều-rộng của một item trong grid, ở đây width = 1.6 * height
                                                    crossAxisCount:
                                                        2, // Số item trên một hàng ngang
                                                    crossAxisSpacing:
                                                        5, // Khoảng cách giữa các item trong hàng ngang
                                                    mainAxisSpacing: 0,
                                                    // Khoảng cách giữa các hàng (giữa các item trong cột dọc)
                                                  ),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      child: Card(
                                                        child: ListTile(
                                                          leading: CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'lib/images/car_default.png'),
                                                          ),
                                                          title: Text(
                                                            state
                                                                .vehicleLists[
                                                                    index]
                                                                .licensePlate,
                                                            style: TextStyle(
                                                                color: (carId ==
                                                                        state
                                                                            .vehicleLists[
                                                                                index]
                                                                            .id)
                                                                    ? Colors
                                                                        .blue
                                                                    : Colors
                                                                        .grey),
                                                          ),
                                                          subtitle: Text(state
                                                                  .vehicleLists[
                                                                      index]
                                                                  .manufacturer +
                                                              " - " +
                                                              state
                                                                  .vehicleLists[
                                                                      index]
                                                                  .model),
                                                          onTap: () {
                                                            setState(() {
                                                              carId = state
                                                                  .vehicleLists[
                                                                      index]
                                                                  .id;
                                                              // _visible = !_visible;
                                                            });
                                                          },
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        margin: EdgeInsets.only(
                                                            top: 0,
                                                            left: 2,
                                                            right: 2,
                                                            bottom: 40),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        else //nếu không có xe nào
                                          return Text('Không có thông tin xe');
                                      } else if (state.withIdstatus ==
                                          CustomerCarWithIdStatus.error) {
                                        return ErrorWidget(
                                            state.message.toString());
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black87,
                          height: 20,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Visibility(
                                // visible: _visible,
                                child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Chọn dịch vụ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
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
                                                child: BlocBuilder<
                                                    PackageServiceBloc,
                                                    PackageServiceState>(
                                                  // ignore: missing_return
                                                  builder: (context,
                                                      stateOfPackage) {
                                                    if (stateOfPackage.status ==
                                                        PackageServiceStatus
                                                            .init) {
                                                      return CircularProgressIndicator();
                                                    } else if (stateOfPackage
                                                            .status ==
                                                        PackageServiceStatus
                                                            .loading) {
                                                      return CircularProgressIndicator();
                                                    } else if (stateOfPackage
                                                            .status ==
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
                                                              .packageServiceLists
                                                              .length,
                                                          shrinkWrap: true,
                                                          // ignore: missing_return
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Card(
                                                              child: ListTile(
                                                                title: Text(
                                                                  stateOfPackage
                                                                      .packageServiceLists[
                                                                          index]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      color: (carId == stateOfPackage.packageServiceLists[index].name)
                                                                          ? Colors
                                                                              .blue
                                                                          : Colors
                                                                              .grey),
                                                                ),
                                                                subtitle: Text(
                                                                    stateOfPackage
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
                                                    } else if (stateOfPackage
                                                            .status ==
                                                        PackageServiceStatus
                                                            .error) {
                                                      return ErrorWidget(
                                                          stateOfPackage.message
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
                                            _visibleBaoDuong = false;
                                            _visibleSuaChua = true;
                                          });
                                        },
                                      ),
                                      Visibility(
                                          visible: _visibleSuaChua,
                                          child: Text('data')),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                              
                                              labelText: 'Mô tả',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                            child: TextFormField(
                                              maxLines: 6,
                                            ),
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ),
                        createOrderButton,
                      ],
                    ),
                  );
                }
                // },
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );

                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
