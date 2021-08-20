import 'package:car_service/blocs/manager/Accessories/accessory_bloc.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_state.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_state.dart';
import 'package:car_service/blocs/manager/updateItem/updateItem_bloc.dart';
import 'package:car_service/blocs/manager/updateItem/updateItem_state.dart';
import 'package:car_service/blocs/manager/updateItem/updateItem_event.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/utils/model/accessory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ExpansionList extends StatefulWidget {
  ExpansionList({Key key, this.index, this.orderId}) : super(key: key);
  final int index;
  final String orderId;
  @override
  _ExpansionListState createState() => _ExpansionListState();
}

class _ExpansionListState extends State<ExpansionList> {
  final TextEditingController _typeAheadController = TextEditingController();
  bool isEditTextField = false;
  String _selectAccName;
  String _accId;
  ProcessOrderBloc processBloc;
  UpdateItemBloc updateItemBloc;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    updateItemBloc = BlocProvider.of<UpdateItemBloc>(context);
    processBloc = BlocProvider.of<ProcessOrderBloc>(context);
    BlocProvider.of<AccessoryBloc>(context).add(DoListAccessories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessOrderBloc, ProcessOrderState>(
      builder: (context, state) {
        if (state.detailStatus == ProcessDetailStatus.success) {
          return Slidable(
            secondaryActions: [
              BlocListener<UpdateItemBloc, UpdateItemState>(
                listener: (context, state) {
                  if (state.deleteStatus ==
                      // ignore: unrelated_type_equality_checks
                      DeleteByIdStatus.success) {
                    processBloc
                        .add(DoProcessOrderDetailEvent(email: widget.orderId));
                  }
                },
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  child: Icon(Icons.delete),
                  onPressed: () {
                    updateItemBloc.add(DeleteServiceByIdEvent(
                        detailId: state
                            .processDetail[0].orderDetails[widget.index].id));
                  },
                ),
              ),
            ],
            actionPane: SlidableDrawerActionPane(),
            child: Card(
              child: Column(children: [
                ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(state
                          .processDetail[0].orderDetails[widget.index].name),
                      Text(
                          '${state.processDetail[0].orderDetails[widget.index].price}'),
                    ],
                  ),
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: BlocBuilder<AccessoryBloc, AccessoryState>(
                        // ignore: missing_return
                        builder:
                            // ignore: missing_return
                            (context, accstate) {
                          if (accstate.status == ListAccessoryStatus.init) {
                            return CircularProgressIndicator();
                          } else if (accstate.status ==
                              ListAccessoryStatus.loading) {
                            return CircularProgressIndicator();
                          } else if (accstate.status ==
                              ListAccessoryStatus.success) {
                            return Column(
                              children: [
                                state
                                                .processDetail[0]
                                                .orderDetails[widget.index]
                                                .accessoryId !=
                                            null &&
                                        isEditTextField == false
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(accstate.accessoryList
                                                      .indexWhere((element) =>
                                                          element.id ==
                                                          state
                                                              .processDetail[0]
                                                              .orderDetails[
                                                                  widget.index]
                                                              .accessoryId) >=
                                                  0
                                              ? accstate.accessoryList
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      state
                                                          .processDetail[0]
                                                          .orderDetails[
                                                              widget.index]
                                                          .accessoryId)
                                                  .name
                                              : 'Hiện tại không có phụ tùng'),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shadowColor: Colors.white,
                                                primary: Colors.white,
                                                elevation: 0,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isEditTextField = true;
                                                });
                                              },
                                              child: Icon(
                                                Icons.edit,
                                                color: AppTheme.colors.blue,
                                              ))
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          TypeAheadFormField(
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                              decoration: InputDecoration(
                                                labelText: 'Nhập tên phụ tùng',
                                              ),
                                              controller:
                                                  this._typeAheadController,
                                            ),
                                            suggestionsCallback: (pattern) =>
                                                accstate.accessoryList.where(
                                                    (element) => element.name
                                                        .toLowerCase()
                                                        .contains(pattern
                                                            .toLowerCase())),
                                            hideSuggestionsOnKeyboardHide:
                                                false,
                                            itemBuilder: (context,
                                                AccessoryModel suggestion) {
                                              return ListTile(
                                                title: Text(suggestion.name),
                                              );
                                            },
                                            noItemsFoundBuilder: (context) =>
                                                Center(
                                              child: Text(
                                                  'Không tìm thấy phụ tùng'),
                                            ),
                                            onSuggestionSelected: (suggestion) {
                                              this._typeAheadController.text =
                                                  suggestion.name;
                                              _accId = suggestion.id;
                                            },
                                            onSaved: (value) =>
                                                this._selectAccName = value,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: AppTheme
                                                              .colors.blue),
                                                  onPressed: () {
                                                    setState(() {
                                                      quantity++;
                                                    });
                                                    // processBloc.add(UpdateTest(orderId: widget.orderId, acc: state
                                                    //     .processDetail[0].orderDetails));
                                                   
                                                    print(_accId);
                                                  },
                                                  child: Text('x ' + quantity.toString())),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: AppTheme
                                                              .colors.blue),
                                                  onPressed: () {
                                                    setState(() {
                                                      isEditTextField = false;
                                                    });
                                                    // processBloc.add(UpdateTest(orderId: widget.orderId, acc: state
                                                    //     .processDetail[0].orderDetails));
                                                    processBloc.add(
                                                      UpdateAccesIdToOrder(
                                                          orderId:
                                                              widget.orderId,
                                                          detailId: state
                                                              .processDetail[0]
                                                              .orderDetails[
                                                                  widget.index]
                                                              .id,
                                                          accId: _accId,
                                                          serviceId: state
                                                              .processDetail[0]
                                                              .orderDetails[
                                                                  widget.index]
                                                              .serviceId,
                                                          quantity: 1,
                                                          price: state
                                                              .processDetail[0]
                                                              .orderDetails[
                                                                  widget.index]
                                                              .price),
                                                    );
                                                    print(_accId);
                                                  },
                                                  child: Text('Cập nhật')),
                                            ],
                                          )

                                          // TODO: implement listener
                                        ],
                                      ),
                              ],
                            );
                          } else if (accstate.status ==
                              ListAccessoryStatus.error) {
                            return ErrorWidget(state.message.toString());
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
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}
