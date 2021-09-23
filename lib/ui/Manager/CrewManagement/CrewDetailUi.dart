import 'package:car_service/blocs/manager/CrewManagement/crew_bloc.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_event.dart';
import 'package:car_service/blocs/manager/CrewManagement/crew_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/CrewManagement/EditCrewManagement/EditCrewUi.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:car_service/utils/helpers/constants/ManagerConstants.dart'
    as manaConstants;

class CrewDetailUi extends StatefulWidget {
  final String id;
  CrewDetailUi({@required this.id});

  @override
  _CrewDetailUiState createState() => _CrewDetailUiState();
}

class _CrewDetailUiState extends State<CrewDetailUi> {
  UpdateStatusOrderBloc updateStatusBloc;
  List<CrewModel> _choosingCrew;
  String oId = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CrewBloc>(context).add(DoCrewDetailEvent(id: widget.id));
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text(manaConstants.MANAGE_CREW_TITLE),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5, top: 10, bottom: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: AppTheme.colors.blue),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => EditCrewUi(
                            id: widget.id,
                            orderId: oId,
                          )));
                },
                child: Text(manaConstants.EDIT_BUTTON)),
          )
        ],
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        child: BlocBuilder<CrewBloc, CrewState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.statusDetail == DoCrewDetailStatus.init) {
              return CircularProgressIndicator();
            } else if (state.statusDetail == DoCrewDetailStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.statusDetail == DoCrewDetailStatus.success) {
              if (state.crewDetails[0].order != null &&
                  state.crewDetails[0].order.isNotEmpty) {
                oId = state.crewDetails[0].order[0].id;
                print('checkorderId ' + oId);
              }
              if (state.crewDetails != null && state.crewDetails.isNotEmpty)
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: <Widget>[
                              Text(
                                manaConstants.INFO_STAFF,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GridView.builder(
                                itemCount: state.crewDetails[0].members.length,
                                shrinkWrap: true,
                                // ignore: missing_return
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio:
                                      3.6, // Tỉ lệ chiều-ngang/chiều-rộng của một item trong grid, ở đây width = 1.6 * height
                                  crossAxisCount:
                                      1, // Số item trên một hàng ngang
                                  crossAxisSpacing:
                                      1, // Khoảng cách giữa các item trong hàng ngang
                                  mainAxisSpacing: 0,
                                  // Khoảng cách giữa các hàng (giữa các item trong cột dọc)
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Card(
                                      color: Colors.white,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: AssetImage(
                                              manaConstants.IMAGE_MECHANIC),
                                        ),
                                        title: Text(
                                          state.crewDetails[0].members[index]
                                              .fullname,
                                          style: TextStyle(
                                            color: (AppTheme.colors.deepBlue),
                                          ),
                                        ),
                                        subtitle: Text(
                                          state.crewDetails[0].members[index]
                                                      .isLeader ==
                                                  true
                                              ? manaConstants.LEDER_LABLE
                                              : manaConstants.STAFF_LABLE,
                                          //  +
                                          // " - " +
                                          // state
                                          //     .vehicleLists[
                                          //         index]
                                          //     .model,
                                          style: TextStyle(
                                            color: (AppTheme.colors.deepBlue),
                                            fontWeight: state
                                                        .crewDetails[0]
                                                        .members[index]
                                                        .isLeader ==
                                                    true
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      margin: EdgeInsets.only(
                                          top: 0,
                                          left: 2,
                                          right: 2,
                                          bottom: 30),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        state.crewDetails[0].order.isNotEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            manaConstants.ORDER_RESPONSIBLE,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: Text(
                                                  manaConstants.LICENSE_PLATES,
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  state
                                                          .crewDetails[0]
                                                          .order[0]
                                                          .vehicle
                                                          .licensePlate ??
                                                      '',
                                                  style:
                                                      TextStyle(fontSize: 15.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(height: 16),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: Text(
                                                  manaConstants.MANU_LABLE,
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  state
                                                          .crewDetails[0]
                                                          .order[0]
                                                          .vehicle
                                                          .manufacturer ??
                                                      '',
                                                  style:
                                                      TextStyle(fontSize: 15.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(height: 16),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: Text(
                                                  manaConstants.MODEL_LABLE,
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  state.crewDetails[0].order[0]
                                                          .vehicle.model ??
                                                      '',
                                                  style:
                                                      TextStyle(fontSize: 15.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(height: 16),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: Text(
                                                  manaConstants.STATUS_LABLE,
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  state.crewDetails[0].order[0]
                                                      .status,
                                                  style:
                                                      TextStyle(fontSize: 15.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(height: 16),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black26),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            child: Column(
                                              children: [
                                                Text(
                                                  manaConstants.INFO_SERVICE,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Column(
                                                    children: state
                                                        .crewDetails[0]
                                                        .order[0]
                                                        .orderDetails
                                                        .map((e) {
                                                  return ListTile(
                                                    title: Text(e.name),
                                                  );
                                                }).toList()),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                );
              else
                return Center(child: Text('Không có thông tin'));
            } else if (state.statusDetail == DoCrewDetailStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }

  _convertMoney(double money) {
    MoneyFormatter fmf = new MoneyFormatter(
        amount: money,
        settings: MoneyFormatterSettings(
          symbol: 'VND',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 0,
          // compactFormatType: CompactFormatType.sort
        ));
    print(fmf.output.symbolOnRight);
    return fmf.output.symbolOnRight.toString();
  }
}
