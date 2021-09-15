import 'package:car_service/blocs/manager/CrewManagement/crew_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_event.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrewDetailUi extends StatefulWidget {
  final String id;
  CrewDetailUi({@required this.id});

  @override
  _CrewDetailUiState createState() => _CrewDetailUiState();
}

class _CrewDetailUiState extends State<CrewDetailUi> {
  UpdateStatusOrderBloc updateStatusBloc;

  @override
  void initState() {
    super.initState();
    // updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    BlocProvider.of<CrewBloc>(context).add(DoCrewDetailEvent(id: widget.id));
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    // final String absentStatus = 'absent';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Quản lý tổ đội'),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: BlocBuilder<CrewBloc, CrewState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.statusDetail == DoCrewDetailStatus.init) {
              return CircularProgressIndicator();
            } else if (state.statusDetail == DoCrewDetailStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.statusDetail == DoCrewDetailStatus.success) {
              if (state.crewList != null && state.crewList.isNotEmpty)
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
                            GridView.builder(
                              itemCount: state.crewList[0].members.length,
                              shrinkWrap: true,
                              // ignore: missing_return
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio:
                                    1.6, // Tỉ lệ chiều-ngang/chiều-rộng của một item trong grid, ở đây width = 1.6 * height
                                crossAxisCount:
                                    2, // Số item trên một hàng ngang
                                crossAxisSpacing:
                                    5, // Khoảng cách giữa các item trong hàng ngang
                                mainAxisSpacing: 0,
                                // Khoảng cách giữa các hàng (giữa các item trong cột dọc)
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: AssetImage(
                                            'lib/images/mechanic.png'),
                                      ),
                                      title: Text(
                                        state.crewList[0].members[index]
                                            .fullname,
                                        style: TextStyle(
                                          color: (AppTheme.colors.deepBlue),
                                        ),
                                      ),
                                      subtitle: Text(
                                        state.crewList[0].members[index]
                                                    .isLeader ==
                                                true
                                            ? 'Tổ trưởng'
                                            : 'Nhân viên',
                                        //  +
                                        // " - " +
                                        // state
                                        //     .vehicleLists[
                                        //         index]
                                        //     .model,
                                        style: TextStyle(
                                          color: (AppTheme.colors.deepBlue),
                                        ),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    margin: EdgeInsets.only(
                                        top: 0, left: 2, right: 2, bottom: 30),
                                  ),
                                );
                              },
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
