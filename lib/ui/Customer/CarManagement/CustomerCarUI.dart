import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CarManagement/CreateCustomerCarUI.dart';
import 'package:car_service/ui/Customer/CarManagement/CustomerCarDetailUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerCarUi extends StatefulWidget {
  @override
  _CustomerCarUiState createState() => _CustomerCarUiState();
}

class _CustomerCarUiState extends State<CustomerCarUi> {
  Image image;

  @override
  void initState() {
    super.initState();

    context.read<CustomerCarBloc>().add(DoCarListEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách xe'),
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.colors.deepBlue,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => CreateCustomerCarUI()));
              },
              child: Icon(Icons.add_box_outlined),
            ),
          )
        ],
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: BlocBuilder<CustomerCarBloc, CustomerCarState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == CustomerCarStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == CustomerCarStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == CustomerCarStatus.loadedCarSuccess) {
              if (state.vehicleLists != null && state.vehicleLists.isNotEmpty)
                return ListView.builder(
                  itemCount: state.vehicleLists.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    //hiển thị list xe
                    return Card(
                      child: Column(children: [
                        ListTile(
                          leading: Image.asset('lib/images/logo_blue.png'),
                          title: Text(state.vehicleLists[index].licensePlate),
                          subtitle:
                              Text(state.vehicleLists[index].manufacturer),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => CustomerCarDetailUi(
                                    id: state.vehicleLists[index].id)));
                          },
                        ),
                      ]),
                    );
                  },
                );
              else
                return Center(
                  child: Text('Không có thông tin xe'),
                );
            } else if (state.status == CustomerCarStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
      //thêm mới xe
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (_) => CreateCustomerCarUI()));
      //   },
      //   child: const Icon(Icons.add),
      //   backgroundColor: Colors.blue[600],
      // ),
    );
  }
}
