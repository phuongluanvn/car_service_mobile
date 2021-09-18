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
        title: Text('Thêm mới tổ đội'),
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
                                          'Chọn nhân viên',
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
                                                        'lib/images/mechanic.png'),
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
                                            child: Text('Xác nhận')),
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
                                        //                 'Thông báo!',
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
                                        //                           'Đặt lịch hẹn thành công') {
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
                                        //                         Text('Đồng ý'))
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
                                        //       //             'Thông báo!',
                                        //       //             style: TextStyle(
                                        //       //                 color: Colors
                                        //       //                     .redAccent),
                                        //       //           ),
                                        //       //           content: Text(
                                        //       //               'Vui lòng chọn nhân viên!'),
                                        //       //           actions: [
                                        //       //             TextButton(
                                        //       //                 onPressed: () {
                                        //       //                   // Close the dialog
                                        //       //                   Navigator.of(
                                        //       //                           context)
                                        //       //                       .pop();
                                        //       //                 },
                                        //       //                 child: Text(
                                        //       //                     'Đồng ý'))
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
                                        //     child: Text('Xác nhận'),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  );
                                } else //nếu không có xe nào
                                  return Text('Không có thông tin nhân viên');
                              } else if (state.status == StaffStatus.error) {
                                return Text('Không tìm thấy xe');
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

            // },
            // return SingleChildScrollView(
            //   child: Center(
            //     child: Column(
            //       children: <Widget>[
            //         SizedBox(
            //           height: 20,
            //         ),
            //       ],
            //     ),
            //   ),
            // );

            // );
          ],
        ),
      ),
    );
  }
}
