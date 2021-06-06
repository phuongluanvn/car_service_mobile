import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/ui/Manager/StaffManagement/StaffDetailUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffUi extends StatefulWidget {
  @override
  _StaffUiState createState() => _StaffUiState();
}

class _StaffUiState extends State<StaffUi> {
  StaffBloc staffBloc;

  @override
  void initState() {
    staffBloc = BlocProvider.of<StaffBloc>(context);
    staffBloc.add(DoListStaffEvent());
    super.initState();
  }

  @override
  void dispose() {
    staffBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Management'),
      ),
      backgroundColor: Colors.blue[100],
      body: Center(
        child: BlocBuilder<StaffBloc, StaffState>(
          builder: (context, state) {
            if (state is StaffInitState) {
              return CircularProgressIndicator();
            } else if (state is StaffLoadingState) {
              return CircularProgressIndicator();
            } else if (state is StaffListSuccessState) {
              return ListView.builder(
                itemCount: state.staffList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.staffList[index].taiKhoan),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => StaffDetailUi(
                              emailId: state.staffList[index].taiKhoan)));
                    },
                  );
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  //   child: Card(
                  //     elevation: 5.0,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //     child: GestureDetector(
                  //       child: Container(
                  //         width: MediaQuery.of(context).size.width,
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 10.0, vertical: 10.0),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: <Widget>[
                  //             Row(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: <Widget>[
                  //                 Container(
                  //                   width: 70.0,
                  //                   height: 70.0,
                  //                   decoration: BoxDecoration(
                  //                       borderRadius:
                  //                           BorderRadius.circular(5.0)),
                  //                   child: CircleAvatar(
                  //                     radius: 5.0,
                  //                     backgroundColor: Colors.blue[300],
                  //                     foregroundColor: Colors.green[300],
                  //                   ),
                  //                 ),
                  //                 SizedBox(width: 30.0),
                  //                 Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: <Widget>[
                  //                     Text(
                  //                       state.staffList[index].hoTen,
                  //                       style: TextStyle(
                  //                           color: Colors.black,
                  //                           fontSize: 25.0,
                  //                           fontWeight: FontWeight.bold),
                  //                     ),
                  //                     Text(
                  //                       state.staffList[index].email,
                  //                       style: TextStyle(
                  //                           color: Colors.black45,
                  //                           fontSize: 15.0),
                  //                     ),
                  //                   ],
                  //                 )
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       onTap: () {
                  //         Navigator.of(context).push(MaterialPageRoute(
                  //             builder: (_) => StaffDetailUi(
                  //                 emailId: state.staffList[index].email)));
                  //       },
                  //     ),
                  //   ),
                  // );
                },
              );
            } else if (state is StaffListErrorState) {
              return ErrorWidget(state.message.toString());
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
