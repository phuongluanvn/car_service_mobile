import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/customer/customerCar/DelCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/DelCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/DelCar_state.dart';
import 'package:car_service/blocs/customer/customerCar/UpdateCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/UpdateCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/UpdateCar_state.dart';
import 'package:car_service/theme/app_theme.dart';
// import 'package:car_service/ui/Customer/CarManagement/EditInforOfCarUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerCarDetailUi extends StatefulWidget {
  final String id;
  CustomerCarDetailUi({@required this.id});

  @override
  _CustomerCarDetailUiState createState() => _CustomerCarDetailUiState();
}

class _CustomerCarDetailUiState extends State<CustomerCarDetailUi> {
  String _manufacturer, _model, _licensePlate;
  DateTime _dateOfLastMaintenance;
  String _millageCount;
  UpdateCarBloc _updateCarButton;

  @override
  void initState() {
    super.initState();
    _updateCarButton = BlocProvider.of<UpdateCarBloc>(context);
    BlocProvider.of<CustomerCarBloc>(context)
        .add(DoCarDetailEvent(vehicleId: widget.id));
  }

  Image image;

  _showSuccessUpdateDialog() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              'Thông báo!',
              style: TextStyle(color: Colors.greenAccent),
            ),
            content: Text('Cập nhật thông tin xe thành công!'),
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

  _showDeleteDialog() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              'Thông báo!',
              style: TextStyle(color: Colors.redAccent),
            ),
            content: Text('Bạn có chắc muốn xóa xe này?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Hủy')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    BlocProvider.of<DeleteCarBloc>(context)
                        .add(DoDeleteCarEvent(vehicleId: widget.id));
                  },
                  child: Text('Đồng ý'))
            ],
          );
        });
  }

  _showDelSuccessDialog() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              'Thông báo!',
              style: TextStyle(color: Colors.greenAccent),
            ),
            content: Text('Xóa thông tin xe thành công!'),
            actions: [
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    // Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/customer');
                  },
                  child: Text('Đồng ý'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
      appBar: AppBar(
          title: Text('Thông tin xe'),
          backgroundColor: AppTheme.colors.deepBlue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            // IconButton(
            //     onPressed: () {
            //       Navigator.of(context).push(
            //           MaterialPageRoute(builder: (_) => EditInforOfCarUi()));
            //     },
            //     icon: Icon(Icons.edit)),
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
                        'Thông báo!',
                        style: TextStyle(color: Colors.greenAccent),
                      ),
                      content: Text('Xóa thông tin xe thành công!'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              // Close the dialog
                              // Navigator.of(context).pop();
                              Navigator.pushNamed(context, '/customer');
                            },
                            child: Text('Đồng ý'))
                      ],
                    );
                  });
            }
          },
          child: BlocListener<UpdateCarBloc, UpdateCarState>(
            listener: (context, state) {
              if (state.updateStatus == UpdateCarStatus.updateDetailSuccess) {
                return showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: Text(
                          'Thông báo!',
                          style: TextStyle(color: Colors.greenAccent),
                        ),
                        content: Text('Cập nhật thông tin xe thành công!'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                // Close the dialog
                                // Navigator.of(context).pop();
                                // Navigator.pushNamed(context, '/customer');
                              },
                              child: Text('Đồng ý'))
                        ],
                      );
                    });
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
                                'https://picsum.photos/400/200?image=1070');
                            break;
                          default:
                            image = Image.network(
                                'https://picsum.photos/400/200?image=1071');
                        }
                        var manufacturer = TextFormField(
                          onChanged: (newManu) {
                            _manufacturer = newManu;
                          },
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
                            labelText: 'Hãng xe',
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                        var modelOfManu = TextFormField(
                          onChanged: (newModel) {
                            _model = newModel;
                          },
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
                            labelText: 'Mẫu xe',
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                        var licenNumber = TextFormField(
                          onChanged: (newPlace) {
                            _licensePlate = newPlace;
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
                            labelText: 'Biển số',
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                        var repairTime = TextFormField(
                          onChanged: (newManu) {
                            _dateOfLastMaintenance = DateTime.parse(newManu);
                          },
                          initialValue:
                              state.vehicleDetail[0].dateOfLastMaintenance,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.date_range),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.black54),
                            // hintText: state.vehicleDetail[0].taiKhoan,
                            // text
                            labelText: 'Bảo dưỡng lần cuối',
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                        var kilometer = TextFormField(
                          onChanged: (km) {
                            _millageCount = km;
                          },
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
                            labelText: 'Số km ghi nhận gần nhất',
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                        var elevatedButton = ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppTheme.colors.blue),
                          child: Text('Lưu',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            print(widget.id);
                            print(_manufacturer);
                            print(_model);
                            print(_licensePlate);
                            print(_dateOfLastMaintenance);
                            print(_millageCount);

                            // _updateCarButton.add(UpdateCarButtonPressed(
                            //   carId: widget.id,
                            //   manufacturer: _manufacturer,
                            //   model: _model,
                            //   licensePlateNumber: _licensePlate,
                            //   dateOfLastMaintenance: _dateOfLastMaintenance,
                            //   millageCount: _millageCount
                            // ));
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
                                modelOfManu,
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
                        return Center(child: Text('Empty'));
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
}
