import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignOrderUi extends StatefulWidget {
  @override
  _AssignOrderUiState createState() => _AssignOrderUiState();
}

class _AssignOrderUiState extends State<AssignOrderUi> {
  AssignOrderBloc assignBloc;

  @override
  void initState() {
    assignBloc = BlocProvider.of<AssignOrderBloc>(context);
    assignBloc.add(DoListAssignOrderEvent());
    super.initState();
  }

  @override
  void dispose() {
    assignBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: BlocBuilder<AssignOrderBloc, AssignOrderState>(
          builder: (context, state) {
            if (state is AssignOrderInitState) {
              return CircularProgressIndicator();
            } else if (state is AssignOrderLoadingState) {
              return CircularProgressIndicator();
            } else if (state is AssignOrderSuccessState) {
              return ListView.builder(
                itemCount: state.orderList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 70.0,
                                  height: 70.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: CircleAvatar(
                                    radius: 5.0,
                                    backgroundColor: Colors.blue[300],
                                    foregroundColor: Colors.green[300],
                                  ),
                                ),
                                SizedBox(width: 30.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      state.orderList[index].hoTen,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      state.orderList[index].email,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 15.0),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is AssignOrderErrorState) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
