import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_bloc.dart';
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
import 'package:car_service/ui/Manager/CrewManagement/CreateCrewManagement/LeaderCrewDetailUi.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/utils/model/CustomerModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/createCrewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_service/utils/helpers/constants/ManagerConstants.dart'
    as manaConstants;

class CreateCrewUi extends StatefulWidget {
  @override
  _CreateCrewUiState createState() => _CreateCrewUiState();
}

class _CreateCrewUiState extends State<CreateCrewUi> {
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

  @override
  void initState() {
    BlocProvider.of<ManageStaffBloc>(context)
        .add(DoListStaffWithAvaiStatusEvent());
    crewBloc = BlocProvider.of<CrewBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final logo = Center(
    //   child: Icon(Icons.supervised_user_circle, size: 150),
    // );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text(manaConstants.CREATE_CREW_TITLE),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppTheme.colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 25),
                          child: BlocBuilder<ManageStaffBloc, ManageStaffState>(
                            // ignore: missing_return
                            builder: (context, state) {
                              if (state.status == StaffStatus.init) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state.status == StaffStatus.loading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state.status ==
                                  StaffStatus.staffListAvaisuccess) {
                                if (state.avaiList != null &&
                                    state.avaiList.isNotEmpty) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black26),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          manaConstants.SELECT_STAFF_LABLE,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        GridView.builder(
                                          itemCount: state.avaiList.length,
                                          shrinkWrap: true,
                                          // ignore: missing_return
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio:
                                                1.6, // T??? l??? chi???u-ngang/chi???u-r???ng c???a m???t item trong grid, ??? ????y width = 1.6 * height
                                            crossAxisCount:
                                                2, // S??? item tr??n m???t h??ng ngang
                                            crossAxisSpacing:
                                                5, // Kho???ng c??ch gi???a c??c item trong h??ng ngang
                                            mainAxisSpacing: 0,
                                            // Kho???ng c??ch gi???a c??c h??ng (gi???a c??c item trong c???t d???c)
                                          ),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              child: Card(
                                                color: (_listStaff.indexWhere(
                                                            (element) =>
                                                                element
                                                                    .username ==
                                                                state
                                                                    .avaiList[
                                                                        index]
                                                                    .username) >=
                                                        0)
                                                    ? AppTheme.colors.blue
                                                    : Colors.white,
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    backgroundImage: AssetImage(
                                                        manaConstants.IMAGE_MECHANIC),
                                                  ),
                                                  title: Text(
                                                    state.avaiList[index]
                                                        .fullname,
                                                    style: TextStyle(
                                                      color: (_listStaff.indexWhere((element) =>
                                                                  element
                                                                      .username ==
                                                                  state
                                                                      .avaiList[
                                                                          index]
                                                                      .username) >=
                                                              0
                                                          // _carId ==
                                                          //       state
                                                          //           .staffList[
                                                          //               index]
                                                          //           .username)
                                                          ? AppTheme
                                                              .colors.white
                                                          : AppTheme
                                                              .colors.deepBlue),
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    state
                                                        .avaiList[index].status,
                                                    //  +
                                                    // " - " +
                                                    // state
                                                    //     .vehicleLists[
                                                    //         index]
                                                    //     .model,
                                                    style: TextStyle(
                                                      color: (_listStaff.indexWhere((element) =>
                                                                  element
                                                                      .username ==
                                                                  state
                                                                      .avaiList[
                                                                          index]
                                                                      .username) >=
                                                              0
                                                          ? AppTheme
                                                              .colors.white
                                                          : AppTheme
                                                              .colors.deepBlue),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      CreateCrewModel
                                                          createCrewModel =
                                                          CreateCrewModel(
                                                              username: state
                                                                  .avaiList[
                                                                      index]
                                                                  .username);
                                                      // _carId = state
                                                      //     .staffList[index]
                                                      //     .username;
                                                      // print(_carId);
                                                      if (_listStaff.indexWhere(
                                                              (element) =>
                                                                  element
                                                                      .username ==
                                                                  state
                                                                      .avaiList[
                                                                          index]
                                                                      .username) >=
                                                          0) {
                                                        _listStaff.remove(
                                                            createCrewModel);
                                                        print(_listStaff);
                                                      } else {
                                                        _listStaff.add(
                                                            createCrewModel);
                                                        print(_listStaff);
                                                      }
                                                      // _visible = !_visible;
                                                    });
                                                  },
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
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
                                                          LeaderCrewDetailUi(
                                                            choosingCrew:
                                                                _listStaff,
                                                          )));
                                            },
                                            child: Text(manaConstants.CONFIRM_BUTTON)),
                                        // BlocListener<CreateOrderBloc,
                                        //     CreateOrderState>(
                                        //   listener: (context, state) {
                                        //     if (state.status ==
                                        //         CreateOrderStatus
                                        //             .createOrderSuccess) {
                                        //       // Navigator.pop(context);
                                        //       showDialog(
                                        //           context: context,
                                        //           builder: (BuildContext ctx) {
                                        //             return AlertDialog(
                                        //               title: Text(
                                        //                 'Th??ng b??o!',
                                        //                 style: TextStyle(
                                        //                     color: Colors
                                        //                         .greenAccent),
                                        //               ),
                                        //               content:
                                        //                   Text(state.message),
                                        //               actions: [
                                        //                 TextButton(
                                        //                     onPressed: () {
                                        //                       if (state
                                        //                               .message ==
                                        //                           '?????t l???ch h???n th??nh c??ng') {
                                        //                         Navigator.of(
                                        //                                 context)
                                        //                             .pop();
                                        //                       } else {
                                        //                         Navigator.of(
                                        //                                 context)
                                        //                             .pop();
                                        //                         Navigator.pop(
                                        //                             context);
                                        //                       }

                                        //                       // context
                                        //                       //     .read<CustomerOrderBloc>()
                                        //                       //     .add(DoOrderListEvent());
                                        //                     },
                                        //                     child:
                                        //                         Text('?????ng ??'))
                                        //               ],
                                        //             );
                                        //           });
                                        //     }
                                        //   },
                                        //   child: ElevatedButton(
                                        //     style: ElevatedButton.styleFrom(
                                        //       primary: AppTheme
                                        //           .colors.blue, // background
                                        //       onPrimary:
                                        //           Colors.white, // foreground
                                        //     ),
                                        //     onPressed: () {

                                        //       // if (_listStaff.isEmpty) {
                                        //       //   showDialog(
                                        //       //       context: context,
                                        //       //       builder:
                                        //       //           (BuildContext ctx) {
                                        //       //         return AlertDialog(
                                        //       //           title: Text(
                                        //       //             'Th??ng b??o!',
                                        //       //             style: TextStyle(
                                        //       //                 color: Colors
                                        //       //                     .redAccent),
                                        //       //           ),
                                        //       //           content: Text(
                                        //       //               'Vui l??ng ch???n nh??n vi??n!'),
                                        //       //           actions: [
                                        //       //             TextButton(
                                        //       //                 onPressed: () {
                                        //       //                   // Close the dialog
                                        //       //                   Navigator.of(
                                        //       //                           context)
                                        //       //                       .pop();
                                        //       //                 },
                                        //       //                 child: Text(
                                        //       //                     '?????ng ??'))
                                        //       //           ],
                                        //       //         );
                                        //       //       });
                                        //       // } else {
                                        //       //   crewBloc.add(
                                        //       //       CreateOrderButtonPressed(
                                        //       //     carId: _carId,
                                        //       //     serviceId: null,
                                        //       //     note: _note,
                                        //       //     timeBooking: _focusedDay
                                        //       //         .toIso8601String(),
                                        //       //   ));
                                        //       // }
                                        //     },
                                        //     child: Text('X??c nh???n'),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  );
                                } else //n???u kh??ng c?? xe n??o
                                  return Text(manaConstants.NOT_FOUND_STAFF_INFO);
                              } else if (state.status == StaffStatus.error) {
                                return Text(manaConstants.NOT_FOUND_STAFF);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
