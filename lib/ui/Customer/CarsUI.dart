// import 'package:car_service/ui/Customer/carCard.dart';
import 'package:car_service/blocs/customer_car/customerCar_bloc.dart';
import 'package:car_service/blocs/customer_car/customerCar_event.dart';
import 'package:car_service/blocs/customer_car/customerCar_state.dart';
import 'package:car_service/ui/Customer/CarDetailUI.dart';
import 'package:car_service/utils/model/CarModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  CustomerCarBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CustomerCarBloc>(context);
    bloc.add(DoFetchEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCarBloc, CustomerCarState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is InitCustomerCarState) {
          return CircularProgressIndicator();
        } else if (state is LoadingCusCarState) {
          return CircularProgressIndicator();
        } else if (state is FetchCusCarSuccess) {
          return ListView.builder(
              itemCount: state.cars.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.cars[index].tenPhim),
                  onTap: () {
                    navigateToCarDetailPage(context, state.cars[index]);
                  },
                );
              });
        } else if (state is ErrorCusCarState) {
          return ErrorWidget(state.mess.toString());
        }
      },
    );
  }

  void navigateToCarDetailPage(BuildContext context, CarModel car){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return CarDetailUi(car: car);
    }));
  }
}
