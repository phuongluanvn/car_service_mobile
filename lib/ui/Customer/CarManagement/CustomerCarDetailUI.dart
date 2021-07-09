import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
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
        .add(DoCarDetailEvent(email: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Thông tin xe'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.pop(context),
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
              if (state.vehicleLists != null && state.vehicleLists.isNotEmpty)
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Container(height: 14),
                      TextFormField(
                        initialValue: state.vehicleLists[0].model,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
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
                        initialValue: state.vehicleLists[0].manufacturer,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.directions_car),
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
                        initialValue: state.vehicleLists[0].licensePlate,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
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
                      SizedBox(
                        width: double.infinity,
                        height: 35,
                        child: RaisedButton(
                          child: Text('Submit',
                              style: TextStyle(color: Colors.white)),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                );
              else
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
