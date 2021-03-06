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
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;

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
  // ignore: must_call_super
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
        prefixIcon: Icon(Icons.payment),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(fontWeight: FontWeight.w600),
        hintText: cusConstants.LICENSE_PLATE_LABLE,
        // contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final createCarButton = Padding(
      padding: EdgeInsets.only(left: 90, right: 90),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: AppTheme.colors.blue),
        onPressed: () {
          createCarBloc.add(CreateCarButtonPressed(
            username: _username,
            manufacturer: _selectManufacturerItem,
            model: _selectModelOfManufacturerItem,
            licensePlateNumber: licensePlateNumber.text,
          ));
        },
        child: Text(
          cusConstants.BUTTON_CREATE_TITLE,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
          title: Text(cusConstants.CREATE_CAR_TITLE_WIDGET),
          backgroundColor: AppTheme.colors.deepBlue),
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: BlocListener<CreateCarBloc, CreateCarState>(
            listener: (context, state) {
              if (state.status == CreateCarStatus.createCarSuccess) {
                _showSuccessCreateCarDialog();
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
                    Image.network(cusConstants.IMAGE_URL_CREATE_VEHICLE),
                    SizedBox(
                      height: 30,
                    ),
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
                                          hint: Text(
                                            cusConstants.SELECT_MANU_TITLE,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
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
                                          hint: Text(
                                              cusConstants.SELECT_MANU_TITLE,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
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
                                          hint: Text(
                                              cusConstants.SELECT_MANU_TITLE,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
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
                                              //th??ng tin h??ng xe

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
                      print(modelState);
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
                                    hint: Text(cusConstants.SELECT_MODEL_TITLE,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
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
                                    hint: Text(cusConstants.SELECT_MODEL_TITLE,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
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
                                    hint: modelState.modelOfManu != []
                                        ? Text(cusConstants.SELECT_MODEL_TITLE,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600))
                                        : Text(cusConstants.NOT_FOUND_MODEL,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600)),
                                    items:
                                        modelState.modelOfManu.map((valueItem) {
                                      return DropdownMenuItem<String>(
                                        child: Text(valueItem.name),
                                        value: valueItem.name,
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        //th??ng tin m???u xe
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
                      } else {
                        return Text('');
                      }
                    }))),
                    SizedBox(
                      height: 30,
                    ),
                    licensePlateNumberText,
                    SizedBox(
                      height: 30,
                    ),
                    createCarButton,
                  ],
                ),
              ),
            )),
      ),
    );
  }

  _showSuccessCreateCarDialog() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              cusConstants.NOTI_TITLE,
              style: TextStyle(color: Colors.greenAccent),
            ),
            content: Text(cusConstants.CREATE_CAR_SUCCESS),
            actions: [
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.pushNamed(
                        context, cusConstants.PATH_CUSTOMER_HOME);
                  },
                  child: Text(cusConstants.BUTTON_OK_TITLE))
            ],
          );
        });
  }
}
