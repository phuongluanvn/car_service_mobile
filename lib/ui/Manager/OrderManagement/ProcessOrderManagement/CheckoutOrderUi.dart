import 'dart:io';
import 'package:car_service/blocs/manager/Accessories/accessory_bloc.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_event.dart';
import 'package:car_service/blocs/manager/Accessories/accessory_state.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_bloc.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_events.dart';
import 'package:car_service/blocs/manager/assignOrder/assignOrder_state.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_bloc.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_events.dart';
import 'package:car_service/blocs/manager/processOrder/processOrder_state.dart';
import 'package:car_service/blocs/manager/staff/staff_bloc.dart';
import 'package:car_service/blocs/manager/staff/staff_events.dart';
import 'package:car_service/blocs/manager/staff/staff_state.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_bloc.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_event.dart';
import 'package:car_service/blocs/manager/updateStatusOrder/update_status_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Manager/ManagerMain.dart';
import 'package:car_service/ui/Manager/OrderManagement/AssignOrderManagement/AssignOrderReviewUi.dart';
import 'package:car_service/utils/repository/manager_repo.dart';
import 'package:car_service/utils/theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:convert';
import 'package:image/image.dart' as ImageProcess;

class CheckoutOrderUi extends StatefulWidget {
  final String orderId;
  List selectService;
  CheckoutOrderUi({@required this.orderId, this.selectService});

  @override
  _CheckoutOrderUiState createState() => _CheckoutOrderUiState();
}

class _CheckoutOrderUiState extends State<CheckoutOrderUi> {
  final String waitingStatus = 'Đợi thanh toán';
  final String availStatus = 'Đang hoạt động';

  UpdateStatusOrderBloc updateStatusBloc;
  bool _visible = false;
  bool checkedValue = false;
  String selectItem;
  String holder = '';
  int total = 0;
  int toal2 = 0;
  int total3 = 0;
  File _image;
  List<Asset> images = List<Asset>();
  String imgUrl = '';
  ManagerRepository _repo = ManagerRepository();

  @override
  void initState() {
    updateStatusBloc = BlocProvider.of<UpdateStatusOrderBloc>(context);
    super.initState();
    BlocProvider.of<AccessoryBloc>(context).add(DoListAccessories());
    // BlocProvider.of<ProcessOrderBloc>(context)
    //     .add(DoProcessOrderDetailEvent(email: widget.orderId));
    // BlocProvider.of<StaffBloc>(context).add(DoListStaffEvent());
  }

  void getDropDownItem() {
    setState(() {
      holder = selectItem;
    });
  }

  //Select pic from gallery
  _imageFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    var file = File(_image.path);

