import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewTaskUi extends StatefulWidget {
  // CheckoutOrderUi(
  //   // {@required this.emailId}
  //   );

  @override
  _ReviewTaskUiState createState() => _ReviewTaskUiState();
}

class _ReviewTaskUiState extends State<ReviewTaskUi> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

  bool _visible = false;
  bool checkedValue = false;
  String selectItem;
  String holder = '';
  List results = [];
  @override
  void initState() {
    super.initState();

    // BlocProvider.of<ProcessOrderBloc>(context)
    //     .add(DoProcessOrderDetailEvent(email: widget.emailId));
    BlocProvider.of<StaffBloc>(context).add(DoListServiceEvent());
  }

  void onChanged(bool value) {
    setState(() {
      checkedValue = value;
    });
  }

  DataRow _getDataRow(result) {
    return DataRow(
      cells: <DataCell>[
        DataCell(TextField(
          decoration: InputDecoration(hintText: '1'),
        )),
        DataCell(TextField(
          decoration: InputDecoration(hintText: '2'),
        )),
        DataCell(TextField(
          decoration: InputDecoration(hintText: '2'),
        )),
      ],
    );
  }

  void getDropDownItem() {
    setState(() {
      holder = selectItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dịch vụ'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Center(
            child: BlocBuilder<StaffBloc, StaffState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state is StaffInitState) {
                  return CircularProgressIndicator();
                } else if (state is StaffLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is ServiceListSuccessState) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Expanded(
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Column(
                          children: [
                            
                             DataTable(
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Gói dịch vụ',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Số\nlượng',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Đơn\n giá',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: state.svList
                                    .map((data) =>
                                        // we return a DataRow every time
                                        DataRow(
                                            // List<DataCell> cells is required in every row
                                            cells: [
                                              // DataCell((data.verified)
                                              //     ? Icon(
                                              //         Icons.verified_user,
                                              //         color: Colors.green,
                                              //       )
                                              //     : Icon(Icons.cancel, color: Colors.red)),
                                              // I want to display a green color icon when user is verified and red when unverified

                                              DataCell(Text(data.name)),
                                              DataCell(
                                                  Text(data.price.toString())),
                                              DataCell(Checkbox(
                                                  value: checkedValue,
                                                  onChanged: (bool value) {
                                                    onChanged(value);
                                                  })),
                                            ]))
                                    .toList(),
                              ),
                            

                            // ElevatedButton(onPressed: ,),
                            const Divider(
                              color: Colors.black87,
                              height: 20,
                              thickness: 1,
                              indent: 10,
                              endIndent: 10,
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            ExpansionTileCard(
                                baseColor: Colors.cyan[50],
                                expandedColor: Colors.red[50],
                                key: cardA,
                                leading: CircleAvatar(),
                                title: Text("Flutter Dev's"),
                                subtitle: Text("FLUTTER DEVELOPMENT COMPANY"),
                                children: <Widget>[
                                  Divider(
                                    thickness: 1.0,
                                    height: 1.0,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      child: Text(
                                        "FlutterDevs specializes in creating cost-effective and efficient applications with our perfectly crafted,"
                                        " creative and leading-edge flutter app development solutions for customers all around the globe.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.spaceAround,
                                    buttonHeight: 52.0,
                                    buttonMinWidth: 90.0,
                                    children: <Widget>[
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        onPressed: () {
                                          cardA.currentState?.expand();
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.arrow_downward),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                            ),
                                            Text('Open'),
                                          ],
                                        ),
                                      ),
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        onPressed: () {
                                          cardA.currentState?.collapse();
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.arrow_upward),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                            ),
                                            Text('Close'),
                                          ],
                                        ),
                                      ),
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        onPressed: () {},
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.swap_vert),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                            ),
                                            Text('Toggle'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue),
                                    child: Text('Lưu',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => ManagerMain()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is StaffListErrorState) {
                  return ErrorWidget(state.message.toString());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
