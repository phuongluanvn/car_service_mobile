import 'dart:io';

import 'package:car_service/blocs/customer/customerCar/CreateCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CreateCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CreateCar_state.dart';
import 'package:car_service/blocs/customer/manufacturers/Manufacturer_bloc.dart';
import 'package:car_service/blocs/customer/manufacturers/Manufacturer_event.dart';
import 'package:car_service/blocs/customer/manufacturers/Manufacturer_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/utils/model/ManufacturerModel.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class CreateCustomerCarUI extends StatefulWidget {
  @override
  _CreateCustomerCarUIState createState() => _CreateCustomerCarUIState();
}

class _CreateCustomerCarUIState extends State<CreateCustomerCarUI> {
  TextEditingController licensePlateNumber = TextEditingController();
  // File _pickerImage;
  CreateCarBloc createCarBloc;
  String _selectManufacturerItem;
  String _selectModelOfManufacturerItem;
  bool _visible = false;
  File _image;
  String _uploadedFileURL;
  String _username;

  @override
  void initState() {
    _getStringFromSharedPref();
    createCarBloc = BlocProvider.of<CreateCarBloc>(context);
    BlocProvider.of<ManufacturerBloc>(context).add(DoManufacturerListEvent());
  }

  _getStringFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('Username');

    setState(() {
      _username = username;
    });
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

  void _showSuccessDialog() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              'Thông báo!',
              style: TextStyle(color: Colors.redAccent),
            ),
            content: Text('Thêm mới xe không thành công!'),
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
  }

//option
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

    final licensePlateNumberText = TextField(
      controller: licensePlateNumber,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.departure_board_sharp),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black),
        hintText: 'Biển số xe',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Future uploadImageToFirebase(BuildContext context) async {
      String fileName = path.basename(_image.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
          storage.ref().child('mobile_customer/cars/add_new_car/$fileName');
      UploadTask uploadTask = ref.putFile(_image);
      uploadTask.then((res) {
        res.ref.getDownloadURL();
        print('Done: $res');
      });
    }

    final createCarButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          print(_image.path);
          print(_image);
          uploadImageToFirebase(context);
          // _showSuccessDialog();
          createCarBloc.add(CreateCarButtonPressed(
            username: _username,
            manufacturer: _selectManufacturerItem,
            model: _selectModelOfManufacturerItem,
            licensePlateNumber: licensePlateNumber.text,
          ));
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text(
          'Thêm xe',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
          title: Text('Thêm mới xe'),
          backgroundColor: AppTheme.colors.deepBlue),
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: BlocListener<CreateCarBloc, CreateCarState>(
            listener: (context, state) {
              if (state.status == CreateCarStatus.createCarSuccess) {
                Navigator.pushNamed(context, '/customer');
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    // color: AppTheme.colors.white,
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24, right: 24),
                  children: <Widget>[
                    // manufacturerText,
                    Center(
                      child: BlocBuilder<ManufacturerBloc, ManufacturerState>(
                        // ignore: missing_return
                        builder: (builder, manufacturerState) {
                          if (manufacturerState.status ==
                              ManufacturerStatus.init) {
                            return Container(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 5),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton<String>(
                                          iconSize: 30,
                                          icon: (null),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                          hint: Text('Chọn hãng xe'),
                                          items: [],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (manufacturerState.status ==
                              ManufacturerStatus.loading) {
                            return Container(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 5),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton<String>(
                                          iconSize: 30,
                                          icon: (null),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                          hint: Text('Chọn hãng xe'),
                                          items: [],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (manufacturerState.status ==
                              ManufacturerStatus.loadedManufacturerSuccess) {
                            return Container(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 5),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton<String>(
                                          iconSize: 30,
                                          icon: (null),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                          hint: Text('Chọn hãng xe'),
                                          items: manufacturerState
                                              .manufacturerLists
                                              .map((valueManu) {
                                            return DropdownMenuItem<String>(
                                              child: Text(valueManu.name),
                                              value: valueManu.name,
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              //thông tin hãng xe
                                              this._selectManufacturerItem =
                                                  newValue;
                                              _visible = !_visible;
                                              BlocProvider.of<ManufacturerBloc>(
                                                      context)
                                                  .add(DoModelListOfManufacturerEvent(
                                                      manuName:
                                                          _selectManufacturerItem));
                                            });
                                          },
                                          value: _selectManufacturerItem,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Visibility(
                        // visible: _visible,
                        child: Container(child:
                            BlocBuilder<ManufacturerBloc, ManufacturerState>(
                                // ignore: missing_return
                                builder: (builder, modelState) {
                          if (modelState.modelStatus ==
                              ModelOfManufacturerStatus.init) {
                            return Container(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 5),
                              color: Colors.white,
                              child: Row(children: <Widget>[
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton<String>(
                                        iconSize: 30,
                                        icon: (null),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        hint: Text('Chọn mẫu xe'),
                                        items: [],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            );
                          } else if (modelState.modelStatus ==
                              ModelOfManufacturerStatus.loading) {
                            return Container(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 5),
                              color: Colors.white,
                              child: Row(children: <Widget>[
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton<String>(
                                        iconSize: 30,
                                        icon: (null),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        hint: Text('Chọn mẫu xe'),
                                        items: [],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            );
                          } else if (modelState.modelStatus ==
                              ModelOfManufacturerStatus
                                  .loadedModelOfManufacturerSuccess) {
                            return Container(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 5),
                              color: Colors.white,
                              child: Row(children: <Widget>[
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton<String>(
                                        iconSize: 30,
                                        icon: (null),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        hint: Text('Chọn mẫu xe'),
                                        items: modelState.modelOfManu
                                            .map((valueItem) {
                                          return DropdownMenuItem<String>(
                                            child: Text(valueItem),
                                            value: valueItem,
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            //thông tin mẫu xe
                                            this._selectModelOfManufacturerItem =
                                                newValue;
                                          });
                                        },
                                        value: _selectModelOfManufacturerItem,
                                      ),
                                    ),
<<<<<<< HEAD
                                    hint: modelState.modelOfManu != [] ? Text('Chọn mẫu xe') : Text('Không có mẫu xe cho hãng này'),
                                    items:
                                        modelState.modelOfManu.map((valueItem) {
                                      return DropdownMenuItem<String>(
                                        child: Text(valueItem),
                                        value: valueItem,
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        //thông tin mẫu xe
                                        this._selectModelOfManufacturerItem =
                                            newValue;
                                      });
                                    },
                                    value: _selectModelOfManufacturerItem,
=======
>>>>>>> 6ed7daeea2283dda8f0b526e2ee5121571eb5230
                                  ),
                                ),
                              ]),
                            );
                          }
                        }))),
                    SizedBox(
                      height: 20,
                    ),
                    licensePlateNumberText,
                    SizedBox(
                      height: 20,
                    ),
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
                    createCarButton,
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
