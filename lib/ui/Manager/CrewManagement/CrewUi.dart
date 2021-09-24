import 'package:car_service/blocs/manager/AssignCrewManagement/assignCrew_bloc.dart';
import 'package:car_service/blocs/manager/AssignCrewManagement/assignCrew_event.dart';
import 'package:car_service/blocs/manager/AssignCrewManagement/assignCrew_state.dart';

import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/CrewManagement/CreateCrewManagement/CreateCrewUi.dart';
import 'package:car_service/ui/Manager/CrewManagement/CrewDetailUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_service/utils/helpers/constants/ManagerConstants.dart'
    as manaConstants;

class CrewUi extends StatefulWidget {
  @override
  _CrewUiState createState() => _CrewUiState();
}

class _CrewUiState extends State<CrewUi> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AssignCrewBloc>(context).add(DoListAssignCrew());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getData() async {
    setState(() {
      BlocProvider.of<AssignCrewBloc>(context).add(DoListAssignCrew());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text(manaConstants.MANAGE_CREW_TITLE),
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
      body: RefreshIndicator(
        onRefresh: _getData,
        child: BlocBuilder<AssignCrewBloc, AssignCrewState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == DoListAssignCrewStatus.init) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == DoListAssignCrewStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == DoListAssignCrewStatus.success) {
              if (state.assignCrewList != null &&
                  state.assignCrewList.isNotEmpty) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: state.assignCrewList.length,
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
                          manaConstants.IMAGE_NETWORKING,
                        ),
                        title: Text(
                            state.assignCrewList[index].leaderFullname ?? ''),
                        subtitle: Row(
                          children: [
                            Text(manaConstants.NUMBER_OF_STAFF_LABLE),
                            Text(state.assignCrewList[index].members.length
                                .toString()),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => CrewDetailUi(
                                  id: state.assignCrewList[index].id)));
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
                              child: Text(manaConstants.NOT_FOUND_CREW)),
                        ],
                      ),
                    ),
                  ],
                );
            } else if (state.status == DoListAssignCrewStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
