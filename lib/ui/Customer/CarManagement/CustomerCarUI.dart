import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CarManagement/CreateCustomerCarUI.dart';
import 'package:car_service/ui/Customer/CarManagement/CustomerCarDetailUI.dart';
import 'package:car_service/utils/model/VehicleModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerCarUi extends StatefulWidget {
  @override
  _CustomerCarUiState createState() => _CustomerCarUiState();
}

class _CustomerCarUiState extends State<CustomerCarUi> {
  Image image;
  TextEditingController _textEditingController = TextEditingController();
  List<VehicleModel> vehicleListsOnSearch = [];

  @override
  void initState() {
    super.initState();
    context.read<CustomerCarBloc>().add(DoCarListEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách xe'),
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.colors.deepBlue,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => CreateCustomerCarUI()));
              },
              child: Icon(Icons.add_box_outlined),
            ),
          )
        ],
      ),
      backgroundColor: AppTheme.colors.lightblue,
      body: SingleChildScrollView(
        child: BlocBuilder<CustomerCarBloc, CustomerCarState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state.status == CustomerCarStatus.init) {
              return CircularProgressIndicator();
            } else if (state.status == CustomerCarStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == CustomerCarStatus.loadedCarSuccess) {
              if (state.vehicleLists != null && state.vehicleLists.isNotEmpty)
                return Center(
                  child: ListView.builder(
                    itemCount: _textEditingController.text.isNotEmpty
                        ? vehicleListsOnSearch.length
                        : state.vehicleLists.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      //hiển thị list xe
                      return Card(
                        child: Column(children: [
                          ListTile(
                            leading: Image.asset('lib/images/logo_blue.png'),
                            title: Text(_textEditingController.text.isNotEmpty
                                ? vehicleListsOnSearch[index].licensePlate
                                : state.vehicleLists[index].licensePlate),
                            subtitle: Text(
                                _textEditingController.text.isNotEmpty
                                    ? vehicleListsOnSearch[index].manufacturer + ' - ' + state.vehicleLists[index].model
                                    : state.vehicleLists[index].manufacturer+ ' - ' + state.vehicleLists[index].model),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => CustomerCarDetailUi(
                                      id: state.vehicleLists[index].id,
                                      manuName: state.vehicleLists[index].manufacturer,
                                      modelName: state.vehicleLists[index].model)));
                            },
                          ),
                        ]),
                      );
                    },
                  ),
                );
              //   ],
              // );
              else
                return Center(
                  child: Text('Không có thông tin xe'),
                );
            } else if (state.status == CustomerCarStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),

      //thêm mới xe
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (_) => CreateCustomerCarUI()));
      //   },
      //   child: const Icon(Icons.add),
      //   backgroundColor: Colors.blue[600],
      // ),
    );
  }

  // Widget _buildSearch() => SearchWidget(
  //   dataList: dataList,
  //   popupListItemBuilder: popupListItemBuilder,
  //   selectedItemBuilder: selectedItemBuilder,
  //   queryBuilder: queryBuilder)
}
