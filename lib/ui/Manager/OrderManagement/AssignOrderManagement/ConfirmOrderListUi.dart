import 'package:car_service/blocs/assignOrderReview/assignOrderReview_bloc.dart';
import 'package:car_service/blocs/assignOrderReview/assignOrderReview_events.dart';
import 'package:car_service/blocs/assignOrderReview/assignOrderReview_state.dart';
import 'package:car_service/theme/app_theme.dart';

import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmOrderListUi extends StatefulWidget {
  @override
  _ConfirmOrderListUiState createState() => _ConfirmOrderListUiState();
}

class _ConfirmOrderListUiState extends State<ConfirmOrderListUi> {
  @override
  void initState() {
    super.initState();

    context.read<AssignReviewBloc>().add(DoListOrderConfirmEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getData() async {
    setState(() {
      BlocProvider.of<AssignReviewBloc>(context).add(DoListOrderConfirmEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
      body: RefreshIndicator(
        onRefresh: _getData,
        child: BlocBuilder<AssignReviewBloc, AssignReviewState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.listConfirmStatus == ConfirmOrderStatus.init) {
              return Center(child: CircularProgressIndicator());
            } else if (state.listConfirmStatus == ConfirmOrderStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.listConfirmStatus ==
                ConfirmOrderStatus.listConfirmSuccess) {
              if (state.confirmList != null && state.confirmList.isNotEmpty) {
                return SingleChildScrollView(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: state.confirmList.length,
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
                                Text(state.confirmList[index].status),
                              ]),
                          leading: Image.asset('lib/images/order_small.png'),
                          title: Text(
                              state.confirmList[index].vehicle.licensePlate),
                          subtitle: Text(
                            _convertDate(state.confirmList[index].bookingTime),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => AssignOrderReviewUi(
                                    userId: state.confirmList[index].id)));
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
              } else
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
                              child: Text('Hiện tại không có đơn')),
                        ],
                      ),
                    ),
                  ],
                );
            } else if (state.listConfirmStatus == ConfirmOrderStatus.error) {
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
