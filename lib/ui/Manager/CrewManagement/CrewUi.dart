import 'package:car_service/blocs/manager/CrewManagement/crew_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_event.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/CrewManagement/CreateCrewUi.dart';
import 'package:car_service/ui/Manager/CrewManagement/CrewDetailUi.dart';
import 'package:car_service/ui/Manager/StaffManagement/StaffDetailUi.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrewUi extends StatefulWidget {
  @override
  _CrewUiState createState() => _CrewUiState();
}

class _CrewUiState extends State<CrewUi> {
  @override
  void initState() {
    super.initState();
    context.read<CrewBloc>().add(DoListCrew());
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
        title: Text('Quản lý tổ đội'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CreateCrewUi()));
              },
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: BlocBuilder<CrewBloc, CrewState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == ListCrewStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == ListCrewStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == ListCrewStatus.success) {
              return ListView.builder(
                itemCount: state.crewList.length,
                shrinkWrap: true,
                // ignore: missing_return

                itemBuilder: (context, index) {
                  Color color;

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
                        'lib/images/networking.png',
                      ),
                      title: Text(state.crewList[index].id),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                CrewDetailUi(id: state.crewList[index].id)));
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
            } else if (state.status == ListCrewStatus.error) {
              return ErrorWidget(state.message.toString());
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
