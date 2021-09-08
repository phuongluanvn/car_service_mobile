import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/customer/customerCar/DelCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/DelCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/DelCar_state.dart';
import 'package:car_service/blocs/customer/customerCar/UpdateCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/UpdateCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/UpdateCar_state.dart';
import 'package:car_service/blocs/customer/manufacturers/Manufacturer_bloc.dart';
import 'package:car_service/blocs/customer/manufacturers/Manufacturer_event.dart';
import 'package:car_service/blocs/customer/manufacturers/Manufacturer_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:date_format/date_format.dart';
// import 'package:car_service/ui/Customer/CarManagement/EditInforOfCarUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;

class CustomerCarDetailUi extends StatefulWidget {
  final String id;
  final String manuName;
  final String modelName;

  CustomerCarDetailUi({@required this.id, this.manuName, this.modelName});

  @override
  _CustomerCarDetailUiState createState() => _CustomerCarDetailUiState();
}

class _CustomerCarDetailUiState extends State<CustomerCarDetailUi> {
  final TextEditingController _typeAheadController = TextEditingController();
  TextEditingController _modelName = TextEditingController();

  String _manufacturer, _licensePlate;
  UpdateCarBloc _updateCarButton;
  String manuName;
  bool _isChangeValueModelName = false;
  bool _isChangeLicensePlate = false;
  bool _isEditButton = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _modelName.text = widget.modelName;
    });
    _updateCarButton = BlocProvider.of<UpdateCarBloc>(context);
    BlocProvider.of<CustomerCarBloc>(context)
        .add(DoCarDetailEvent(vehicleId: widget.id));
    BlocProvider.of<ManufacturerBloc>(context)
        .add(DoModelListOfManufacturerEvent(manuName: widget.manuName));
  }

  Image image;

  _showSuccessUpdateDialog() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              cusConstants.NOTI_TITLE,
              style: TextStyle(color: Colors.greenAccent),
            ),
            content: Text(cusConstants.UPDATE_VEHICLE_SUCCESS),
            actions: [
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                    BlocProvider.of<ManufacturerBloc>(context).add(
                        DoModelListOfManufacturerEvent(
                            manuName: widget.manuName));
                  },
                  child: Text(cusConstants.BUTTON_OK_TITLE))
            ],
          );
        });
  }

  _showDeleteDialog() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              cusConstants.NOTI_TITLE,
              style: TextStyle(color: Colors.redAccent),
            ),
            content: Text(cusConstants.DELETE_VEHICLE_REQUEST),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(cusConstants.BUTTON_CANCEL_TITLE)),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    BlocProvider.of<DeleteCarBloc>(context)
                        .add(DoDeleteCarEvent(vehicleId: widget.id));
                  },
                  child: Text(cusConstants.BUTTON_OK_TITLE))
            ],
          );
        });
  }

  // _showDelSuccessDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return AlertDialog(
  //           title: Text(
  //             ,
  //             style: TextStyle(color: Colors.greenAccent),
  //           ),
  //           content: Text(),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   // Close the dialog
  //                   // Navigator.of(context).pop();
  //                   Navigator.pushNamed(context, );
  //                 },
  //                 child: Text())
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
      appBar: AppBar(
          title: Text(cusConstants.UPDATE_VEHICLE_TITLE_WIDGET),
          backgroundColor: AppTheme.colors.deepBlue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              context.read<CustomerCarBloc>().add(DoCarListEvent());
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _showDeleteDialog();
                },
                icon: Icon(Icons.delete_forever_rounded)),
          ]),
      body: Center(
        child: BlocListener<DeleteCarBloc, DeleteCarState>(
          listener: (context, state) {
            if (state.deleteStatus == CarDeleteStatus.deleteDetailSuccess) {
              return showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return AlertDialog(
                      title: Text(
                        cusConstants.NOTI_TITLE,
                        style: TextStyle(color: Colors.greenAccent),
                      ),
                      content: Text(cusConstants.DELETE_VEHICLE_SUCCESS),
                      actions: [
                        TextButton(
                            onPressed: () {
                              // Close the dialog
                              // Navigator.of(context).pop();
                              Navigator.pushNamed(
                                  context, cusConstants.PATH_CUSTOMER_HOME);
                            },
                            child: Text(cusConstants.BUTTON_OK_TITLE))
                      ],
                    );
                  });
            }
          },
          child: BlocListener<UpdateCarBloc, UpdateCarState>(
            listener: (context, state) {
              if (state.updateStatus == UpdateCarStatus.updateDetailSuccess) {
                return _showSuccessUpdateDialog();
              }
            },
            child: SingleChildScrollView(
              child: Center(
                child: BlocBuilder<CustomerCarBloc, CustomerCarState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state.detailStatus == CustomerCarDetailStatus.init) {
                      return CircularProgressIndicator();
                    } else if (state.detailStatus ==
                        CustomerCarDetailStatus.loading) {
                      return CircularProgressIndicator();
                    } else if (state.detailStatus ==
                        CustomerCarDetailStatus.success) {
                      if (state.vehicleDetail != null &&
                          state.vehicleDetail.isNotEmpty) {
                        switch (state.vehicleDetail[0].manufacturer) {
                          case 'Axa':
                            image = Image.network(
                                cusConstants.IMAGE_URL_UPDATE_VEHICLE_FIRST);
                            break;
                          default:
                            image = Image.network(
                                cusConstants.IMAGE_URL_UPDATE_VEHICLE_SECOND);
                        }
                        var manufacturer = TextFormField(
                          readOnly: true,
                          initialValue: state.vehicleDetail[0].manufacturer,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.black54),
                            // hintText: state.vehicleDetail[0].taiKhoan,
                            // text
                            labelText: cusConstants.MANU_LABLE,
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                        var modelOfManu = TextFormField(
                          initialValue: state.vehicleDetail[0].model,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.time_to_leave),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.black54),
                            // hintText: state.vehicleDetail[0].taiKhoan,
                            // text
                            labelText: cusConstants.MODEL_LABLE,
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                        var licenNumber = TextFormField(
                          onChanged: (newValue) {
                            _licensePlate = newValue;
                            setState(() {
                              _isChangeLicensePlate = true;
                            });
                          },
                          initialValue: state.vehicleDetail[0].licensePlate,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.payment),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.black54),
                            // hintText: state.vehicleDetail[0].taiKhoan,
                            // text
                            labelText: cusConstants.LICENSE_PLATE_LABLE,
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                        var repairTime = TextFormField(
                          readOnly: true,
                          initialValue: state
                                      .vehicleDetail[0].dateOfLastMaintenance !=
                                  null
                              ? _convertDate(
                                  state.vehicleDetail[0].dateOfLastMaintenance)
                              : '',
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.date_range),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.black54),
                            // hintText: state.vehicleDetail[0].taiKhoan,
                            // text
                            labelText:
                                cusConstants.UPDATE_LAST_OF_MAINTENANCE_LABLE,
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                        var kilometer = TextFormField(
                          readOnly: true,
                          initialValue:
                              state.vehicleDetail[0].millageCount.toString(),
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.av_timer),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.black54),
                            // hintText: state.vehicleDetail[0].taiKhoan,
                            // text
                            labelText: cusConstants.UPDATE_MILLAGE_COUNT_LABLE,
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                        var elevatedButton = ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppTheme.colors.blue),
                          child: Text(cusConstants.BUTTON_SAVE_UPDATE,
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            _updateCarButton.add(UpdateCarButtonPressed(
                              carId: widget.id,
                              manufacturer: widget.manuName,
                              model: this._modelName.text,
                              licensePlateNumber: _isChangeLicensePlate
                                  ? _licensePlate
                                  : state.vehicleDetail[0].licensePlate,
                            ));
                          },
                        );
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: <Widget>[
                                image,
                                Container(height: 18),
                                manufacturer,
                                Container(height: 14),
                                // _isEditButton
                                //     ?
                                BlocBuilder<ManufacturerBloc,
                                        ManufacturerState>(
                                    // ignore: missing_return
                                    builder: (context, manuState) {
                                  if (manuState.modelStatus ==
                                      ModelOfManufacturerStatus.init) {
                                    return CircularProgressIndicator();
                                  } else if (manuState.modelStatus ==
                                      ModelOfManufacturerStatus.loading) {
                                    return CircularProgressIndicator();
                                  } else if (manuState.modelStatus ==
                                      ModelOfManufacturerStatus
                                          .loadedModelOfManufacturerSuccess) {
                                    return Column(
                                      children: [
                                        TypeAheadField(
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                              decoration: InputDecoration(
                                                prefixIcon:
                                                    Icon(Icons.time_to_leave),
                                                filled: true,
                                                fillColor: Colors.white,
                                                hintStyle: TextStyle(
                                                    color: Colors.black54),
                                                labelText: cusConstants
                                                    .MODEL_LABLE,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        20, 10, 20, 10),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              controller:
                                                  _isChangeValueModelName
                                                      ? this
                                                          ._typeAheadController
                                                      : this._modelName,
                                            ),
                                            // ignore: missing_return
                                            suggestionsCallback: (pattern) =>
                                                manuState.modelOfManu.where(
                                                    (element) => element.name
                                                        .toLowerCase()
                                                        .contains(pattern
                                                            .toLowerCase())),
                                            hideSuggestionsOnKeyboardHide:
                                                false,
                                            itemBuilder: (context, suggestion) {
                                              return ListTile(
                                                title: Text(suggestion.name),
                                              );
                                            },
                                            noItemsFoundBuilder: (context) =>
                                                Center(
                                                  child: Text(cusConstants
                                                      .NOT_FOUND_MODEL_SEARCH),
                                                ),
                                            onSuggestionSelected: (suggestion) {
                                              this._typeAheadController.text =
                                                  suggestion.name;
                                              setState(() {
                                                _isChangeValueModelName = true;
                                                this._modelName.text = this
                                                    ._typeAheadController
                                                    .text;
                                              });
                                            }),
                                      ],
                                    );
                                  }
                                }),
                                // : modelOfManu,
                                Container(height: 14),
                                licenNumber,
                                Container(height: 14),
                                repairTime,
                                Container(height: 14),
                                kilometer,
                                Container(height: 14),
                                SizedBox(
                                  width: 150,
                                  height: 35,
                                  child: elevatedButton,
                                )
                              ],
                            ),
                          ),
                        );
                      } else
                        return Center(
                            child: Text(cusConstants.NOT_FOUND_INFO_VEHICLE));
                    } else if (state.detailStatus ==
                        CustomerCarDetailStatus.error) {
                      return ErrorWidget(state.message.toString());
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput), [dd, '/', mm, '/', yyyy]);
  }
}
