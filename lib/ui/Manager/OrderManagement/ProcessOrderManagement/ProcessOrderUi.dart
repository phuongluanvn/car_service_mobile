import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderDetailUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/ProcessOrderManagement/ProcessOrderDetailUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProcessOrderUi extends StatefulWidget {
  @override
  _ProcessOrderUiState createState() => _ProcessOrderUiState();
}

class _ProcessOrderUiState extends State<ProcessOrderUi> {
  @override
  void initState() {
    super.initState();

    context.read<ProcessOrderBloc>().add(DoListProcessOrderEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: BlocBuilder<ProcessOrderBloc, ProcessOrderState>(
          builder: (context, state) {
            if (state.status == ProcessStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == ProcessStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == ProcessStatus.processSuccess) {
              if (state.processList != null && state.processList.isNotEmpty)
                return ListView.builder(
                  itemCount: state.processList.length,
                  shrinkWrap: true,
                  // ignore: missing_return
                  itemBuilder: (context, index) {
                    // if (state.assignList[index].status == 'Accepted') {
                    return Card(
                        // child: (state.assignList[0].status == 'Checkin')
                        //     ?
                        child: Column(children: [
                      ListTile(
                        trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.circle,
                                color: Colors.orange[300],
                              ),
                              Text(state.processList[index].status),
                            ]),
                        leading: FlutterLogo(),
                        title:
                            Text(state.processList[index].vehicle.licensePlate),
                        subtitle: Text(state.processList[index].bookingTime),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ProcessOrderDetailUi(
                                  orderId: state.processList[index].id)));
                        },
                      ),
                    ])
                        // : SizedBox(),
                        );
                    // } else {
                    //   return Center(
                    //     child: Text('Empty'),
                    //   );
                    // }
                  },
                );
              else
                return Center(
                  child: Text('Hiện tại không có đơn'),
                );
            } else if (state.status == ProcessStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
