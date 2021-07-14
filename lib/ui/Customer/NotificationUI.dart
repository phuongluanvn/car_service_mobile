import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/ui/Customer/CarManagement/CustomerCarDetailUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationUI extends StatefulWidget {
  @override
  _NotificationUIState createState() => _NotificationUIState();
}

class _NotificationUIState extends State<NotificationUI> {
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
        title: Text('Thông báo'),
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
                          title: Text('Xe của bạn đã hoàn thành'),
                          subtitle:
                              Text('Mời bạn đến nhận xe ở cửa hàng'),
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
                  child: Text('Không có thông báo'),
                );
            } else if (state.status == CustomerCarStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
      
    );
  }
}
