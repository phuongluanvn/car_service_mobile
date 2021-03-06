import 'package:car_service/blocs/manager/waitingPayment/waitingPayment_bloc.dart';
import 'package:car_service/blocs/manager/waitingPayment/waitingPayment_events.dart';
import 'package:car_service/blocs/manager/waitingPayment/waitingPayment_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/ManageWaitingPayment/WaitingPaymentDetailUi.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_service/utils/helpers/constants/ManagerConstants.dart'
    as manaConstants;
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

  Future<void> _getData() async {
    setState(() {
      BlocProvider.of<WaitingPaymentBloc>(context)
          .add(DoListWaitingPaymentEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
      body: RefreshIndicator(
        onRefresh: _getData,
        child: BlocBuilder<WaitingPaymentBloc, WaitingPaymentState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == WaitingPaymentStatus.init) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == WaitingPaymentStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status ==
                WaitingPaymentStatus.waitingPaymentSuccess) {
              if (state.waitingPaymentList != null &&
                  state.waitingPaymentList.isNotEmpty)
                return SingleChildScrollView(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
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
                          leading: Image.asset(manaConstants.IMAGE_LOGO_SMALL),
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
                  ),
                );
              else
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.35),
                              child: Text(manaConstants.NOT_FOUND_ORDER_LABLE)),
                        ],
                      ),
                    ),
                  ],
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