    if (_image != null) {
      //Upload to Firebase
      var snapshot = await _firebaseStorage
          .ref()
          .child('mobile_customer/${file.path}')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imgUrl = downloadUrl;
        print(downloadUrl);
      });
    } else {
      print('No Image Path Received');
    }
  }

  //Select pic from camera
  _imageFromCamera() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  // _convertImagetoString(File images) {
  //   if (images != null) {
  //     final _imageFile = ImageProcess.decodeImage(images.readAsBytesSync());
  //     String base64image = base64Encode(ImageProcess.encodePng(_imageFile));
  //     return base64image;
  //   }
  // }

  //show picker select pac form camera or gallery
  _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.deepBlue,
        title: Text('Thanh toán'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: BlocBuilder<ProcessOrderBloc, ProcessOrderState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state.detailStatus == ProcessDetailStatus.init) {
                  return CircularProgressIndicator();
                } else if (state.detailStatus == ProcessDetailStatus.loading) {
                  return CircularProgressIndicator();
                } else if (state.detailStatus == ProcessDetailStatus.success) {
                  total = state.processDetail[0].orderDetails
                      .fold(0, (sum, element) => sum + element.price);
                  toal2 = state.processDetail[0].packageLists
                      .fold(0, (sum2, element) => sum2 + element.price);
                  total3 = toal2 + total;
                  return Column(
                    children: [
                      Text(
                        'Thông tin hóa đơn',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      BlocBuilder<AccessoryBloc, AccessoryState>(
                          // ignore: missing_return
                          builder: (context, accState) {
                        if (accState.status == ListAccessoryStatus.init) {
                          return CircularProgressIndicator();
                        } else if (accState.status ==
                            ListAccessoryStatus.loading) {
                          return CircularProgressIndicator();
                        } else if (accState.status ==
                            ListAccessoryStatus.success) {
                          return Column(children: [
                            state.processDetail[0].packageLists != null &&
                                    state.processDetail[0].packageLists
                                        .isNotEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dịch vụ bảo dưỡng: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            for (int j = 0;
                                j < state.processDetail[0].packageLists.length;
                                j++)
                              ExpansionTile(
                                title: Text(state
                                    .processDetail[0].packageLists[j].name),
                                trailing: Text(_convertMoney(state
                                    .processDetail[0].packageLists[j].price
                                    .toDouble())),
                                children: [
                                  for (int k = 0;
                                      k <
                                          state.processDetail[0].packageLists[j]
                                              .orderDetails.length;
                                      k++)
                                    ListTile(
                                      title: Text(state
                                          .processDetail[0]
                                          .packageLists[j]
                                          .orderDetails[k]
                                          .name),
                                    ),
                                ],
                              ),
                            state.processDetail[0].orderDetails != null &&
                                    state.processDetail[0].orderDetails
                                        .isNotEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dịch vụ bổ sung: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            for (int i = 0;
                                i < state.processDetail[0].orderDetails.length;
                                i++)
                              // countPrice += service.price;

                              state.processDetail[0].orderDetails != null &&
                                      state.processDetail[0].orderDetails
                                          .isNotEmpty
                                  ? ExpansionTile(
                                      title: Text(state.processDetail[0]
                                          .orderDetails[i].name),
                                      trailing: Text(_convertMoney(state
                                                  .processDetail[0]
                                                  .orderDetails[i]
                                                  .price
                                                  .toDouble() !=
                                              0
                                          ? state.processDetail[0]
                                              .orderDetails[i].price
                                              .toDouble()
                                          : 0)),
                                      children: [
                                        accState.accessoryList.indexWhere(
                                                    (element) =>
                                                        element.id ==
                                                        state
                                                            .processDetail[0]
                                                            .orderDetails[i]
                                                            .accessoryId) >=
                                                0
                                            ? ListTile(
                                                title: Text(accState
                                                    .accessoryList
                                                    .firstWhere((element) =>
                                                        element.id ==
                                                        state
                                                            .processDetail[0]
                                                            .orderDetails[i]
                                                            .accessoryId)
                                                    .name),
                                                trailing: Image.network(accState
                                                    .accessoryList
                                                    .firstWhere((element) =>
                                                        element.id ==
                                                        state
                                                            .processDetail[0]
                                                            .orderDetails[i]
                                                            .accessoryId)
                                                    .imageUrl),
                                              )
                                            : Text(
                                                'Hiện tại không có phụ tùng'),
                                      ],
                                    )
                                  : Text('Không có dịch vụ bổ sung nào'),
                          ]);
                        }
                        ;
                      }),
                      Divider(
                        color: Colors.black,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                          title: Text(
                            'Tổng cộng: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900),
                          ),
                          trailing: Text(
                            _convertMoney(
                                total3.toDouble() != 0 ? total3.toDouble() : 0),
                          )),
                      Divider(
                        color: Colors.black,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Container(
                        child: GestureDetector(
                          child: Container(
                            color: Colors.white24,
                            height: 100,
                            width: 100,
                            child: _image != null
                                ? Image.file(
                                    _image,
                                    fit: BoxFit.fill,
                                  )
                                : Icon(Icons.add_a_photo),
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            _showPicker(context);
                          },
                        ),
                      ),
                      BlocListener<UpdateStatusOrderBloc,
                          UpdateStatusOrderState>(
                        // ignore: missing_return
                        listener: (builder, statusState) {
                          if (statusState.status ==
                              UpdateStatus.updateWaitingAndAvailSuccess) {
                            Navigator.pushNamed(context, '/manager');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppTheme.colors.blue),
                                child: Text('Hoàn tất dịch vụ',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () async {
                                  String url = await uploadImage();

                                  print(url);
                                  print(state.processDetail[0].id);
                                  setState(() {
                                    var result3 = _repo.addImage(
                                        state.processDetail[0].id, imgUrl);
                                    // setState(() {
                                    //   if (result3 == "Success") {
                                    //     print('add Image success');
                                    //   } else {
                                    //     print('add failed');
                                    //   }
                                    //   print(result3);
                                    // });
                                  });
                                  updateStatusBloc.add(
                                      UpdateStatusFinishAndAvailableButtonPressed(
                                          id: state.processDetail[0].id,
                                          listData: state
                                              .processDetail[0].crew.members,
                                          status: waitingStatus,
                                          availableStatus: availStatus));
                                  // updateStatusBloc.add(
                                  //     UpdateStatusButtonPressed(
                                  //         id: state.processDetail[0].id,
                                  //         status: processingStatus));
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ManagerMain()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state.detailStatus == ProcessDetailStatus.error) {
                  return ErrorWidget(state.message.toString());
                }
              },
            ),
          ),
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
