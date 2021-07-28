import 'dart:io';

import 'package:car_service/blocs/customer/customerCar/CreateCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CreateCar_state.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/customer/customerOrder/CreateBooking_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CreateBooking_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CreateBooking_state.dart';
import 'package:car_service/blocs/customer/customerService/CustomerService_bloc.dart';
import 'package:car_service/blocs/customer/customerService/CustomerService_event.dart';
import 'package:car_service/blocs/packageService/PackageService_bloc.dart';
import 'package:car_service/blocs/packageService/PackageService_event.dart';
import 'package:car_service/blocs/packageService/PackageService_state.dart';
import 'package:car_service/ui/Customer/OrderManagement/CustomerOrderUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateBookingOrderUI extends StatefulWidget {
  @override
  _CreateBookingOrderUIState createState() => _CreateBookingOrderUIState();
}

class _CreateBookingOrderUIState extends State<CreateBookingOrderUI> {
  String _carId;
  String _packageId;
  String _note;
  bool _visibleBaoDuong = false;
  bool _visibleSuaChua = false;
  String _selectItem;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  int _valueSelected = 0;
  String _valueSelectedPackageService;
  bool _valueCheckbox = false;
  CreateBookingBloc _createBookingBloc;
  int _selectedTimeButton = 0;
  File _image;

  Map<String, bool> checkboxListValues = {};

