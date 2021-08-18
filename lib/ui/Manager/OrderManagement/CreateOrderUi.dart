import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/customer/customerOrder/CreateBooking_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CreateBooking_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CreateBooking_state.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_bloc.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_state.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_event.dart';
import 'package:car_service/blocs/packageService/PackageService_bloc.dart';
import 'package:car_service/blocs/packageService/PackageService_event.dart';
import 'package:car_service/blocs/packageService/PackageService_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
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
  String _carId;
  String _packageId;
  String _note;
  DateTime _timeCurrenBooking = new DateTime.now();
  bool _visibleBaoDuong = false;
  bool _visibleSuaChua = false;
  String selectItem;
  List<CustomerModel> listload;
  int _valueSelected = 0;
  bool _valueCheckbox = false;
  CreateOrderBloc _createOrderBloc;
  int _selectedTimeButton = 0;
  DateTime _focusedDay = DateTime.now();

  final Color selectedColor = AppTheme.colors.lightblue;
  final Color unselectedColor = Colors.black;
  CreateBookingBloc _createBookingBloc;
  @override
  void initState() {
    BlocProvider.of<PackageServiceBloc>(context)
        .add(DoPackageServiceListEvent());
    createOrderBloc = BlocProvider.of<CreateOrderBloc>(context);
    _createBookingBloc = BlocProvider.of<CreateBookingBloc>(context);
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
        prefixIcon: Icon(Icons.person),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black),
        hintText: 'Tìm kiếm tài khoản',
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

    final createOrderButton =
        BlocListener<CreateBookingBloc, CreateBookingState>(
      listener: (context, state) {
        if (state.status == CreateBookingStatus.createBookingOrderSuccess) {
          // Navigator.pop(context);
          Navigator.pop(
            context,
            new MaterialPageRoute(builder: (context) => ManagerMain()),
          );
        }
      },
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppTheme.colors.blue, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          if (_carId == null) {
            showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return AlertDialog(
                    title: Text(
                      'Thông báo!',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    content: Text('Vui lòng chọn xe!'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            // Close the dialog
                            Navigator.of(context).pop();
                          },
                          child: Text('Đồng ý'))
                    ],
                  );
                });
          } else if (_note == null) {
            _createBookingBloc.add(CreateBookingButtonPressed(
              carId: _carId,
              serviceId: _packageId,
              note: null,
              timeBooking: _focusedDay.toIso8601String(),
            ));
          } else if (_packageId == null) {
            _createBookingBloc.add(CreateBookingButtonPressed(
              carId: _carId,
              serviceId: null,
              note: _note,
              timeBooking: _focusedDay.toIso8601String(),
            ));
          }
        },
        child: Text('Xác nhận'),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Tạo đơn hàng'),
      ),
      backgroundColor: AppTheme.colors.lightblue,
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
                                color: AppTheme.colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Thông tin khách hàng',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Text(
                                        'Họ tên:',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        listload[0].fullname,
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(height: 16),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Text(
                                        'Email:',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        listload[0].email,
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(height: 16),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Text(
                                        'Số điện thoại:',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        listload[0].phoneNumber,
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(height: 16),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Text(
                                        'Địa chỉ:',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        listload[0].address,
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(height: 16),
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
                                                        color: (_carId ==
                                                                state
                                                                    .vehicleLists[
                                                                        index]
                                                                    .id)
                                                            ? AppTheme
                                                                .colors.blue
                                                            : Colors.white,
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
                                                                color: (_carId ==
                                                                        state
                                                                            .vehicleLists[
                                                                                index]
                                                                            .id)
                                                                    ? AppTheme
                                                                        .colors
                                                                        .white
                                                                    : AppTheme
                                                                        .colors
                                                                        .deepBlue),
                                                          ),
                                                          subtitle: Text(
                                                            state
                                                                    .vehicleLists[
                                                                        index]
                                                                    .manufacturer +
                                                                " - " +
                                                                state
                                                                    .vehicleLists[
                                                                        index]
                                                                    .model,
                                                            style: TextStyle(
                                                                color: (_carId ==
                                                                        state
                                                                            .vehicleLists[
                                                                                index]
                                                                            .id)
                                                                    ? AppTheme
                                                                        .colors
                                                                        .white
                                                                    : AppTheme
                                                                        .colors
                                                                        .deepBlue),
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              _carId = state
                                                                  .vehicleLists[
                                                                      index]
                                                                  .id;
                                                              print(_carId);
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
                                color: AppTheme.colors.white,
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
                                                                      color: (_packageId == stateOfPackage.packageServiceLists[index].id)
                                                                          ? AppTheme
                                                                              .colors
                                                                              .deepBlue
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
                                                                    _packageId =
                                                                        stateOfPackage
                                                                            .packageServiceLists[index]
                                                                            .id;
                                                                    print(
                                                                        _packageId);
                                                                    _note =
                                                                        null;
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: AppTheme.colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: InputDecorator(
                                                decoration: InputDecoration(
                                                  labelText: 'Mô tả',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                child: TextFormField(
                                                  maxLines: 6,
                                                  onChanged: (noteValue) {
                                                    setState(() {
                                                      _packageId = null;
                                                      _note = noteValue;
                                                    });
                                                  },
                                                ),
                                              )),
                                        ),
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
