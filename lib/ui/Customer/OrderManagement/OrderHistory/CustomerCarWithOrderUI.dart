import 'package:car_service/blocs/customer/customerCar/CustomerCar_bloc.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_event.dart';
import 'package:car_service/blocs/customer/customerCar/CustomerCar_state.dart';
import 'package:car_service/theme/app_theme.dart';
import 'package:car_service/ui/Customer/CarManagement/CustomerCarDetailUI.dart';
import 'package:car_service/ui/Customer/OrderManagement/OrderHistory/ListOfOrderWithIdUI.dart';
import 'package:car_service/utils/model/VehicleModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_service/utils/helpers/constants/CusConstansts.dart'
    as cusConstants;

class CustomerCarWithOrderUi extends StatefulWidget {
  @override
  _CustomerCarWithOrderUiState createState() => _CustomerCarWithOrderUiState();
}

class _CustomerCarWithOrderUiState extends State<CustomerCarWithOrderUi> {
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
      backgroundColor: AppTheme.colors.lightblue,
      body: Center(
        // child: SingleChildScrollView(
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
                            leading:
                                Image.asset(cusConstants.IMAGE_URL_LOGO_BLUE),
                            title: Text(_textEditingController.text.isNotEmpty
                                ? vehicleListsOnSearch[index].licensePlate
                                : state.vehicleLists[index].licensePlate),
                            subtitle: Text(
                                _textEditingController.text.isNotEmpty
                                    ? vehicleListsOnSearch[index].manufacturer +
                                        ' - ' +
                                        state.vehicleLists[index].model
                                    : state.vehicleLists[index].manufacturer +
                                        ' - ' +
                                        state.vehicleLists[index].model),
                            onTap: () {
                              print(state.vehicleLists[index].id);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ListOfOrderWithIdUi(
                                      orderId: state.vehicleLists[index].id
                                   )));
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
                  child: Text(cusConstants.NOT_FOUND_INFO_VEHICLE),
                );
            } else if (state.status == CustomerCarStatus.error) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
        // ),
      ),
    );
  }
}
