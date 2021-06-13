import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/theme.dart';
import 'package:flutter/material.dart';


class DisneyCard extends StatelessWidget {
  final CarModel carModel;
  const DisneyCard({
    Key key,
    this.carModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 127,
      child: Row(
        children: [
          Container(
            height: 127,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: NetworkImage(carModel.hinhAnh), fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  carModel.tenPhim,
                  style: textBlueFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  carModel.maNhom,
                  style: greyTextFont.copyWith(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Row(
                  children: [
                    boxStar(),
                    boxStar(),
                    boxStar(),
                    boxStar(),
                  ],
                ),
                Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
