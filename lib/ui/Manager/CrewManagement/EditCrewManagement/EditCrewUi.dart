import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_event.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_state.dart';
import 'package:car_service/blocs/manager/EditCrewManagement%20copy/editCrew_cubit.dart';
import 'package:car_service/blocs/manager/EditCrewManagement%20copy/editCrew_state.dart';
// import 'package:car_service/blocs/customer/customerOrder/CreateBooking_bloc.dart';
// import 'package:car_service/blocs/customer/customerOrder/CreateBooking_event.dart';
// import 'package:car_service/blocs/customer/customerOrder/CreateBooking_state.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_bloc.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_state.dart';
import 'package:car_service/blocs/manager/createOrder/createOrder_event.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/packageService/PackageService_bloc.dart';
import 'package:car_service/blocs/packageService/PackageService_event.dart';
import 'package:car_service/blocs/packageService/PackageService_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/CrewManagement/EditCrewManagement/EditLeaderCrewUi.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/utils/model/CalendarModel.dart';
import 'package:car_service/utils/model/CustomerModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/createCrewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCrewUi extends StatefulWidget {
  final String id;
  EditCrewUi({@required this.id});
  @override
  _EditCrewUiState createState() => _EditCrewUiState();
}

class _EditCrewUiState extends State<EditCrewUi> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  // CreateOrderBloc _createOrderBloc;
  CustomerCarBloc customerCarBloc;

  List<CreateCrewModel> _listStaff = [];
  String selectItem;
  // List<CustomerModel> listload;
  final Color selectedColor = AppTheme.colors.lightblue;
  final Color unselectedColor = Colors.black;
  CrewBloc crewBloc;
  EditCrewCubit editCrewCubit = EditCrewCubit();

  @override
  void initState() {
    BlocProvider.of<ManageStaffBloc>(context)
        .add(DoListStaffWithAvaiStatusEvent());

    crewBloc = BlocProvider.of<CrewBloc>(context);
    crewBloc.add(DoReloadStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Chỉnh sửa tổ đội'),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: BlocProvider(
        create: (context) => editCrewCubit,
        child: MultiBlocListener(
          listeners: [
            BlocListener<CrewBloc, CrewState>(
              listenWhen: (previous, current) =>
                  previous.statusDetail != current.statusDetail,
              listener: (context, crstate) {
                print(crstate.statusDetail);
                if (crstate.statusDetail == DoCrewDetailStatus.success) {
                  print(crstate.crewDetails[0].members);
                  editCrewCubit
                      .prepareSelectedList(crstate.crewDetails[0].members);
                }
              },
            ),
            BlocListener<ManageStaffBloc, ManageStaffState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, ststate) {
                print("check: ${ststate.status}");
                if (ststate.status == StaffStatus.staffListAvaisuccess) {
                  editCrewCubit.prepareUnselectedList(ststate.avaiList);
                }
              },
            )
          ],
          child: BlocBuilder<EditCrewCubit, EditCrewState>(
            builder: (context, estate) {
              print("check: ${estate.status}");
              if (estate.status == EditCrewStatus.success &&
                  estate.status != null) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppTheme.colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Chọn nhân viên',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black26),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Nhân viên được chọn',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      GridView.builder(
                                        itemCount: estate.selectedList.length,
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
                                              color: AppTheme.colors.deepBlue,
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: AssetImage(
                                                      'lib/images/mechanic.png'),
                                                ),
                                                title: Text(
                                                  estate.selectedList[index]
                                                      .username,
                                                  style: TextStyle(
                                                    color:
                                                        AppTheme.colors.white,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  estate.selectedList[index]
                                                      .isLeader
                                                      .toString(),
                                                  style: TextStyle(
                                                    color:
                                                        AppTheme.colors.white,
                                                  ),
                                                ),
                                                onTap: () {
                                                  editCrewCubit.removeCrew(
                                                      estate
                                                          .selectedList[index]);
                                                },
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              margin: EdgeInsets.only(
                                                  top: 0,
                                                  left: 2,
                                                  right: 2,
                                                  bottom: 30),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Nhân viên đang hoạt động',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      GridView.builder(
                                        itemCount: estate.unselectedList.length,
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
                                              color: (_listStaff.indexWhere(
                                                          (element) =>
                                                              element
                                                                  .username ==
                                                              estate
                                                                  .unselectedList[
                                                                      index]
                                                                  .username) >=
                                                      0)
                                                  ? AppTheme.colors.blue
                                                  : Colors.white,
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: AssetImage(
                                                      'lib/images/mechanic.png'),
                                                ),
                                                title: Text(
                                                  estate.unselectedList[index]
                                                      .username,
                                                  style: TextStyle(
                                                    color: (_listStaff.indexWhere((element) =>
                                                                element
                                                                    .username ==
                                                                estate
                                                                    .unselectedList[
                                                                        index]
                                                                    .username) >=
                                                            0
                                                        ? AppTheme.colors.white
                                                        : AppTheme
                                                            .colors.deepBlue),
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  estate.unselectedList[index]
                                                      .isLeader
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: (_listStaff.indexWhere((element) =>
                                                                element
                                                                    .username ==
                                                                estate
                                                                    .unselectedList[
                                                                        index]
                                                                    .username) >=
                                                            0
                                                        ? AppTheme.colors.white
                                                        : AppTheme
                                                            .colors.deepBlue),
                                                  ),
                                                ),
                                                onTap: () {
                                                  editCrewCubit.addCrew(estate
                                                      .unselectedList[index]);
                                                },
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              margin: EdgeInsets.only(
                                                  top: 0,
                                                  left: 2,
                                                  right: 2,
                                                  bottom: 30),
                                            ),
                                          );
                                        },
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: AppTheme.colors.blue),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        EditLeaderCrewUi(
                                                          choosingCrew: estate
                                                              .selectedList,id: widget.id,
                                                        )));
                                          },
                                          child: Text('Xác nhận')),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else
                return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
