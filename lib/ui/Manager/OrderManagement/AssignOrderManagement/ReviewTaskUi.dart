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
  String _selectedValueDetail;
  String _valueSelectedPackageService;
  String _packageId;
  String _note;
  bool isHasData = false;
  AccessoryBloc _accessoryBloc;
  List selectedDetailsValue;
  List<AccessoryModel> listAcc;
  final TextEditingController _typeAheadController = TextEditingController();
  String _selectAccName;

  @override
  void initState() {
    super.initState();
    print('Order id is:' + widget.orderId);
    BlocProvider.of<ProcessOrderBloc>(context)
        .add(DoProcessOrderDetailEvent(email: widget.orderId));
    BlocProvider.of<AccessoryBloc>(context).add(DoListAccessories());
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
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Dịch vụ'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        child: Container(
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
                  child: Center(
                    child: FittedBox(
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Column(
                              children: [
                                Center(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state
                                        .processDetail[0].orderDetails.length,
                                    itemBuilder: (context, index) {
                                      return ExpansionTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(state.processDetail[0]
                                                .orderDetails[index].name),
                                            Text(
                                                '${state.processDetail[0].orderDetails[index].price}'),
                                          ],
                                        ),
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child:
                                                // state
                                                //             .processDetail[0]
                                                //             .orderDetails[0]
                                                //             .accessoryId ==
                                                //         null ||
                                                // isHasData == true
                                                //     ? Row(
                                                //         mainAxisAlignment:
                                                //             MainAxisAlignment
                                                //                 .spaceEvenly,
                                                //         children: [
                                                //           Text(
                                                //               state
                                                //                   .processDetail[
                                                //                       0]
                                                //                   .orderDetails[
                                                //                       0]
                                                //                   .name,
                                                //               style: TextStyle(
                                                //                   fontSize:
                                                //                       16)),
                                                //           ElevatedButton(
                                                //               style:
                                                //                   ElevatedButton
                                                //                       .styleFrom(
                                                //                 primary: Colors
                                                //                     .white,
                                                //                 shadowColor:
                                                //                     Colors
                                                //                         .white,
                                                //               ),
                                                //               onPressed: () {
                                                //                 setState(() {
                                                //                   isHasData =
                                                //                       false;
                                                //                 });
                                                //               },
                                                //               child: Icon(
                                                //                 Icons.edit,
                                                //                 color: AppTheme
                                                //                     .colors
                                                //                     .blue,
                                                //               ))
                                                //         ],
                                                //       )
                                                //     :
                                                BlocListener<AccessoryBloc,
                                                    AccessoryState>(
                                              listener: (context, state) {
                                                if (state.status ==
                                                    ListAccessoryStatus
                                                        .success) {
                                                  listAcc = state.accessoryList;
                                                  print(listAcc);
                                                  print('1111');
                                                }
                                                ;
                                              },
                                              child: TypeAheadFormField(
                                                textFieldConfiguration:
                                                    TextFieldConfiguration(
                                                        controller: this
                                                            ._typeAheadController,
                                                        decoration: InputDecoration(
                                                            labelText:
                                                                'Nhập tên phụ tùng cần tìm')),
                                                suggestionsCallback:
                                                    (pattern) => listAcc.where(
                                                        (element) => element
                                                            .name
                                                            .toLowerCase()
                                                            .contains(pattern
                                                                .toLowerCase())),
                                                hideSuggestionsOnKeyboardHide:
                                                    false,
                                                itemBuilder: (context,
                                                    AccessoryModel suggestion) {
                                                  return ListTile(
                                                    title:
                                                        Text(suggestion.name),
                                                  );
                                                },
                                                noItemsFoundBuilder:
                                                    (context) => Center(
                                                  child: Text('No item found'),
                                                ),
                                                onSuggestionSelected:
                                                    (suggestion) {
                                                  this
                                                      ._typeAheadController
                                                      .text = suggestion.name;
                                                },
                                                onSaved: (value) =>
                                                    this._selectAccName = value,
                                              ),
                                            ),
                                          ),
                                        ],
                                        // services.map((service) {
                                        //   return ListTile(
                                        //     title: Text(service.name),
                                        //     trailing: Text('${service.price}'),
                                        //   );
                                        // }).toList(),
                                      );
                                    },
                                  ),
                                  // ExpansionPanelList(
                                  //   expansionCallback: (int index, bool isExpanded) {
                                  //     _visible = !isExPanded;
                                  //   },
                                  //   children: state
                                  //       .processDetail[0].orderDetails
                                  //       .map<ExpansionPanel>(
                                  //     (e) {
                                  //       return ExpansionPanel(
                                  //         headerBuilder: (context, isExpanded) {
                                  //           return ListTile(
                                  //             title: Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment
                                  //                       .spaceBetween,
                                  //               children: [
                                  //                 Text(e.name),
                                  //                 Text('${e.price}'),
                                  //               ],
                                  //             ),
                                  //           );
                                  //         },
                                  //         body: SingleChildScrollView(
                                  //           child: Container(
                                  //             padding: EdgeInsets.symmetric(
                                  //                 vertical: 10, horizontal: 10),
                                  //             child:
                                  //                 // state
                                  //                 //             .processDetail[0]
                                  //                 //             .orderDetails[0]
                                  //                 //             .accessoryId ==
                                  //                 //         null ||
                                  //                 isHasData == true
                                  //                     ? Row(

                                  //                         mainAxisAlignment:
                                  //                             MainAxisAlignment
                                  //                                 .spaceEvenly,
                                  //                         children: [
                                  //                           Text(
                                  //                               state
                                  //                                   .processDetail[
                                  //                                       0]
                                  //                                   .orderDetails[
                                  //                                       0]
                                  //                                   .name,
                                  //                               style: TextStyle(
                                  //                                   fontSize:
                                  //                                       16)),
                                  //                           ElevatedButton(
                                  //                               style: ElevatedButton
                                  //                                   .styleFrom(
                                  //                                 primary: Colors
                                  //                                     .white,
                                  //                                 shadowColor:
                                  //                                     Colors
                                  //                                         .white,
                                  //                               ),
                                  //                               onPressed: () {
                                  //                                 setState(() {
                                  //                                   isHasData =
                                  //                                       false;
                                  //                                 });
                                  //                               },
                                  //                               child: Icon(
                                  //                                 Icons.edit,
                                  //                                 color: AppTheme
                                  //                                     .colors
                                  //                                     .blue,
                                  //                               ))
                                  //                         ],
                                  //                       )
                                  //                     // : BlocListener<
                                  //                     //     AccessoryBloc,
                                  //                     //     AccessoryState>(
                                  //                     //     listener:
                                  //                     //         (context, state) {
                                  //                     //       if (state.status ==
                                  //                     //           ListAccessoryStatus
                                  //                     //               .success) {
                                  //                     //         listAcc = state
                                  //                     //             .accessoryList;
                                  //                     //       }
                                  //                     //     },
                                  //                     //     child:
                                  //                     : BlocListener<
                                  //                         AccessoryBloc,
                                  //                         AccessoryState>(
                                  //                         listener:
                                  //                             (context, state) {
                                  //                           if (state.status ==
                                  //                               ListAccessoryStatus
                                  //                                   .success) {
                                  //                             listAcc = state
                                  //                                 .accessoryList;
                                  //                           }
                                  //                           ;
                                  //                         },
                                  //                         child:
                                  //                             TypeAheadFormField(
                                  //                           textFieldConfiguration: TextFieldConfiguration(
                                  //                               controller: this
                                  //                                   ._typeAheadController,
                                  //                               decoration:
                                  //                                   InputDecoration(
                                  //                                       labelText:
                                  //                                           'Nhập tên phụ tùng cần tìm')),
                                  //                           suggestionsCallback: (pattern) =>
                                  //                               listAcc.where((element) => element
                                  //                                   .name
                                  //                                   .toLowerCase()
                                  //                                   .contains(
                                  //                                       pattern
                                  //                                           .toLowerCase())),
                                  //                           hideSuggestionsOnKeyboardHide:
                                  //                               false,
                                  //                           itemBuilder: (context,
                                  //                               AccessoryModel
                                  //                                   suggestion) {
                                  //                             return ListTile(
                                  //                               title: Text(
                                  //                                   suggestion
                                  //                                       .name),
                                  //                             );
                                  //                           },
                                  //                           noItemsFoundBuilder:
                                  //                               (context) =>
                                  //                                   Center(
                                  //                             child: Text(
                                  //                                 'No item found'),
                                  //                           ),
                                  //                           onSuggestionSelected:
                                  //                               (suggestion) {
                                  //                             this
                                  //                                     ._typeAheadController
                                  //                                     .text =
                                  //                                 suggestion
                                  //                                     .name;
                                  //                           },
                                  //                           onSaved: (value) =>
                                  //                               this._selectAccName =
                                  //                                   value,
                                  //                         ),
                                  //                       ),
                                  //             // ),
                                  //           ),
                                  //           // TextFoTyrmField(
                                  //           //     maxLines: null,
                                  //           //     autofocus: false,
                                  //           //     decoration:
                                  //           //         InputDecoration(
                                  //           //       prefixIcon: Icon(
                                  //           //           Icons.search),
                                  //           //       filled: true,
                                  //           //       fillColor:
                                  //           //           Colors.white,
                                  //           //       hintStyle: TextStyle(
                                  //           //           color: Colors
                                  //           //               .black54),
                                  //           //       hintText:
                                  //           //           'Nhập tên phụ tùng',
                                  //           //       contentPadding:
                                  //           //           EdgeInsets
                                  //           //               .fromLTRB(
                                  //           //                   20,
                                  //           //                   10,
                                  //           //                   20,
                                  //           //                   10),
                                  //           //       border: OutlineInputBorder(
                                  //           //           borderRadius:
                                  //           //               BorderRadius
                                  //           //                   .circular(
                                  //           //                       5)),
                                  //           //     ),
                                  //           //     onChanged: (event) {
                                  //           //       _accessoryBloc.add(
                                  //           //           DoAccessoryDetailEvent(
                                  //           //               name:
                                  //           //                   event));
                                  //           //     },
                                  //           //     textInputAction:
                                  //           //         TextInputAction
                                  //           //             .search,
                                  //           //   ),
                                  //         ),
                                  //         //     ListView(
                                  //         //   shrinkWrap: true,
                                  //         //   children: state.processDetail
                                  //         //       .map((service) {
                                  //         //     return ListTile(
                                  //         //       title: Text(service
                                  //         //           .orderDetails[0].name),
                                  //         //     );
                                  //         //   }).toList(),
                                  //         // ),
                                  //       );
                                  //     },
                                  //   ).toList(),
                                  // ),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.blue),
                                        child: Text('Lưu',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      AssignOrderReviewUi(
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
                          // Container(
                          //   width: MediaQuery.of(context).size.width * 0.5,
                          //   height: MediaQuery.of(context).size.height * 1,
                          //   child: Column(
                          //     children: [
                          //       Center(
                          //         child: ExpansionPanelList(
                          //           children: state.processDetail[0].orderDetails
                          //               .map<ExpansionPanelRadio>(
                          //             (e) {
                          //               return ExpansionPanelRadio(
                          //                   value: e.name,
                          //                   headerBuilder: (context, isExpanded) {
                          //                     return RadioListTile(
                          //                       title: Text(e.name),
                          //                       onChanged: (value) {
                          //                         setState(() {
                          //                           _valueSelectedPackageService =
                          //                               value;
                          //                           _packageId = value;
                          //                           _note = null;
                          //                         });
                          //                       },
                          //                       controlAffinity:
                          //                           ListTileControlAffinity
                          //                               .leading,
                          //                       groupValue:
                          //                           _valueSelectedPackageService,
                          //                       value: e.id,
                          //                     );
                          //                   },
                          //                   body: SingleChildScrollView(
                          //                     child: ListView(
                          //                       shrinkWrap: true,
                          //                       children: state
                          //                           .processDetail[0].orderDetails
                          //                           .map((service) {
                          //                         return ListTile(
                          //                           title: Text(service.name),
                          //                         );
                          //                       }).toList(),
                          //                     ),
                          //                   ));
                          //               // );
                          //             },
                          //           ).toList(),
                          //         ),
                          //       ),
                          //       const Divider(
                          //         color: Colors.black87,
                          //         height: 20,
                          //         thickness: 1,
                          //         indent: 10,
                          //         endIndent: 10,
                          //       ),
                          //       SizedBox(
                          //         height: 20,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
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

  onSuggestionSelected() {}
}
