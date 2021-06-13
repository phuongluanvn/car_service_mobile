// import 'package:car_service/ui/Customer/carCard.dart';
import 'package:car_service/blocs/customer_car/customerCar_bloc.dart';
import 'package:car_service/blocs/customer_car/customer_state.dart';
import 'package:car_service/blocs/customer_car/customer_cubit.dart';
import 'package:car_service/ui/Customer/CarDetailUI.dart';
import 'package:car_service/ui/Customer/Car_Card.dart';
import 'package:car_service/ui/Customer/disney_card.dart';
import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  // CustomerCarBloc bloc;

  @override
  void initState() {
    context.read<CarCustomerCubit>().getCars();
    super.initState();
  }

  @override
  void dispose() {
    // bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFFFDFDFE),
                  Color(0xFFF3F4F8),
                ]
              )
            ),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(defaultMargin, 33, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Moviez",
                            style: textBlueFont.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                          Text(
                            "Watch much esier",
                            style: greyTextFont,
                          )
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 45,
                        width: 55,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                        ),
                        child: Icon(Icons.search_rounded,
                            color: blueColor, size: 22),
                      )
                    ],
                  ),
                ),

                // List Of movie
                Container(
                    margin: EdgeInsets.only(
                        left: defaultMargin, top: defaultMargin),
                    height: 300,
                    width: double.infinity,
                    child: BlocBuilder<CarCustomerCubit, CustomerCarState>(
                        builder: (context, state) => (state is CarLoaded)
                            ? Padding(
                                padding: EdgeInsets.all(10),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: state.carModel
                                      // .sublist(0, 11)
                                      .map((e) => Padding(
                                            padding: EdgeInsets.only(
                                                left: (e ==
                                                        state.carModel.first)
                                                    ? 24
                                                    : 0),
                                            child: CarCard(
                                              onTap: () {
                                                Get.to(CarDetailUI(
                                                  carModel: e,
                                                ));
                                              },
                                              carModels: e,
                                            ),
                                          ))
                                      .toList(),
                                ),
                              )
                            : Center(
                                child: Text("No Data"),
                              ))),

                // Text Form Disney

                Container(
                  margin: EdgeInsets.only(top: 30, left: defaultMargin),
                  child: Text(
                    "From Disney",
                    style: textBlueFont.copyWith(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                    margin: EdgeInsets.only(left: defaultMargin),
                    height: 500,
                    child: BlocBuilder<CarCustomerCubit, CustomerCarState>(
                        builder: (context, state) => (state is CarLoaded)
                            ? ListView(
                                children: state.carModel
                                    // .sublist(11, 20)
                                    .map((e) => DisneyCard(
                                          carModel: e,
                                        ))
                                    .toList(),
                              )
                            : Center(
                                child: Text("No data"),
                              )))
              ],
            ),
          )
        ],
      ),
    );
  }
}
