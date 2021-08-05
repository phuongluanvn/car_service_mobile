import 'package:car_service/blocs/manager/Accessories/accessory_bloc.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_state.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/utils/model/accessory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void initState() {
    super.initState();
    processBloc = BlocProvider.of<ProcessOrderBloc>(context);
    BlocProvider.of<AccessoryBloc>(context).add(DoListAccessories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessOrderBloc, ProcessOrderState>(
      builder: (context, state) {
        if (state.detailStatus == ProcessDetailStatus.success) {
          return Card(
            child: Column(children: [
              ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        state.processDetail[0].orderDetails[widget.index].name),
                    Text(
                        '${state.processDetail[0].orderDetails[widget.index].price}'),
                  ],
                ),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                          print('111111111111');
                          print(accstate.accessoryList.indexWhere((element) =>
                                  element.id ==
                                  state
                                      .processDetail[0]
                                      .orderDetails[widget.index]
                                      .accessoryId) >=
                              0);
                          return Column(
                            children: [
                              state.processDetail[0].orderDetails[0]
                                              .accessoryId !=
                                          null &&
                                      isEditTextField == false
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(accstate.accessoryList.indexWhere(
                                                    (element) =>
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
                                            : 'default'),
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                isEditTextField = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        TypeAheadFormField(
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                            controller:
                                                this._typeAheadController,
                                          ),
                                          suggestionsCallback: (pattern) =>
                                              accstate
                                                  .accessoryList
                                                  .where((element) => element
                                                      .name
                                                      .toLowerCase()
                                                      .contains(pattern
                                                          .toLowerCase())),
                                          hideSuggestionsOnKeyboardHide: false,
                                          itemBuilder: (context,
                                              AccessoryModel suggestion) {
                                            return ListTile(
                                              title: Text(suggestion.name),
                                            );
                                          },
                                          noItemsFoundBuilder: (context) =>
                                              Center(
                                            child: Text('No item found'),
                                          ),
                                          onSuggestionSelected: (suggestion) {
                                            this._typeAheadController.text =
                                                suggestion.name;
                                            _accId = suggestion.id;
                                          },
                                          onSaved: (value) =>
                                              this._selectAccName = value,
                                        ),

                                        // TODO: implement listener

                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: AppTheme.colors.blue),
                                            onPressed: () {
                                              setState(() {
                                                isEditTextField = false;
                                              });
                                              print(_accId);
                                              print( state
                                                        .processDetail[0]
                                                        .orderDetails[
                                                            widget.index]
                                                        .id);
                                              processBloc.add(
                                                UpdateAccesIdToOrder(
                                                    orderId: widget.orderId,
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
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}
