import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffDetailUi extends StatefulWidget {
  final String username;
  StaffDetailUi({@required this.username});

  @override
  _StaffDetailUiState createState() => _StaffDetailUiState();
}

class _StaffDetailUiState extends State<StaffDetailUi> {
  UpdateStatusOrderBloc updateStatusBloc;

  @override
  void initState() {
    super.initState();
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    BlocProvider.of<ManageStaffBloc>(context)
        .add(DoStaffDetailEvent(username: widget.username));
    print(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    final String absentStatus = 'absent';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Quản lý nhân viên'),
      ),
      backgroundColor: AppTheme.colors.lightblue,
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
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Thông tin nhân viên',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Text(
                                    'Fullname:',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    state.staffDetail[0].fullname,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Text(
                                    'Email:',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    state.staffDetail[0].email,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Text(
                                    'Phone number:',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    state.staffDetail[0].phoneNumber,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Text(
                                    'Status:',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    state.staffDetail[0].status,
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BlocListener<UpdateStatusOrderBloc,
                                UpdateStatusOrderState>(
                              // ignore: missing_return
                              listener: (builder, statusState) {
                                if (statusState.status ==
                                    UpdateStatus.updateStatusAbsentSuccess) {
                                  Navigator.pushNamed(context, '/manager');
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: AppTheme.colors.blue),
                                      child: Text('Nghỉ phép',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        updateStatusBloc.add(
                                            UpdateAbsentStatusButtonPressed(
                                                username: state
                                                    .staffDetail[0].username,
                                                status: absentStatus));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
