import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/ui/Customer/CarManagement/CreateCustomerCarUI.dart';
import 'package:car_service/ui/Customer/CarManagement/CustomerCarDetailUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerCarUi extends StatefulWidget {
  @override
  _CustomerCarUiState createState() => _CustomerCarUiState();
}

class _CustomerCarUiState extends State<CustomerCarUi> {
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
      ),
      backgroundColor: Colors.blue[100],
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
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('lib/images/car_default.png'),
                          ),
                          title: Text(state.vehicleLists[index].manufacturer),
                          subtitle:
                              Text(state.vehicleLists[index].licensePlate),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CreateCustomerCarUI()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue[600],
      ),
    );
  }
}
