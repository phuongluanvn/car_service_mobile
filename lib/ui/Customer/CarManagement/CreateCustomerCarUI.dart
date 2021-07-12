import 'dart:io';

import 'package:car_service/blocs/customer/customerCar/CreateCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CreateCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CreateCar_state.dart';
import 'package:car_service/blocs/customer/manufacturers/Manufacturer_bloc.dart';
import 'package:car_service/blocs/customer/manufacturers/Manufacturer_event.dart';
import 'package:car_service/blocs/customer/manufacturers/Manufacturer_state.dart';
import 'package:car_service/utils/model/ManufacturerModel.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      ),
      backgroundColor: Colors.blue[100],
      body: BlocListener<CreateCarBloc, CreateCarState>(
          listener: (context, state) {
            if (state.status == CreateCarStatus.createCarSuccess) {
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
                // manufacturerText,
                Center(
                  child: BlocBuilder<ManufacturerBloc, ManufacturerState>(
                    // ignore: missing_return
                    builder: (builder, manufacturerState) {
                      if (manufacturerState.status == ManufacturerStatus.init) {
                        return Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      items: manufacturerState.manufacturerLists
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
                Center(
                    // visible: _visible,
                    child: Container(
                        child: BlocBuilder<ManufacturerBloc, ManufacturerState>(
                            // ignore: missing_return
                            builder: (builder, modelState) {
                  if (modelState.modelStatus ==
                      ModelOfManufacturerStatus.init) {
                    return Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
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
                              ),
                            ),
                          ),
                        ),
                      ]),
                    );
                  } else if (modelState.modelStatus ==
                      ModelOfManufacturerStatus.loading) {
                    return Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
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
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
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
                                items: modelState.modelOfManu.map((valueItem) {
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
                          ),
                        ),
                      ]),
                    );
                  }
                }))),

                // modelText,
                SizedBox(
                  height: 20,
                ),
                licensePlateNumberText,
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 26),
                  width: 300,
                  height: 150,
                  color: Colors.white24,
                  child: _image != null
                      ? Image.file(
                          _image,
                          fit: BoxFit.fill,
                        )
                      : Icon(Icons.camera_alt),
                ),
                Center(
                  child: GestureDetector(
                    child: Container(
                      color: Colors.teal,
                      height: 30,
                      width: 100,
                      child: Text('Select image'),
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
          )),
    );
  }
}
