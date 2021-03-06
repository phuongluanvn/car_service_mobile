import 'dart:io';

import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/customer/customerOrder/CreateBooking_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CreateBooking_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CreateBooking_state.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/packageService/PackageService_bloc.dart';
import 'package:car_service/blocs/packageService/PackageService_event.dart';
import 'package:car_service/blocs/packageService/PackageService_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/ExpansionList.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';
import 'package:intl/date_symbol_data_local.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;

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
  int _currenDay = DateTime.now().day.toInt();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  int _valueSelected = 0;
  String _valueSelectedPackageService;
  bool _valueCheckbox = false;
  CreateBookingBloc _createBookingBloc;
  String _selectedTimeButton;
  File _image;
  List<Asset> images = List<Asset>();
  String _error = 'Selectionner une image';
  String _timeSelected;
  Color _colorBgrBtn;
  bool _isTimeBooking = false;
  List _packageIdList = [];
  bool _isOpen = false;
  bool _isSelectedStaff = false;
  Map<String, bool> checkboxListValues = {};
  String imageUrl;
  File _imageFile;

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    var file = File(_image.path);

    if (_image != null) {
      //Upload to Firebase
      var snapshot = await _firebaseStorage
          .ref()
          .child('mobile_customer/${file.path}')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
        print(downloadUrl);
      });
    } else {
      print('No Image Path Received');
    }
  }

//multi select - nhuwng ddang bug
  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

//multi select - nhuwng ddang bug
  Future<void> loadAssets() async {
    print('??????');
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 2,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    // if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput), [yyyy, '-', mm, '-', dd]);
  }

  Widget showTimeButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedTimeButton = text;
          _colorBgrBtn = AppTheme.colors.lightblue;
          // print(_selectedDay.day.toString() + text);
        });
      },
      child: Text(
        text,
        style: TextStyle(
            color: (_selectedTimeButton == text)
                ? AppTheme.colors.white
                : AppTheme.colors.blue),
      ),
      style: ElevatedButton.styleFrom(
        primary: (_selectedTimeButton == text)
            ? AppTheme.colors.blue
            : AppTheme.colors.white,
        onPrimary: Colors.white,
        // fixedSize: Size(80, 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(
            width: 2,
            color: (_selectedTimeButton == text)
                ? AppTheme.colors.deepBlue
                : Colors.blueGrey),
      ),
    );
  }

  Widget showTimeButtonIsBooking(String text, int index) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(color: Colors.white24),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey,
        // fixedSize: Size(80, 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(width: 2, color: Colors.grey),
      ),
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