  Widget showTimeButton(String text, int index) {
    return OutlineButton(
      onPressed: () {
        setState(() {
          _selectedTimeButton = index;
          // print(_selectedDay.day.toString() + text);
        });
      },
      child: Text(
        text,
        style: TextStyle(
            color: (_selectedTimeButton == index)
                ? Colors.blueAccent
                : Colors.blueGrey),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      borderSide: BorderSide(
          color: (_selectedTimeButton == index)
              ? Colors.blueAccent
              : Colors.blueGrey),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PackageServiceBloc>(context)
        .add(DoPackageServiceListEvent());
    _createBookingBloc = BlocProvider.of<CreateBookingBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _imageFromCamera() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  _imageFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    print(image.path);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _showPicker(context) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('Đặt lịch dịch vụ'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "Chọn xe",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start,
              ),
              Container(
                child: BlocBuilder<CustomerCarBloc, CustomerCarState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state.status == CustomerCarStatus.init) {
                      return CircularProgressIndicator();
                    } else if (state.status == CustomerCarStatus.loading) {
                      return CircularProgressIndicator();
                    } else if (state.status ==
                        CustomerCarStatus.loadedCarSuccess) {
                      if (state.vehicleLists != null &&
                          state.vehicleLists.isNotEmpty)
                        return GridView.builder(
                          itemCount: state.vehicleLists.length,
                          shrinkWrap: true,
                          // ignore: missing_return
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:
                                1.6, // Tỉ lệ chiều-ngang/chiều-rộng của một item trong grid, ở đây width = 1.6 * height
                            crossAxisCount: 2, // Số item trên một hàng ngang
                            crossAxisSpacing:
                                0, // Khoảng cách giữa các item trong hàng ngang
                            mainAxisSpacing: 0,
                            // Khoảng cách giữa các hàng (giữa các item trong cột dọc)
                          ),
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('lib/images/logo_blue.png'),
                                  backgroundColor: Colors.white24,
                                ),
                                title: Text(
                                  state.vehicleLists[index].licensePlate,
                                  style: TextStyle(
                                      color: (_carId ==
                                              state.vehicleLists[index].id)
                                          ? Colors.blue
                                          : Colors.grey),
                                ),
                                subtitle: Text(
                                    state.vehicleLists[index].manufacturer +
                                        " - " +
                                        state.vehicleLists[index].model),
                                onTap: () {
                                  setState(() {
                                    _carId = state.vehicleLists[index].id;
                                    // _visible = !_visible;
                                  });
                                },
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              margin: EdgeInsets.only(
                                  top: 12, left: 12, right: 12, bottom: 45),
                            );
                          },
                        );
                      else //nếu không có xe nào
                        return Text('Không có thông tin xe');
                    } else if (state.status == CustomerCarStatus.error) {
                      return ErrorWidget(state.message.toString());
                    }
                  },
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Container(
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
                                              stateOfPackage.packageServiceLists
                                                  .isNotEmpty)
                                            return ExpansionPanelList.radio(
                                              children: stateOfPackage
                                                  .packageServiceLists
                                                  .map<ExpansionPanelRadio>(
                                                (e) {
                                                  return ExpansionPanelRadio(
                                                      value: e.id,
                                                      headerBuilder: (context,
                                                          isExpanded) {
                                                        return ListTile(
                                                          title: Text(
                                                            e.name,
                                                            style: TextStyle(
                                                                color: (_valueSelectedPackageService ==
                                                                        e.id)
                                                                    ? Colors
                                                                        .blue
                                                                    : Colors
                                                                        .grey),
                                                          ),
                                                          trailing: Text(
                                                            e.price.toString(),
                                                            style: TextStyle(
                                                                color: (_valueSelectedPackageService ==
                                                                        e.id)
                                                                    ? Colors
                                                                        .blue
                                                                    : Colors
                                                                        .grey),
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              _valueSelectedPackageService =
                                                                  e.id;
                                                              _packageId = e.id;
                                                              _note = null;
                                                            });
                                                          },
                                                        );
                                                      },
                                                      body:
                                                          SingleChildScrollView(
                                                        child: ListView(
                                                          shrinkWrap: true,
                                                          children: e.services
                                                              .map((service) {
                                                            return ListTile(
                                                              title: Text(
                                                                  service.name),
                                                              trailing: Text(
                                                                service.price
                                                                    .toString(),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ));
                                                  // );
                                                },
                                              ).toList(),
                                            );
                                          else //nếu không có xe nào
                                            return Text(
                                                'Không có thông các gói dịch vụ');
                                        } else if (stateOfPackage.status ==
                                            PackageServiceStatus.error) {
                                          return ErrorWidget(stateOfPackage
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
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextField(
                                    onChanged: (noteValue) {
                                      setState(() {
                                        _packageId = null;
                                        _note = noteValue;
                                      });
                                    },
                                    maxLines: 3,
                                    decoration: InputDecoration.collapsed(
                                        hintText: 'Tình trạng xe'),
                                  ),
                                ),
                                SizedBox(height: 12,),
                                Center(
                                  child: GestureDetector(
                                    child: Container(
                                      color: Colors.white24,
                                      height: 150,
                                      width: 300,
                                      child: _image != null
                                          ? Image.file(
                                              _image,
                                              fit: BoxFit.fill,
                                            )
                                          : Icon(Icons.add_a_photo),
                                      alignment: Alignment.center,
                                    ),
                                    onTap: () {
                                      _showPicker(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.black87,
                    height: 20,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Text(
                    'Chọn thời gian',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    child: TableCalendar(
                      firstDay: DateTime.utc(2020),
                      lastDay: DateTime.utc(2030),
                      currentDay: DateTime.now(),
                      calendarFormat: _calendarFormat,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          _calendarFormat = _format;
                        });
                      },
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      daysOfWeekVisible: true,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay))
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                            print(_selectedDay.toIso8601String());
                          });
                      },
                    ),
                  ),
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showTimeButton('7:00', 1),
                  showTimeButton('7:30', 2),
                  showTimeButton('8:00', 3),
                  showTimeButton('8:30', 4),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showTimeButton('9:00', 5),
                  showTimeButton('9:30', 6),
                  showTimeButton('10:00', 7),
                  showTimeButton('10:30', 8),
                ],
              ),
              Divider(),
              BlocListener<CreateBookingBloc, CreateBookingState>(
                listener: (context, state) {
                  if (state.status ==
                      CreateBookingStatus.createBookingOrderSuccess) {
                    // Navigator.pop(context);
                    Navigator.pop(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => TabOrderCustomer()),
                    );
                  }
                },
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
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
                        timeBooking: _selectedDay.toIso8601String(),
                      ));
                    } else if (_packageId == null) {
                      _createBookingBloc.add(CreateBookingButtonPressed(
                        carId: _carId,
                        serviceId: null,
                        note: _note,
                        timeBooking: _selectedDay.toIso8601String(),
                      ));
                    }
                  },
                  child: Text('Xác nhận'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
