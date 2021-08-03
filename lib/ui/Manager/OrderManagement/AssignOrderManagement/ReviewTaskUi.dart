import 'package:car_service/blocs/manager/Accessories/accessory_bloc.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_state.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_state.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/packageService/PackageService_bloc.dart';
import 'package:car_service/blocs/packageService/PackageService_event.dart';
import 'package:car_service/blocs/packageService/PackageService_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/PackageServiceModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/accessory_model.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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
  bool isHasData = false;
  AccessoryBloc _accessoryBloc;
  List selectedDetailsValue;
  List<AccessoryModel> listAcc;
  final TextEditingController _typeAheadController = TextEditingController();
  String _selectAccName;
  ProcessOrderBloc processBloc;
  @override
  void initState() {
    super.initState();
    processBloc = BlocProvider.of<ProcessOrderBloc>(context);
    processBloc.add(DoProcessOrderDetailEvent(email: widget.orderId));
    print('Order id is:' + widget.orderId);

    BlocProvider.of<AccessoryBloc>(context).add(DoListAccessories());
  }

  void onChanged(bool value) {
    setState(() {
      checkedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Dịch vụ'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
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
                // child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: FittedBox(
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * 0.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black26),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      'Cập nhật thông tin dịch vụ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Center(
                                      child: Column(
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  state.processDetail[0]
                                                      .orderDetails.length;
                                              i++)
                                            Card(
                                              child: Column(children: [
                                                ExpansionTile(
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(state
                                                          .processDetail[0]
                                                          .orderDetails[i]
                                                          .name),
                                                      Text(
                                                          '${state.processDetail[0].orderDetails[i].price}'),
                                                    ],
                                                  ),
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 10),
                                                      child: BlocBuilder<
                                                          AccessoryBloc,
                                                          AccessoryState>(
                                                        // ignore: missing_return
                                                        builder:
                                                            // ignore: missing_return
                                                            (context,
                                                                accstate) {
                                                          if (accstate.status ==
                                                              ListAccessoryStatus
                                                                  .init) {
                                                            return CircularProgressIndicator();
                                                          } else if (accstate
                                                                  .status ==
                                                              ListAccessoryStatus
                                                                  .loading) {
                                                            return CircularProgressIndicator();
                                                          } else if (accstate
                                                                  .status ==
                                                              ListAccessoryStatus
                                                                  .success) {
                                                            return Column(
                                                              children: [
                                                                TypeAheadFormField(
                                                                  textFieldConfiguration: TextFieldConfiguration(
                                                                      controller:
                                                                          this
                                                                              ._typeAheadController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                              labelText: 'Nhập tên phụ tùng cần tìm')),
                                                                  suggestionsCallback: (pattern) => accstate
                                                                      .accessoryList
                                                                      .where((element) => element
                                                                          .name
                                                                          .toLowerCase()
                                                                          .contains(
                                                                              pattern.toLowerCase())),
                                                                  hideSuggestionsOnKeyboardHide:
                                                                      false,
                                                                  itemBuilder: (context,
                                                                      AccessoryModel
                                                                          suggestion) {
                                                                    return ListTile(
                                                                      title: Text(
                                                                          suggestion
                                                                              .name),
                                                                    );
                                                                  },
                                                                  noItemsFoundBuilder:
                                                                      (context) =>
                                                                          Center(
                                                                    child: Text(
                                                                        'No item found'),
                                                                  ),
                                                                  onSuggestionSelected:
                                                                      (suggestion) {
                                                                    this._typeAheadController.text =
                                                                        suggestion
                                                                            .name;
                                                                  },
                                                                  onSaved: (value) =>
                                                                      this._selectAccName =
                                                                          value,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary: AppTheme
                                                                                .colors.blue),
                                                                        onPressed:
                                                                            () {
                                                                          processBloc
                                                                              .add(
                                                                            UpdateAccesIdToOrder(
                                                                                orderId: widget.orderId,
                                                                                detailId: state.processDetail[0].orderDetails[i].id,
                                                                                accId: _typeAheadController.text,
                                                                                serviceId: state.processDetail[0].orderDetails[i].serviceId,
                                                                                quantity: 1,
                                                                                price: state.processDetail[0].orderDetails[i].price),
                                                                          );
                                                                          print(
                                                                              _typeAheadController.text);
                                                                        },
                                                                        child: Text(
                                                                            'Cập nhật')),
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary: Colors
                                                                                .red),
                                                                        onPressed:
                                                                            () {},
                                                                        child: Text(
                                                                            'Hủy bỏ')),
                                                                  ],
                                                                ),
                                                              ],
                                                            );
                                                          } else if (accstate
                                                                  .status ==
                                                              ListAccessoryStatus
                                                                  .error) {
                                                            return ErrorWidget(
                                                                state.message
                                                                    .toString());
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                  // services.map((service) {
                                                  //   return ListTile(
                                                  //     title: Text(service.name),
                                                  //     trailing: Text('${service.price}'),
                                                  //   );
                                                  // }).toList(),
                                                ),
                                              ]),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppTheme.colors.blue),
                            child: Text('Hoàn tất',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              Navigator.pop(context);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (_) => AssignOrderReviewUi(
                              //           userId: widget.orderId,
                              //         )));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // ),
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

  // List<AccessoryModel> getAccessory(String query) {
  //   List<AccessoryModel> list;
  //   BlocListener<AccessoryBloc, AccessoryState>(
  //     listener: (context, state) {
  //       if (state.status == ListAccessoryStatus.success) {
  //         list.addAll(state.accessoryList);
  //       }
  //     },
  //   );

  //   return list;
  // }

}
