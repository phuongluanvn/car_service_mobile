// import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
// import 'package:car_service/blocs/manager/staff/staff_events.dart';
// import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class StaffDetailUi extends StatefulWidget {
  StaffModel staffm;
  StaffDetailUi({this.staffm});

  @override
  _StaffDetailUiState createState() => _StaffDetailUiState();
}

class _StaffDetailUiState extends State<StaffDetailUi> {
  // StaffBloc staffBloc;
  // @override
  // void initState() {
  //   staffBloc = BlocProvider.of<StaffBloc>(context);
  //   staffBloc.add(DoStaffDetailEvent(email: widget.emailId));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail note')),
      // body: Center(
      // child: BlocBuilder<StaffBloc, StaffState>(
      //   builder: (context, state) {
      //     if (state is StaffInitState) {
      //       return CircularProgressIndicator();
      //     } else if (state is StaffLoadingState) {
      //       return CircularProgressIndicator();
      //     } else if (state is StaffDetailSucessState) {
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    widget.staffm.hoTen,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.all(5.0),
                  child: Text(
                    widget.staffm.email,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    widget.staffm.soDt,
                    style: TextStyle(
                      color: Colors.grey[800],
                      //fontWeight: FontWeight,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // }
      // },
      // ),
      // )
    );
  }
}
