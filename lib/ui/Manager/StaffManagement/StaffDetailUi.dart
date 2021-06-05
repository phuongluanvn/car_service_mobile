import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffDetailUi extends StatefulWidget {
  final String emailId;
  StaffDetailUi({@required this.emailId});

  @override
  _StaffDetailUiState createState() => _StaffDetailUiState();
}

class _StaffDetailUiState extends State<StaffDetailUi> {
  StaffBloc staffBloc;
  @override
  void initState() {
    staffBloc = BlocProvider.of<StaffBloc>(context);
    staffBloc.add(DoStaffDetailEvent(email: widget.emailId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Edit note')),
        body: Center(
          child: BlocBuilder<StaffBloc, StaffState>(
            builder: (context, state) {
              if (state is StaffInitState) {
                return CircularProgressIndicator();
              } else if (state is StaffLoadingState) {
                return CircularProgressIndicator();
              } else if (state is StaffDetailSucessState) {
                return Scaffold(
                  appBar: AppBar(title: Text('Detail')),
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Text(state.data.email),
                        Container(height: 8),
                        Text(state.data.soDt),
                        Container(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: RaisedButton(
                            child: Text('Submit',
                                style: TextStyle(color: Colors.white)),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ));
  }
}
