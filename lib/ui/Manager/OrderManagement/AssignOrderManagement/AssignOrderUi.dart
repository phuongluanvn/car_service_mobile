import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderDetailUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignOrderUi extends StatefulWidget {
  @override
  _AssignOrderUiState createState() => _AssignOrderUiState();
}

class _AssignOrderUiState extends State<AssignOrderUi> {
  @override
  void initState() {
    super.initState();

    context.read<AssignOrderBloc>().add(DoListAssignOrderEvent());
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
        child: BlocBuilder<AssignOrderBloc, AssignOrderState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == AssignStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == AssignStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == AssignStatus.assignSuccess) {
              if (state.assignList != null && state.assignList.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.assignList.length,
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
                                color: Colors.yellow,
                              ),
                              Text(state.assignList[index].status),
                            ]),
                        leading: FlutterLogo(),
                        title:
                            Text(state.assignList[index].vehicle.licensePlate),
                        subtitle: Text(state.assignList[index].bookingTime),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AssignOrderDetailUi(
                                  orderId: state.assignList[index].id)));
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
              } else
                return Center(
                  child: Text('Empty'),
                );
            } else if (state.status == AssignStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
