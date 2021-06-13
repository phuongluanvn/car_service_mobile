import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/services/services.dart';
import 'package:car_service/utils/theme.dart';
import 'package:flutter/material.dart';

class CarDetailUI extends StatelessWidget {
  final CarModel carModel;

  const CarDetailUI({
    Key key,
    this.carModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarModel carModel;

    return Scaffold(
      backgroundColor: Color(0xFFF3F4F8),
      body: FutureBuilder(
        future: CarServices.getCarDetail(carModel),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            carModel = snapshot.data;
            print("//");
            print("?????");
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Container(
                    width: MediaQuery.of(context).size.width - 2 * 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          carModel.tenPhim,
                          style: textBlueFont.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        )
                      ],
                    ),
                  ),
                  backgroundColor: blueColor,
                  pinned: true,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vectorstock.com%2Froyalty-free-vectors%2Fcar-avatar-race-vectors&psig=AOvVaw2QpQeYjDIyNsPKrU_YzwWc&ust=1623510807482000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKC4yZzvj_ECFQAAAAAdAAAAABAD'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 12),
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      carModel.tenPhim,
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      style: textBlueFont.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 20,
                                    color: greyColor,
                                    width: 1,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  // Text(
                                  //   carModel.maPhim,
                                  //   style: greyTextFont.copyWith(fontSize: 16),
                                  // ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  boxStar(),
                                ],
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(top: 14),
                              //   height: 25,
                              //   width: double.infinity,
                              //   child: ListView.builder(
                              //       scrollDirection: Axis.horizontal,
                              //       itemBuilder: (context, index) {
                              //         return Container(
                              //           margin: EdgeInsets.only(right: 5),
                              //           decoration: BoxDecoration(
                              //               color: Color(0xFFCBD7D6),
                              //               borderRadius:
                              //                   BorderRadius.circular(10)),
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(5),
                              //             child: Center(
                              //                 child: Text(
                              //               carModel.genres[index],
                              //               style: textBlueFont,
                              //             )),
                              //           ),
                              //         );
                              //       },
                              //       itemCount: carModel.genres.length),
                              // ),
                            ],
                          )),
                      // Container(
                      //     margin:
                      //         EdgeInsets.symmetric(horizontal: defaultMargin),
                      //     child: Html(
                      //       data: carModel.description,
                      //     )),
                      //     SizedBox(height: 20,)
                    ],
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Container(
              child: Text("Something Error"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
