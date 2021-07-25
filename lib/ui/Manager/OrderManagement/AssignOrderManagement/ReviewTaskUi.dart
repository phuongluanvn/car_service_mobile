import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_state.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/packageService/PackageService_bloc.dart';
import 'package:car_service/blocs/packageService/PackageService_event.dart';
import 'package:car_service/blocs/packageService/PackageService_state.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/PackageServiceModel.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ReviewTaskUi extends StatefulWidget {
  final String orderId;
  ReviewTaskUi({@required this.orderId});
  @override
  _ReviewTaskUiState createState() => _ReviewTaskUiState();
}

class _ReviewTaskUiState extends State<ReviewTaskUi> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

  bool _visible = false;
  bool checkedValue = false;
  String selectItem;
  String holder = '';
  List results = [1, 2, 3, 4, 5];
  List<OrderDetailModel> selectedValue;
  List selectedDetailsValue;
  @override
  void initState() {
    super.initState();
    print('Order id is:' + widget.orderId);
    BlocProvider.of<ProcessOrderBloc>(context)
        .add(DoProcessOrderDetailEvent(email: widget.orderId));
    // BlocProvider.of<PackageServiceBloc>(context)
    //     .add(DoPackageServiceListEvent());
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
      body: Container(
        child: BlocBuilder<ProcessOrderBloc, ProcessOrderState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.detailStatus == ProcessDetailStatus.init) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == ProcessDetailStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.detailStatus == ProcessDetailStatus.success) {
              selectedValue = List.from(state.processDetail);
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                rows: selectedValue[0].orderDetails.map((data) {
                                  // int index = data.key;
                                  selectedDetailsValue =
                                      state.processDetail[0].orderDetails;
                                  return DataRow(cells: [
                                    DataCell(DropdownButton(
                                      isExpanded: true,
                                      value: selectedValue[0],
                                      onChanged: (newPackage) {
                                        setState(() {
                                          selectedValue[0] = newPackage;
                                        });
                                      },
                                      items: selectedValue[0]
                                          .orderDetails
                                          .map<DropdownMenuItem>((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value.name),
                                        );
                                      }).toList(),
                                    )),
                                    DataCell(
                                      Text(selectedValue[0].status),
                                    ),
                                    DataCell(Checkbox(
                                      value: checkedValue,
                                      onChanged: (bool value) {
                                        onChanged(value);
                                      },
                                    )),
                                  ]);
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue),
                              child: Text('Lưu',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => AssignOrderReviewUi(
                                          userId: widget.orderId,
                                        )));
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // ),
                // ),
              );
            } else if (state.detailStatus == ProcessDetailStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
        // ),
        // ),
      ),
    );
  }
}
