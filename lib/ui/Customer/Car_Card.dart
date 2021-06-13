import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/theme.dart';
import 'package:flutter/material.dart';



class CarCard extends StatelessWidget {
  final CarModel carModels;
  final Function onTap;
  const CarCard({
    Key key,
    this.onTap,
    this.carModels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      height: 279,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap();
              }
            },
            child: Text("hihihi")
            // Container(
            //   width: 300,
            //   height: 207,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.all(Radius.circular(20)),
            //       image: DecorationImage(
            //           image: NetworkImage("https://lh3.googleusercontent.com/proxy/eL5TvaHC9SgWrXF9fH7Ce0bz0wF2orcu29zsQDSNVMRUnaJhu6We17mPMJiGhKkI_re-9-jcD62j0oUSuMx_x32n3lXDRfHyuJyJJ8Q"),
            //           fit: BoxFit.cover)),
            // ),
          ),
          Container(
            margin: EdgeInsets.only(top: 19),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        carModels.tenPhim,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: textBlueFont.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      carModels.maNhom,
                      style: greyTextFont.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      boxStar(),
                      boxStar(),
                      boxStar(),
                      boxStar(),
                      boxStar(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
