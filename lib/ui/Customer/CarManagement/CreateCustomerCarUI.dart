import 'dart:io';

import 'package:car_service/blocs/customer/customerCar/CreateCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CreateCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CreateCar_state.dart';
import 'package:car_service/utils/model/ManufacturerModel.dart';
import 'package:car_service/utils/repository/customer_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateCustomerCarUI extends StatefulWidget {
  @override
  _CreateCustomerCarUIState createState() => _CreateCustomerCarUIState();
}

class _CreateCustomerCarUIState extends State<CreateCustomerCarUI> {
  TextEditingController manufacturer = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController licensePlateNumber = TextEditingController();
  File _pickerImage;
  CreateCarBloc createCarBloc;
  CustomerRepository _repo;
  List<ManufacturerModel> _listManufacturer;

  @override
  void initState() {
    createCarBloc = BlocProvider.of<CreateCarBloc>(context);
    print('List manu ');
    print(_listManufacturer);
    super.initState();
    _getListManufacturer();
  }

  File _image;

  _getListManufacturer() async {
    _listManufacturer = await _repo.getManufacturerList();
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
    print('object');

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

    final manufacturerText = TextField(
      controller: manufacturer,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.precision_manufacturing),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Hãng xe',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final modelText = TextField(
      controller: model,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.drive_eta),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
        hintText: 'Loại xe',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final licensePlateNumberText = TextField(
      controller: licensePlateNumber,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.departure_board_sharp),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.black54),
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
            username: 'chonwang',
            manufacturer: manufacturer.text,
            model: model.text,
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
              print('object');
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
                manufacturerText,
                SizedBox(
                  height: 20,
                ),
                modelText,
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
