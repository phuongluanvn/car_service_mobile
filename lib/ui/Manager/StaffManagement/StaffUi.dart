import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
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
        title: Text('Staff Management'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.blue[100],
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
                              color: Colors.greenAccent[400],
                            ),
                            Text(state.staffList[index].status),
                          ]),
                      leading: FlutterLogo(),
                      title: Text(state.staffList[index].fullname),
                      subtitle: Text(state.staffList[index].status.toString()),
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
