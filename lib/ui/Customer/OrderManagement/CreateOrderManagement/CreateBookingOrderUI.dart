import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/customer/customerService/CustomerService_bloc.dart';
import 'package:car_service/blocs/customer/customerService/CustomerService_event.dart';
import 'package:car_service/blocs/customer/customerService/CustomerService_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateBookingOrderUI extends StatefulWidget {
  @override
  _CreateBookingOrderUIState createState() => _CreateBookingOrderUIState();
}

class _CreateBookingOrderUIState extends State<CreateBookingOrderUI> {
  String carId;
  bool _visible = false;
  String selectItem;
  DateTime _selectedDay;
  DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    context.read<CustomerServiceBloc>().add(DoServiceListEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getDropDownItem() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đặt lịch dịch vụ'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Danh sách xe'),
              Container(
                color: Colors.green,
                child: BlocBuilder<CustomerCarBloc, CustomerCarState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state.status == CustomerCarStatus.init) {
                      return CircularProgressIndicator();
                    } else if (state.status == CustomerCarStatus.loading) {
                      return CircularProgressIndicator();
                    } else if (state.status ==
                        CustomerCarStatus.loadedCarSuccess) {
                      if (state.carLists != null && state.carLists.isNotEmpty)
                        return ListView.builder(
                          itemCount: state.carLists.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            //hiển thị list xe
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('lib/images/car_default.png'),
                                ),
                                title: Text(
                                  state.carLists[index].taiKhoan,
                                  style: TextStyle(
                                      color: (carId ==
                                              state.carLists[index].taiKhoan)
                                          ? Colors.blue
                                          : Colors.grey),
                                ),
                                subtitle: Text(state.carLists[index].email),
                                onTap: () {
                                  setState(() {
                                    carId = state.carLists[index].taiKhoan;
                                    _visible = !_visible;
                                  });
                                },
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            );
                          },
                        );
                      else //nếu không có xe nào
                        return Text('Không có thông tin xe');
                    } else if (state.status == CustomerCarStatus.error) {
                      return ErrorWidget(state.message.toString());
                    }
                  },
                ),
              ),
              Visibility(
                  // visible: _visible,
                  child: Column(
                children: <Widget>[
                  // const Divider(
                  //   color: Colors.black87,
                  //   height: 20,
                  //   thickness: 1,
                  //   indent: 10,
                  //   endIndent: 10,
                  // ),
                  // Text('Chọn dịch vụ'),
                  // Container(
                  //   color: Colors.green,
                  //   child: BlocBuilder<CustomerServiceBloc,
                  //       CustomerServiceState>(
                  //     // ignore: missing_return
                  //     builder: (context, stateService) {
                  //       if (stateService.status ==
                  //           CustomerServiceStatus.init) {
                  //         return Text('------');
                  //       } else if (stateService.status ==
                  //           CustomerServiceStatus.loading) {
                  //         return Text('?????');
                  //       } else if (stateService.status ==
                  //           CustomerServiceStatus.loadedServiceSuccess) {
                  //         if (stateService.serviceLists != null &&
                  //             stateService.serviceLists.isNotEmpty)
                  //           return ListView.builder(
                  //             itemCount: stateService.serviceLists.length,
                  //             shrinkWrap: true,
                  //             itemBuilder: (context, index) {
                  //               //hiển thị list xe
                  //               return Card(
                  //                 child: ListTile(
                  //                   leading: CircleAvatar(
                  //                     backgroundImage: AssetImage(
                  //                         'lib/images/car_default.png'),
                  //                   ),
                  //                   title: Text(
                  //                     stateService.serviceLists[index].name,
                  //                     style: TextStyle(
                  //                         color: (carId ==
                  //                                 stateService
                  //                                     .serviceLists[index]
                  //                                     .name)
                  //                             ? Colors.blue
                  //                             : Colors.grey),
                  //                   ),
                  //                   subtitle: Text(stateService
                  //                       .serviceLists[index].type),
                  //                   onTap: () {
                  //                     setState(() {
                  //                       carId = stateService
                  //                           .serviceLists[index].name;
                  //                       // _visible = !_visible;
                  //                     });
                  //                   },
                  //                 ),
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius:
                  //                         BorderRadius.circular(20)),
                  //               );
                  //             },
                  //           );
                  //         else //nếu không có dịch vụ
                  //           return Text('Không có thông dịch vụ');
                  //       } else if (stateService.status ==
                  //           CustomerServiceStatus.error) {
                  //         return ErrorWidget(
                  //             stateService.message.toString());
                  //       }
                  //     },
                  //   ),
                  // ),

                  Text('Chọn thời gian'),
                  Container(
                    child: TableCalendar(
                      firstDay: DateTime.utc(2020),
                      lastDay: DateTime.utc(2030),
                      focusedDay: DateTime.now(),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay =
                              focusedDay; // update `_focusedDay` here as well
                        });
                      },
                    ),
                  )
                ],
              )),
              Divider(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {},
                child: Text('Xác nhận'),
              )
            ],
          ),
        ),
      ),
      // Visibility(
      //   visible: _visible,
      //   child: Container(
      //     child: BlocBuilder<StaffBloc, StaffState>(
      //         // ignore: missing_return
      //         builder: (builder, staffState) {
      //       if (staffState is StaffInitState) {
      //         return CircularProgressIndicator();
      //       } else if (staffState is StaffLoadingState) {
      //         return CircularProgressIndicator();
      //       } else if (staffState is StaffListSuccessState) {
      //         return Column(
      //           children: [
      //             DropdownButton<String>(
      //               hint: Text('Select Staff'),
      //               items: staffState.staffList.map((valueItem) {
      //                 return DropdownMenuItem<String>(
      //                   child: Text(valueItem.taiKhoan),
      //                   value: valueItem.taiKhoan,
      //                 );
      //               }).toList(),
      //               onChanged: (newValue) {
      //                 setState(() {
      //                   this.selectItem = newValue;
      //                 });
      //               },
      //               value: selectItem,
      //             ),
      //             ElevatedButton(
      //               child: Text('Checking'),
      //               onPressed: () {
      //                 // getDropDownItem,
      //                 // Navigator.of(context).push(MaterialPageRoute(
      //                 //     builder: (_) => AssignOrderReviewUi(
      //                 //         userId: state.assignDetail[0].taiKhoan,
      //                 //         staffId: selectItem)));
      //               },
      //             ),
      //             Container(
      //               // child: Text('$holder'),
      //             ),
      //           ],
      //         );
      //       }
      //       // else if (state is StaffListErrorState) {
      //       //   return ErrorWidget(state.message.toString());
      //       // }
      //       ;
      //     }),
      //   ),
      // )
      // ],
      // ),
    );
  }
}
