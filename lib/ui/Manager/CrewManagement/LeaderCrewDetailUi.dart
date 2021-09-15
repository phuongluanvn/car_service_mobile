import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_event.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_state.dart';
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
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/utils/model/CustomerModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/createCrewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderCrewDetailUi extends StatefulWidget {
  final List<CreateCrewModel> choosingCrew;

  LeaderCrewDetailUi({@required this.choosingCrew});
  @override
  _LeaderCrewDetailUiState createState() => _LeaderCrewDetailUiState();
}

class _LeaderCrewDetailUiState extends State<LeaderCrewDetailUi> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  // CreateOrderBloc _createOrderBloc;
  CustomerCarBloc customerCarBloc;

  // List<String> _listStaff = [];

  String selectItem;

  final Color selectedColor = AppTheme.colors.lightblue;
  final Color unselectedColor = Colors.black;
  CrewBloc crewBloc;
  int _crewId = 0;
  @override
  void initState() {
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
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: BlocListener<CrewBloc, CrewState>(
                    listener: (context, state) {
                      print(state.message);
                      if (state.createStatus == CreateCrewStatus.success) {
                        showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: Text(
                                  'Thông báo!',
                                  style: TextStyle(color: Colors.greenAccent),
                                ),
                                content: Text(state.message),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        // BlocProvider.of<CrewBloc>(context)
                                        //     .add(DoListCrew());
                                      },
                                      child: Text('Đồng ý'))
                                ],
                              );
                            });
                      }
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 25),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  'Chọn tổ trưởng của đội',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  // child: SingleChildScrollView(
                                  child: ListView.builder(
                                    itemCount: widget.choosingCrew.length,
                                    shrinkWrap: true,
                                    // ignore: missing_return
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: ListTile(
                                          title: Text(
                                            widget.choosingCrew[index].username,
                                            style: TextStyle(
                                                color: (_crewId == index)
                                                    ? AppTheme.colors.deepBlue
                                                    : Colors.grey),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _crewId = index;
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  ),

                                  // ),
                                )
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppTheme.colors.blue),
                            onPressed: () {
                              widget.choosingCrew[_crewId].isLeader = true;
                              crewBloc.add(CreateCrewEvent(
                                  listUsername: widget.choosingCrew));
                            },
                            child: Text('Tạo tổ đội'))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
