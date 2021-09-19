import 'package:car_service/blocs/manager/CrewManagement/crew_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_event.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_state.dart';
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
    context.read<CrewBloc>().add(DoListCrew());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getData() async {
    setState(() {
      BlocProvider.of<CrewBloc>(context).add(DoListCrew());
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
        child: BlocBuilder<CrewBloc, CrewState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == ListCrewStatus.init) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == ListCrewStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == ListCrewStatus.success) {
              if (state.crewList != null && state.crewList.isNotEmpty) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
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
                          manaConstants.IMAGE_NETWORKING,
                        ),
                        title: Text(state.crewList[index].leaderFullname ?? ''),
                        subtitle: Row(
                          children: [
                            Text(manaConstants.NUMBER_OF_STAFF_LABLE),
                            Text(state.crewList[index].members.length
                                .toString()),
                          ],
                        ),
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
            } else if (state.status == ListCrewStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
