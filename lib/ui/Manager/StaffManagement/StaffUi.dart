import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/StaffManagement/StaffDetailUi.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffUi extends StatefulWidget {
  @override
  _StaffUiState createState() => _StaffUiState();
}

class _StaffUiState extends State<StaffUi> {
  @override
  void initState() {
    super.initState();
    context.read<ManageStaffBloc>().add(DoListStaffEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Quản lý nhân viên'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: BlocBuilder<ManageStaffBloc, ManageStaffState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == StaffStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == StaffStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == StaffStatus.staffListsuccess) {
              return ListView.builder(
                itemCount: state.staffList.length,
                shrinkWrap: true,
                // ignore: missing_return

                itemBuilder: (context, index) {
                  Color color;
                  var status = state.staffList[index].status;
                  switch (status) {
                    case 'Nghỉ phép':
                      color = Colors.red[600];
                      break;
                    case 'Đang làm việc':
                      color = Colors.yellow[300];
                      break;

//con nhieu case nua lam sau
                    default:
                      color = Colors.green;
                  }
                  // if (state.assignList[index].status == 'Accepted') {
                  return Card(
                      // child: (state.assignList[0].status == 'Checkin')
                      //     ?
                      child: Column(children: [
                    ListTile(
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.circle,
                                color: color,
                              ),
                            ]),
                      ),
                      leading: Image.asset(
                        'lib/images/mechanic.png',
                      ),
                      title: Text(state.staffList[index].fullname),
                      subtitle: Text(
                        state.staffList[index].status,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => StaffDetailUi(
                                username: state.staffList[index].username)));
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
            } else if (state.status == StaffStatus.error) {
              return ErrorWidget(state.message.toString());
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
