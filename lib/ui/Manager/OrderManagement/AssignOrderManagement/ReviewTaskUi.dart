import 'package:car_service/blocs/manager/Accessories/accessory_bloc.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_state.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_state.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/manager/updateItem/updateItem_bloc.dart';
import 'package:car_service/blocs/manager/updateItem/updateItem_state.dart';
import 'package:car_service/blocs/manager/updateItem/updateItem_event.dart';
import 'package:car_service/blocs/packageService/PackageService_bloc.dart';
import 'package:car_service/blocs/packageService/PackageService_event.dart';
import 'package:car_service/blocs/packageService/PackageService_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/ExpansionList.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/PackageServiceModel.dart';
import 'package:car_service/utils/model/ServiceModel.dart';
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
  bool isEditTextField = false;
  AccessoryBloc _accessoryBloc;
  List selectedDetailsValue;
  List<AccessoryModel> listAcc;
  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _typeAheadController2 = TextEditingController();
  String _accId;
  String _selectAccName;
  ProcessOrderBloc processBloc;
  UpdateItemBloc updateBloc;
  int _priceService = 0;
  int _priceAcc = 0;
  List<ServiceModel> listService = [];
  @override
  void initState() {
    super.initState();
    updateBloc = BlocProvider.of<UpdateItemBloc>(context);
    BlocProvider.of<UpdateItemBloc>(context).add(DoListServices());
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
        child: Center(
          child: BlocConsumer<ProcessOrderBloc, ProcessOrderState>(
            // ignore: missing_return
            listener: (context, state) {
              if (state.updateAccIdStatus == UpdateAccIdStatus.success) {
                processBloc
                    .add(DoProcessOrderDetailEvent(email: widget.orderId));
              }
            },
            builder: (context, state) {
              if (state.detailStatus == ProcessDetailStatus.init ||
                  state.detailStatus == ProcessDetailStatus.loading ||
                  state.updateAccIdStatus == UpdateAccIdStatus.loading) {
                return CircularProgressIndicator();
              } else if (state.detailStatus == ProcessDetailStatus.success ||
                  state.updateAccIdStatus == UpdateAccIdStatus.success) {
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
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
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
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'Tên dịch vụ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'Giá tiền',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: Column(
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    state.processDetail[0]
                                                        .orderDetails.length;
                                                i++)
                                              ExpansionList(
                                                index: i,
                                                orderId: widget.orderId,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppTheme.colors.blue),
                              child: Text('Thêm dịch vụ',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                showInformationDialog(
                                    context, state.processDetail);
                              },
                            ),
                          ),
                        ],
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
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (state.detailStatus == ProcessDetailStatus.error) {
                return ErrorWidget(state.message.toString());
              } else
                return SizedBox();
            },
          ),
        ),
        // ),
        // ),
      ),
    );
  }

  Future showInformationDialog(
      BuildContext context, List<OrderDetailModel> detailList) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Form(
                  child: BlocBuilder<AccessoryBloc, AccessoryState>(
                    // ignore: missing_return
                    builder: (context, astate) {
                      if (astate.status == ListAccessoryStatus.init) {
                        return CircularProgressIndicator();
                      } else if (astate.status == ListAccessoryStatus.loading) {
                        return CircularProgressIndicator();
                      } else if (astate.status == ListAccessoryStatus.success) {
                        // for (int i = 0; i < detailList.length; i++)
                        //   if (detailList[0].orderDetails != null) {
                        //     _priceAcc = astate.accessoryList.indexWhere(
                        //                 (element) =>
                        //                     element.id ==
                        //                     detailList[0]
                        //                         .orderDetails[i]
                        //                         .accessoryId) >=
                        //             0
                        //         ? astate.accessoryList
                        //                 .firstWhere((element) =>
                        //                     element.id ==
                        //                     detailList[0]
                        //                         .orderDetails[i]
                        //                         .accessoryId)
                        //                 .price ??
                        //             'empty'
                        //         : 0;
                        //     print("price acc - " +
                        //         '${detailList[0].orderDetails[i].accessoryId}');
                        //   } else {}
                        // ;
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  'Thêm dịch vụ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                BlocBuilder<UpdateItemBloc, UpdateItemState>(
                                  // ignore: missing_return
                                  builder:
                                      // ignore: missing_return
                                      (context, svstate) {
                                    if (svstate.listServiceStatus ==
                                        ListServiceStatus.init) {
                                      return CircularProgressIndicator();
                                    } else if (svstate.listServiceStatus ==
                                        ListServiceStatus.loading) {
                                      return CircularProgressIndicator();
                                    } else if (svstate.listServiceStatus ==
                                        ListServiceStatus.success) {
                                      return Column(
                                        children: [
                                          Column(
                                            children: [
                                              TypeAheadFormField(
                                                textFieldConfiguration:
                                                    TextFieldConfiguration(
                                                  decoration: InputDecoration(
                                                    labelText: 'Nhập dịch vụ',
                                                  ),
                                                  controller:
                                                      this._typeAheadController,
                                                ),
                                                suggestionsCallback: (pattern) =>
                                                    svstate.listServices.where(
                                                        (element) => element
                                                            .name
                                                            .toLowerCase()
                                                            .contains(pattern
                                                                .toLowerCase())),
                                                hideSuggestionsOnKeyboardHide:
                                                    false,
                                                itemBuilder: (context,
                                                    ServiceModel suggestion) {
                                                  return ListTile(
                                                    title:
                                                        Text(suggestion.name),
                                                  );
                                                },
                                                noItemsFoundBuilder:
                                                    (context) => Center(
                                                  child: Text(
                                                      'Không tìm thấy dịch vụ'),
                                                ),
                                                onSuggestionSelected:
                                                    (suggestion) {
                                                  this
                                                      ._typeAheadController
                                                      .text = suggestion.name;
                                                  _accId = suggestion.id;
                                                  _priceService =
                                                      suggestion.price +
                                                          _priceAcc;
                                                },
                                                onSaved: (value) =>
                                                    this._selectAccName = value,
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    } else if (svstate.listServiceStatus ==
                                        ListServiceStatus.error) {
                                      return ErrorWidget(
                                          svstate.message.toString());
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (astate.status == ListAccessoryStatus.error) {
                        return ErrorWidget(astate.message.toString());
                      }
                    },
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Thêm mới dịch vụ',
                    style: TextStyle(color: AppTheme.colors.blue),
                  ),
                  onPressed: () {
                    print(_priceService);
                    processBloc.add(
                      UpdateAccesIdToOrder(
                        orderId: widget.orderId,
                        detailId: null,
                        accId: null,
                        serviceId: _accId,
                        quantity: 1,
                        price: _priceService,
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
        });
  }
}
