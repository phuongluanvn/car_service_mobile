import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/CustomerOrder_state.dart';
import 'package:car_service/blocs/customer/customerOrder/FeedbackOrder_bloc.dart';
import 'package:car_service/blocs/customer/customerOrder/FeedbackOrder_event.dart';
import 'package:car_service/blocs/customer/customerOrder/FeedbackOrder_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CustomerMainUI.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;

class OrderHistoryDetailUi extends StatefulWidget {
  final String orderId;
  OrderHistoryDetailUi({@required this.orderId});

  @override
  _OrderHistoryDetailUiState createState() => _OrderHistoryDetailUiState();
}

class _OrderHistoryDetailUiState extends State<OrderHistoryDetailUi> {
  UpdateStatusOrderBloc updateStatusBloc;
  FeedbackOrderBloc _buttonFeedback;
  bool _visibleByDenied = false;
  bool textButton = true;
  String reasonReject;
  bool _isShowButtonFB = true;

  @override
  void initState() {
    print(widget.orderId);
    super.initState();
    BlocProvider.of<CustomerOrderBloc>(context)
        .add(DoOrderDetailEvent(id: widget.orderId));
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    _buttonFeedback = BlocProvider.of<FeedbackOrderBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.lightblue,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text(cusConstants.ORDER_DETAIL_TITLE),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<FeedbackOrderBloc, FeedbackOrderState>(
        listener: (context, stateFB) {
          // TODO: implement listener
          if (stateFB.status == FeedbackOrderStatus.successFeedback) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      cusConstants.NOTI_TITLE,
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                    content: Text(cusConstants.THANKYOU_FOR_FEEDBACK),
                    actions: [
                      TextButton(
                          onPressed: () {
                            // Close the dialog
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text(cusConstants.BUTTON_OK_TITLE))
                    ],
                  );
                });
          }
        },
        child: Center(
          child: BlocBuilder<CustomerOrderBloc, CustomerOrderState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state.detailStatus == CustomerOrderDetailStatus.init) {
                return CircularProgressIndicator();
              } else if (state.detailStatus ==
                  CustomerOrderDetailStatus.loading) {
                return CircularProgressIndicator();
              } else if (state.detailStatus ==
                  CustomerOrderDetailStatus.success) {
                if (state.orderDetail != null && state.orderDetail.isNotEmpty)
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        cardInforOrder(
                            state.orderDetail[0].status,
                            _convertDate(state.orderDetail[0].bookingTime),
                            state.orderDetail[0].checkinTime != null
                                ? state.orderDetail[0].checkinTime
                                : cusConstants.CHECKIN_NOT_YET_STATUS,
                            state.orderDetail[0].note != null
                                ? state.orderDetail[0].note
                                : cusConstants.NOT_FOUND_NOTE),
                        cardInforService(
                            state.orderDetail[0].vehicle.model,
                            state.orderDetail[0].vehicle.model,
                            state.orderDetail[0].vehicle.licensePlate,
                            state.orderDetail[0].orderDetails,
                            state.orderDetail[0].note == null ? false : true,
                            state.orderDetail[0].note != null
                                ? state.orderDetail[0].note
                                : cusConstants.NOT_FOUND_NOTE,
                            state.orderDetail[0].note == null
                                ? state.orderDetail[0].packageLists
                                : 0),
                        cardInforCar(
                            state.orderDetail[0].vehicle.manufacturer,
                            state.orderDetail[0].vehicle.model,
                            state.orderDetail[0].vehicle.licensePlate),
                        (state.orderDetail[0].feedbacks.isNotEmpty &&
                                state.orderDetail[0].status != cusConstants.CANCEL_ORDER_STATUS)
                            ? _showFeedback(
                                state.orderDetail[0].feedbacks.first.rating,
                                state
                                    .orderDetail[0].feedbacks.first.description)
                            : BlocListener<UpdateStatusOrderBloc,
                                UpdateStatusOrderState>(
                                listener: (builder, statusState) {
                                  if (statusState.status ==
                                      UpdateStatus
                                          .updateStatusConfirmAcceptedSuccess) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CustomerHome()),
                                    );
                                  }
                                },
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: ElevatedButton(
                                      style: _isShowButtonFB
                                          ? ElevatedButton.styleFrom(
                                              primary: AppTheme.colors.blue)
                                          : ElevatedButton.styleFrom(
                                              primary: Colors.grey),
                                      child: Text(
                                          cusConstants.BUTTON_FEEDBACK_LABLE,
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        if (_isShowButtonFB) {
                                          _showFBDialog();
                                        }
                                      }),
                                ),
                              )
                      ],
                    ),
                  );
                else
                  return Center(
                      child: Text(cusConstants.NOT_FOUND_DETAIL_ORDER));
              } else if (state.detailStatus ==
                  CustomerOrderDetailStatus.error) {
                return ErrorWidget(state.message.toString());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _showFeedback(int rating, String dess) {
    return Card(
      child: Column(
        children: [
          Text(
            cusConstants.FEEDBACK_CARD_TITLE,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          ListTile(
            title: Text(cusConstants.STAR_LABLE),
            trailing: IconTheme(
              data: IconThemeData(color: Colors.yellow, size: 30),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return index < rating
                      ? Icon(Icons.star)
                      : Icon(Icons.star_border);
                }),
              ),
            ),
          ),
          ListTile(
            title: Text(cusConstants.DESCRIPTION_LABLE),
            trailing: Text(dess),
          ),
        ],
      ),
    );
  }

  Widget cardInforCar(String manuName, String modelName, String licensePlace) {
    return Card(
      child: Column(
        children: [
          Text(cusConstants.VEHICLE_INFO_CARD_TITLE,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start),
          ListTile(
            title: Text(cusConstants.LICENSE_PLATE_LABLE),
            trailing: Text(licensePlace),
          ),
          ListTile(
            title: Text(cusConstants.MANU_LABLE),
            trailing: Text(manuName),
          ),
          ListTile(
            title: Text(cusConstants.MODEL_LABLE),
            trailing: Text(modelName),
          ),
        ],
      ),
    );
  }

  Widget cardInforOrder(
      String stautus, String createTime, String checkinTime, String note) {
    return Card(
      child: Column(
        children: [
          Text(
            cusConstants.SERVICE_INFO_CARD_TITLE,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          ListTile(
            title: Text(cusConstants.ORDER_INFO_CARD_STATUS),
            trailing: Text(stautus),
          ),
          ListTile(
            title: Text(cusConstants.ORDER_INFO_CARD_TIME_CREATE),
            trailing: Text(createTime),
          ),
          ListTile(
            title: Text(cusConstants.ORDER_INFO_CARD_TIME_CHECKIN),
            trailing: Text(checkinTime),
          ),
          ListTile(
            title: Text(cusConstants.ORDER_INFO_CARD_CUS_NOTE),
            trailing: Text(note),
          ),
        ],
      ),
    );
  }

  Widget cardInforService(
      String servicePackageName,
      String serviceName,
      String price,
      List services,
      bool serviceType,
      String note,
      int totalPrice) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            Text(
              cusConstants.SERVICE_INFO_CARD_TITLE,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
            ),
            ListTile(
              title: Text(cusConstants.SERVICE_INFO_CARD_TYPE_LABLE),
              trailing: serviceType
                  ? Text(cusConstants.SERVICE_INFO_CARD_TYPE_REPAIR)
                  : Text(cusConstants.SERVICE_INFO_CARD_TYPE_MANTAIN),
            ),
            serviceType
                ? ListTile(
                    title: Text(cusConstants.SERVICE_INFO_CARD_CUS_NOTE),
                    subtitle: Text(
                      note,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ))
                : ExpansionTile(
                    title: Text('Chi tiết:'),
                    children: services.map((service) {
                      return ListTile(
                        title: Text(service.name),
                        trailing: Text(_convertMoney(service.price.toDouble())),
                      );
                    }).toList(),
                  ),
            Divider(
              color: Colors.black,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              title: Text(cusConstants.SERVICE_INFO_CARD_PRICE_TOTAL),
              trailing: Text(_convertMoney(totalPrice.toDouble())),
            ),
          ],
        ),
      ),
    );
  }

  _convertDate(dateInput) {
    return formatDate(DateTime.parse(dateInput),
        [dd, '/', mm, '/', yyyy, ' - ', hh, ':', nn, ' ', am]);
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

  _showFBDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return RatingDialog(
              commentHint: cusConstants.FEEDBACK_COMMENT_HINT,
              title: cusConstants.BUTTON_FEEDBACK_LABLE,
              message: cusConstants.FEEDBACK_MESSAGE,
              image: Icon(
                Icons.star,
                size: 100,
                color: Colors.yellow,
              ),
              submitButton: cusConstants.SEND,
              onSubmitted: (res) {
                setState(() {
                  _isShowButtonFB = false;
                });
                _buttonFeedback.add(DoFeedbackButtonPressed(
                    ordeId: widget.orderId,
                    rating: res.rating,
                    description: res.comment));
              });
        });
  }
}