//Select pic from gallery
  _imageFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = File(image.path);
        print(_image);
      });
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

  _convertMoney(double money) {
    MoneyFormatter fmf = new MoneyFormatter(
        amount: money,
        settings: MoneyFormatterSettings(
          symbol: 'VND',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 0,
          // compactFormatType: CompactFormatType.sort
        ));
    print(fmf.output.symbolOnRight);
    return fmf.output.symbolOnRight.toString();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi_VN', null);
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('?????t l???ch d???ch v???'),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Container(
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        "Ch???n xe",
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
                            } else if (state.status ==
                                CustomerCarStatus.loading) {
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
                                        1.6, // T??? l??? chi???u-ngang/chi???u-r???ng c???a m???t item trong grid, ??? ????y width = 1.6 * height
                                    crossAxisCount:
                                        2, // S??? item tr??n m???t h??ng ngang
                                    crossAxisSpacing:
                                        5, // Kho???ng c??ch gi???a c??c item trong h??ng ngang
                                    mainAxisSpacing: 0,
                                    // Kho???ng c??ch gi???a c??c h??ng (gi???a c??c item trong c???t d???c)
                                  ),
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: (_carId ==
                                              state.vehicleLists[index].id)
                                          ? AppTheme.colors.blue
                                          : Colors.white,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'lib/images/logo_blue.png'),
                                          backgroundColor: Colors.white24,
                                        ),
                                        title: Text(
                                          state
                                              .vehicleLists[index].licensePlate,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: (_carId ==
                                                      state.vehicleLists[index]
                                                          .id)
                                                  ? AppTheme.colors.white
                                                  : AppTheme.colors.deepBlue),
                                        ),
                                        subtitle: Text(
                                            state.vehicleLists[index]
                                                    .manufacturer +
                                                " - " +
                                                state.vehicleLists[index].model,
                                            style: TextStyle(
                                                color: (_carId ==
                                                        state
                                                            .vehicleLists[index]
                                                            .id)
                                                    ? AppTheme.colors.white
                                                    : AppTheme
                                                        .colors.deepBlue)),
                                        onTap: () {
                                          if (_carId ==
                                              state.vehicleLists[index].id) {
                                            setState(() {
                                              print(null);
                                            });
                                          }
                                          setState(() {
                                            _carId =
                                                state.vehicleLists[index].id;
                                            // _visible = !_visible;
                                            _isSelectedStaff =
                                                !_isSelectedStaff;
                                          });
                                        },
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      margin: EdgeInsets.only(
                                          top: 0,
                                          left: 2,
                                          right: 2,
                                          bottom: 40),
                                    );
                                  },
                                );
                              else //n???u kh??ng c?? xe n??o
                                return Text('Kh??ng c?? th??ng tin xe');
                            } else if (state.status ==
                                CustomerCarStatus.error) {
                              return ErrorWidget(state.message.toString());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // CH???N D???CH V??? CHO ?????T L???CH
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Container(
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        'Ch???n d???ch v???',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
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
                                      padding: EdgeInsets.all(18.0),
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
                                                          packageService.name),
                                                      leading: Checkbox(
                                                        value: _packageIdList.indexWhere(
                                                                (packageId) =>
                                                                    packageId ==
                                                                    packageService
                                                                        .id) >=
                                                            0,
                                                        onChanged: (selected) {
                                                          if (selected) {
                                                            setState(() {
                                                              _packageIdList.add(
                                                                  packageService
                                                                      .id);
                                                            });
                                                          } else {
                                                            setState(() {
                                                              _packageIdList.remove(
                                                                  packageService
                                                                      .id);
                                                            });
                                                          }
                                                        },
                                                      ),
                                                      children: packageService
                                                          .services
                                                          .map((service) {
                                                        return ListTile(
                                                          title: Text(
                                                              service.name),
                                                        );
                                                      }).toList(),
                                                    );
                                                  }).toList(),
                                                );
                                              else //n???u kh??ng c?? xe n??o
                                                return Text(
                                                    'Kh??ng c?? th??ng c??c g??i d???ch v???');
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
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextField(
                                        onChanged: (noteValue) {
                                          setState(() {
                                            _packageId = null;
                                            _note = noteValue;
                                          });
                                        },
                                        maxLines: 3,
                                        decoration: InputDecoration.collapsed(
                                            hintText: 'T??nh tr???ng xe'),
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
                                    //               fit: BoxFit.fill,
                                    //             )
                                    //           : Icon(Icons.add_a_photo),
                                    //       alignment: Alignment.center,
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Container(
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        'Ch???n th???i gian',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        child: TableCalendar(
                          locale: 'vi_VN',
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
                                if ((_focusedDay.day.toInt() - _currenDay) >
                                        0 &&
                                    (_selectedDay.day.toInt() - _currenDay) <=
                                        7) {
                                  setState(() {
                                    _isTimeBooking = true;
                                  });
                                } else {
                                  setState(() {
                                    _isTimeBooking = false;
                                  });
                                }
                                print(_selectedDay.toIso8601String());
                              });
                          },
                        ),
                      ),
                      _isTimeBooking
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                showTimeButton('08:00', 1),
                                showTimeButton('08:30', 2),
                                showTimeButton('09:00', 3),
                                showTimeButton('09:30', 4),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                showTimeButtonIsBooking('08:00', 1),
                                showTimeButtonIsBooking('08:30', 2),
                                showTimeButtonIsBooking('09:00', 3),
                                showTimeButtonIsBooking('09:30', 4),
                              ],
                            ),
                      _isTimeBooking
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                showTimeButton('10:00', 5),
                                showTimeButton('10:30', 6),
                                showTimeButton('11:00', 7),
                                showTimeButton('11:30', 8),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                showTimeButtonIsBooking('10:00', 5),
                                showTimeButtonIsBooking('10:30', 6),
                                showTimeButtonIsBooking('11:00', 7),
                                showTimeButtonIsBooking('11:30', 8),
                              ],
                            ),
                      _isTimeBooking
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                showTimeButton('12:00', 9),
                                showTimeButton('13:00', 10),
                                showTimeButton('13:30', 11),
                                showTimeButton('14:00', 12),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                showTimeButtonIsBooking('12:00', 9),
                                showTimeButtonIsBooking('13:00', 10),
                                showTimeButtonIsBooking('13:30', 11),
                                showTimeButtonIsBooking('14:00', 12),
                              ],
                            ),
                      _isTimeBooking
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                showTimeButton('14:30', 13),
                                showTimeButton('15:00', 14),
                                showTimeButton('15:30', 15),
                                showTimeButton('16:00', 16),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                showTimeButtonIsBooking('14:30', 13),
                                showTimeButtonIsBooking('15:00', 14),
                                showTimeButtonIsBooking('15:30', 15),
                                showTimeButtonIsBooking('16:00', 16),
                              ],
                            ),
                    ],
                  ),
                ),
              ),

              // Divider(),
              BlocListener<CreateBookingBloc, CreateBookingState>(
                listener: (context, state) {
                  if (state.status ==
                      CreateBookingStatus.createBookingOrderSuccess) {
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: Text(
                              'Th??ng b??o!',
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                            content: Text(state.message),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    if (state.message ==
                                        '?????t l???ch h???n th??nh c??ng') {
                                      Navigator.of(context).pop();
                                      Navigator.pop(context);
                                      context
                                          .read<CustomerOrderBloc>()
                                          .add(DoOrderListEvent());
                                    } else {
                                      Navigator.of(context).pop();
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
                  onPressed: () async {
                    // String url = await uploadImage();
                    _timeSelected =
                        _convertDate(_selectedDay.toString()).toString() +
                            'T' +
                            _selectedTimeButton;
                    if (_carId == null) {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                              title: Text(
                                'Th??ng b??o!',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              content: Text('Vui l??ng ch???n xe!'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      // Close the dialog
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('?????ng ??'))
                              ],
                            );
                          });
                    } else if (_note == null) {
                      _createBookingBloc.add(
                        CreateBookingButtonPressed(
                            carId: _carId,
                            packageLists: _packageIdList,
                            note: null,
                            timeBooking: _timeSelected,
                            imageUrl: null),
                      );
                    } else if (_packageId == null) {
                      _createBookingBloc.add(CreateBookingButtonPressed(
                          carId: _carId,
                          packageLists: null,
                          note: _note,
                          timeBooking: _timeSelected,
                          imageUrl: imageUrl));
                    }
                  },
                  child: Text('X??c nh???n'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showMessage(String mes) {
    String mesShow;
    if (mes == "Xe ??ang c?? l???ch") {
      mesShow = mes;
    } else if (mes == '"Khung gi??? ???? ???????c ?????t"') {
      mesShow = mes;
    } else {
      mesShow = '?????t l???ch th??nh c??ng';
    }

    return mesShow;
  }
}
