import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerCarDetailUi extends StatefulWidget {
  final String id;
  CustomerCarDetailUi({@required this.id});

  @override
  _CustomerCarDetailUiState createState() => _CustomerCarDetailUiState();
}

class _CustomerCarDetailUiState extends State<CustomerCarDetailUi> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CustomerCarBloc>(context)
        .add(DoCarDetailEvent(vehicleId: widget.id));
  }

  Image image;

  void _showSuccessUpdateDialog() {
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
                    Navigator.of(context).pop();
                  },
                  child: Text('Đồng ý'))
            ],
          );
        });
  }

  void _showDeleteDialog() {
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
                    _showSuccessUpdateDialog();
                    // hide the box
                    // setState(() {
                    //   _isShown = false;
                    // });

                    // Close the dialog
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => LoginUi()));
                  },
                  child: Text('Hủy')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
          title: Text('Thông tin xe'),
          backgroundColor: AppTheme.colors.deepBlue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _showDeleteDialog();
                },
                icon: Icon(Icons.delete_forever_rounded)),
          ]),
      body: Center(
        child: BlocBuilder<CustomerCarBloc, CustomerCarState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.detailStatus == CustomerCarDetailStatus.init) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == CustomerCarDetailStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == CustomerCarDetailStatus.success) {
              if (state.vehicleLists != null && state.vehicleLists.isNotEmpty) {
                switch (state.vehicleLists[0].manufacturer) {
                  case 'Axa':
                    image = Image.network(
                        'https://picsum.photos/400/200?image=1070');
                    break;
                  default:
                    image = Image.network(
                        'https://picsum.photos/400/200?image=1071');
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        image,
                        Container(height: 18),
                        TextFormField(
                          initialValue: state.vehicleLists[0].manufacturer,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.black54),
                            // hintText: state.vehicleLists[0].taiKhoan,
                            // text
                            labelText: 'Hãng xe',
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Container(height: 14),
                        TextFormField(
                          initialValue: state.vehicleLists[0].model,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.time_to_leave),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.black54),
                            // hintText: state.vehicleLists[0].taiKhoan,
                            // text
                            labelText: 'Mẫu xe',
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Container(height: 14),
                        TextFormField(
                          initialValue: state.vehicleLists[0].licensePlate,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.payment),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.black54),
                            // hintText: state.vehicleLists[0].taiKhoan,
                            // text
                            labelText: 'Biển số',
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Container(height: 14),
                        TextFormField(
                          initialValue:
                              state.vehicleLists[0].dateOfLastMaintenance,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.date_range),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.black54),
                            // hintText: state.vehicleLists[0].taiKhoan,
                            // text
                            labelText: 'Bảo dưỡng lần cuối',
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Container(height: 14),
                        TextFormField(
                          initialValue:
                              state.vehicleLists[0].millageCount.toString(),
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.av_timer),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.black54),
                            // hintText: state.vehicleLists[0].taiKhoan,
                            // text
                            labelText: 'Số km',
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Container(height: 14),
                        SizedBox(
                          width: 150,
                          height: 35,
                          child: RaisedButton(
                            child: Text('Lưu',
                                style: TextStyle(color: Colors.white)),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              _showSuccessUpdateDialog();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else
                return Center(child: Text('Empty'));
            } else if (state.detailStatus == CustomerCarDetailStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
