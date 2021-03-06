import 'dart:io';

import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
// import 'package:car_service/blocs/customer/customerOrder/CreateBooking_bloc.dart';
// import 'package:car_service/blocs/customer/customerOrder/CreateBooking_event.dart';
// import 'package:car_service/blocs/customer/customerOrder/CreateBooking_state.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:convert';
import 'package:image/image.dart' as ImageProcess;

class CreateOrderUI extends StatefulWidget {
  @override
  _CreateOrderUIState createState() => _CreateOrderUIState();
}

class _CreateOrderUIState extends State<CreateOrderUI> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  // CreateOrderBloc _createOrderBloc;
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
  bool _isSearchButton = false;
  String _valueSearch;
  List _packageIdList = [];
  final ImagePicker _picker = ImagePicker();
  // List<File> _imageFileList;
  File _image;
  List<Asset> images = List<Asset>();
  String imgUrl = '';
  final Color selectedColor = AppTheme.colors.lightblue;
  final Color unselectedColor = Colors.black;
  CreateOrderBloc _createBookingBloc;
  @override
  void initState() {
    BlocProvider.of<PackageServiceBloc>(context)
        .add(DoPackageServiceListEvent());
    _createOrderBloc = BlocProvider.of<CreateOrderBloc>(context);
    _createBookingBloc = BlocProvider.of<CreateOrderBloc>(context);
    customerCarBloc = BlocProvider.of<CustomerCarBloc>(context);
// createOrderBloc.add(DoCreateOrderDetailEvent(id: event));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final logo = Center(
    //   child: Icon(Icons.supervised_user_circle, size: 150),
    // );

//Select pic from gallery
    _imageFromGallery() async {
      PickedFile image = await ImagePicker()
          .getImage(source: ImageSource.gallery, imageQuality: 50);

      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      }
    }

    //Select pic from camera
    _imageFromCamera() async {
      PickedFile image = await ImagePicker()
          .getImage(source: ImageSource.camera, imageQuality: 50);

      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      }
    }

    _convertImagetoString(File images) {
      if (images != null) {
        final _imageFile = ImageProcess.decodeImage(images.readAsBytesSync());
        String base64image = base64Encode(ImageProcess.encodePng(_imageFile));
        return base64image;
      }
    }

    //show picker select pac form camera or gallery
    _showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
                child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Gallery'),
                  onTap: () {
                    _imageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                  onTap: () {
                    _imageFromCamera();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
          });
    }

    final name = TextFormField(
      // controller: username,
      maxLines: null,
      autofocus: false,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            _createOrderBloc.add(DoCreateOrderDetailEvent(id: _valueSearch));
            customerCarBloc.add(DoCarListWithIdEvent(vehicleId: _valueSearch));
            setState(() {
              _isSearchButton = true;
            });
          },
        ),
        prefixIcon: Icon(Icons.person),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black),
        hintText: 'T??m ki???m t??i kho???n',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onChanged: (event) {
        setState(() {
          _valueSearch = event;
        });
        print(_valueSearch);
      },
      textInputAction: TextInputAction.search,
    );

    // final createOrderButton = BlocListener<CreateOrderBloc, CreateOrderState>(
    //   listener: (context, state) {
    //     if (state.status == CreateOrderStatus.createOrderSuccess) {
    //       // Navigator.pop(context);
    //       showDialog(
    //           context: context,
    //           builder: (BuildContext ctx) {
    //             return AlertDialog(
    //               title: Text(
    //                 'Th??ng b??o!',
    //                 style: TextStyle(color: Colors.greenAccent),
    //               ),
    //               content: Text(state.message),
    //               actions: [
    //                 TextButton(
    //                     onPressed: () {
    //                       if (state.message == '?????t l???ch h???n th??nh c??ng') {
    //                         Navigator.of(context).pop();
    //                       } else {
    //                         Navigator.of(context).pop();
    //                         Navigator.pop(context);
    //                       }

    //                       // context
    //                       //     .read<CustomerOrderBloc>()
    //                       //     .add(DoOrderListEvent());
    //                     },
    //                     child: Text('?????ng ??'))
    //               ],
    //             );
    //           });
    //     }
    //   },
    //   child: ElevatedButton(
    //     style: ElevatedButton.styleFrom(
    //       primary: AppTheme.colors.blue, // background
    //       onPrimary: Colors.white, // foreground
    //     ),
    //     onPressed: () {
    //       print(_carId);
    //       print(_packageId);
    //       print(_note);
    //       print(_focusedDay.toIso8601String());
    //       if (_carId == null) {
    //         showDialog(
    //             context: context,
    //             builder: (BuildContext ctx) {
    //               return AlertDialog(
    //                 title: Text(
    //                   'Th??ng b??o!',
    //                   style: TextStyle(color: Colors.redAccent),
    //                 ),
    //                 content: Text('Vui l??ng ch???n xe!'),
    //                 actions: [
    //                   TextButton(
    //                       onPressed: () {
    //                         // Close the dialog
    //                         Navigator.of(context).pop();
    //                       },
    //                       child: Text('?????ng ??'))
    //                 ],
    //               );
    //             });
    //       } else if (_note == null) {
    //         _createBookingBloc.add(CreateOrderButtonPressed(
    //           carId: _carId,
    //           serviceId: _packageId,
    //           note: null,
    //           timeBooking: _focusedDay.toIso8601String(),
    //         ));
    //       } else if (_packageId == null) {
    //         _createBookingBloc.add(CreateOrderButtonPressed(
    //           carId: _carId,
    //           serviceId: null,
    //           note: _note,
    //           timeBooking: _focusedDay.toIso8601String(),
    //         ));
    //       }
    //     },
    //     child: Text('X??c nh???n'),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('T???o ????n h??ng'),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: name,
            ),
            _isSearchButton
                ? BlocBuilder<CreateOrderBloc, CreateOrderState>(
                    // ignore: missing_return
                    builder: (context, state) {
                      print(username.text);
                      // return BlocListener<CreateOrderBloc, CreateOrderState>(
                      //   listener: (context, state) {
                      if (state.detailStatus == CreateDetailStatus.loading) {
                        return CircularProgressIndicator();
                      } else if (state.detailStatus ==
                          CreateDetailStatus.success) {
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
                                        'Th??ng tin kh??ch h??ng',
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Text(
                                              'H??? t??n:',
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: Text(
                                              'S??? ??i???n tho???i:',
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Text(
                                              '?????a ch???:',
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
                                                CustomerCarWithIdStatus
                                                    .loading) {
                                              return CircularProgressIndicator();
                                            } else if (state.withIdstatus ==
                                                CustomerCarWithIdStatus
                                                    .loadedCarSuccess) {
                                              if (state.vehicleLists != null &&
                                                  state.vehicleLists.isNotEmpty)
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.black26),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'Th??ng tin xe',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      GridView.builder(
                                                        itemCount: state
                                                            .vehicleLists
                                                            .length,
                                                        shrinkWrap: true,
                                                        // ignore: missing_return
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          childAspectRatio:
                                                              1.6, // T??? l??? chi???u-ngang/chi???u-r???ng c???a m???t item trong grid, ??? ????y width = 1.6 * height
                                                          crossAxisCount:
                                                              2, // S??? item tr??n m???t h??ng ngang
                                                          crossAxisSpacing:
                                                              5, // Kho???ng c??ch gi???a c??c item trong h??ng ngang
                                                          mainAxisSpacing: 0,
                                                          // Kho???ng c??ch gi???a c??c h??ng (gi???a c??c item trong c???t d???c)
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
                                                                      .colors
                                                                      .blue
                                                                  : Colors
                                                                      .white,
                                                              child: ListTile(
                                                                leading:
                                                                    CircleAvatar(
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
                                                                      color: (_carId == state.vehicleLists[index].id)
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
                                                                      color: (_carId == state.vehicleLists[index].id)
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
                                                                    print(
                                                                        _carId);
                                                                    // _visible = !_visible;
                                                                  });
                                                                },
                                                              ),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 0,
                                                                      left: 2,
                                                                      right: 2,
                                                                      bottom:
                                                                          40),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              else //n???u kh??ng c?? xe n??o
                                                return Text(
                                                    'Kh??ng c?? th??ng tin xe');
                                            } else if (state.withIdstatus ==
                                                CustomerCarWithIdStatus.error) {
                                              return Text('Kh??ng t??m th???y xe');
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 20),
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
                                        'Ch???n d???ch v???',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      //D???CH V??? B???O D?????NG
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            RadioListTile(
                                              value: 1,
                                              groupValue: _valueSelected,
                                              title: Text('B???o D?????ng'),
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
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(18.0),
                                                      child: Container(
                                                        // child: SingleChildScrollView(
                                                        child: BlocBuilder<
                                                            PackageServiceBloc,
                                                            PackageServiceState>(
                                                          // ignore: missing_return
                                                          builder: (context,
                                                              stateOfPackage) {
                                                            if (stateOfPackage
                                                                    .status ==
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
                                                                return Column(
                                                                  children: stateOfPackage
                                                                      .packageServiceLists
                                                                      .map<Widget>(
                                                                          (packageService) {
                                                                    return ExpansionTile(
                                                                      title: Text(
                                                                          packageService
                                                                              .name),
                                                                      leading:
                                                                          Checkbox(
                                                                        value: _packageIdList.indexWhere((packageId) =>
                                                                                packageId ==
                                                                                packageService.id) >=
                                                                            0,
                                                                        onChanged:
                                                                            (selected) {
                                                                          if (selected) {
                                                                            setState(() {
                                                                              _packageIdList.add(packageService.id);
                                                                            });
                                                                          } else {
                                                                            setState(() {
                                                                              _packageIdList.remove(packageService.id);
                                                                            });
                                                                          }
                                                                        },
                                                                      ),
                                                                      children: packageService
                                                                          .services
                                                                          .map(
                                                                              (service) {
                                                                        return ListTile(
                                                                          title:
                                                                              Text(service.name),
                                                                        );
                                                                      }).toList(),
                                                                    );
                                                                  }).toList(),
                                                                );
                                                              else //n???u kh??ng c?? xe n??o
                                                                return Text(
                                                                    'Kh??ng c?? th??ng c??c g??i d???ch v???');
                                                            } else if (stateOfPackage
                                                                    .status ==
                                                                PackageServiceStatus
                                                                    .error) {
                                                              return ErrorWidget(
                                                                  stateOfPackage
                                                                      .message
                                                                      .toString());
                                                            }
                                                          },
                                                        ),
                                                        // ),
                                                      ),
                                                    )
                                                  ],
                                                )),

                                            // D???CH V??? S???A CH???A
                                            RadioListTile(
                                              value: 2,
                                              groupValue: _valueSelected,
                                              title: Text('S???a ch???a'),
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
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: TextField(
                                                        onChanged: (noteValue) {
                                                          setState(() {
                                                            _packageId = null;
                                                            _note = noteValue;
                                                          });
                                                        },
                                                        maxLines: 3,
                                                        decoration: InputDecoration
                                                            .collapsed(
                                                                hintText:
                                                                    'T??nh tr???ng xe'),
                                                      ),
                                                    ),
                                                    // Container(
                                                    //   child: GestureDetector(
                                                    //     child: Container(
                                                    //       color: Colors.white24,
                                                    //       height: 100,
                                                    //       width: 100,
                                                    //       child: _image != null
                                                    //           ? Image.file(
                                                    //               _image,
                                                    //               fit: BoxFit
                                                    //                   .fill,
                                                    //             )
                                                    //           : Icon(Icons
                                                    //               .add_a_photo),
                                                    //       alignment:
                                                    //           Alignment.center,
                                                    //     ),
                                                    //     onTap: () {
                                                    //       _showPicker(context);
                                                    //     },
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              BlocListener<CreateOrderBloc, CreateOrderState>(
                                listener: (context, state) {
                                  if (state.status ==
                                      CreateOrderStatus.createOrderSuccess) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return AlertDialog(
                                            title: Text(
                                              'Th??ng b??o!',
                                              style: TextStyle(
                                                  color: Colors.greenAccent),
                                            ),
                                            content: Text(state.message),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    if (state.message ==
                                                        '?????t l???ch h???n th??nh c??ng') {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.pop(context);
                                                      context
                                                          .read<
                                                              AssignOrderBloc>()
                                                          .add(
                                                              DoListAssignOrderEvent());
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                    // Close the dialog
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //       builder: (context) => CustomerHome()),
                                                    // );
                                                  },
                                                  child: Text('?????ng ??'))
                                            ],
                                          );
                                        });
                                  }
                                },
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppTheme.colors.blue, // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  onPressed: () {
                                    imgUrl = _convertImagetoString(_image);
                                    print(imgUrl);
                                    if (_carId == null) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            return AlertDialog(
                                              title: Text(
                                                'Th??ng b??o!',
                                                style: TextStyle(
                                                    color: Colors.redAccent),
                                              ),
                                              content:
                                                  Text('Vui l??ng ch???n xe!'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      // Close the dialog
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('?????ng ??'))
                                              ],
                                            );
                                          });
                                    } else if (_note == null) {
                                      _createBookingBloc.add(
                                        CreateOrderButtonPressed(
                                            cusId: _carId,
                                            packageList: _packageIdList,
                                            note: null,
                                            timeBooking:
                                                _focusedDay.toIso8601String(),
                                            imageUrl: null),
                                      );
                                    } else if (_packageId == null) {

                                      _createBookingBloc.add(
                                          CreateOrderButtonPressed(
                                              cusId: _carId,
                                              packageList: null,
                                              note: _note,
                                              timeBooking:
                                                  _focusedDay.toIso8601String(),
                                              imageUrl: null));
                                    }
                                  },
                                  child: Text('X??c nh???n'),
                                ),
                              )
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
                  )
                : Center(
                    child: Text('Kh??ng th???y th??ng tin'),
                  )
          ],
        ),
      ),
    );
  }
}
