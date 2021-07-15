import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffDetailUi extends StatefulWidget {
  final String username;
  StaffDetailUi({@required this.username});

  @override
  _StaffDetailUiState createState() => _StaffDetailUiState();
}

class _StaffDetailUiState extends State<StaffDetailUi> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ManageStaffBloc>(context)
        .add(DoStaffDetailEvent(username: widget.username));
    print(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff'),
      ),
      body: Center(
        child: BlocBuilder<ManageStaffBloc, ManageStaffState>(
          builder: (context, state) {
            if (state.detailStatus == StaffDetailStatus.init) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == StaffDetailStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == StaffDetailStatus.success) {
              if (state.staffDetail != null && state.staffDetail.isNotEmpty)
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              'A:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            child: Text(
                              state.staffDetail[0].fullname ?? 'Empty',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              'B:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            child: Text(
                              state.staffDetail[0].email ?? 'Empty',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              'C:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            child: Text(
                              state.staffDetail[0].status ?? 'Empty',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 35,
                        child: ElevatedButton(
                          child: Text('Absent',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                );
              else
                return Center(child: Text('Empty'));
            } else if (state.status == StaffStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
