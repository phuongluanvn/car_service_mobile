import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/waitingPayment/waitingPayment_bloc.dart';
import 'package:car_service/blocs/manager/waitingPayment/waitingPayment_events.dart';
import 'package:car_service/blocs/manager/waitingPayment/waitingPayment_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/ManageWaitingPayment/WaitingPaymentDetailUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderDetailUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/ProcessOrderManagement/ProcessOrderDetailUi.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WaitingPaymentUi extends StatefulWidget {
  @override
  _WaitingPaymentUiState createState() => _WaitingPaymentUiState();
}

class _WaitingPaymentUiState extends State<WaitingPaymentUi> {
  @override
  void initState() {
    super.initState();

    context.read<WaitingPaymentBloc>().add(DoListWaitingPaymentEvent());
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
        child: BlocBuilder<WaitingPaymentBloc, WaitingPaymentState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == WaitingPaymentStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == WaitingPaymentStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status ==
                WaitingPaymentStatus.waitingPaymentSuccess) {
              if (state.waitingPaymentList != null &&
                  state.waitingPaymentList.isNotEmpty)
                return ListView.builder(
                  itemCount: state.waitingPaymentList.length,
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
                              Text(state.waitingPaymentList[index].status),
                            ]),
                        leading: Image.asset('lib/images/order_small.png'),
                        title: Text(state
                            .waitingPaymentList[index].vehicle.licensePlate),
                        subtitle: Text(_convertDate(
                            state.waitingPaymentList[index].createdTime)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => WaitingPaymentDetailUi(
                                  orderId:
                                      state.waitingPaymentList[index].id)));
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
            } else if (state.status == WaitingPaymentStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
  }
}
