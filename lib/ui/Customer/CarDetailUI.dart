
import 'package:car_service/utils/model/CarModel.dart';
import 'package:flutter/material.dart';

class CarDetailUi extends StatefulWidget {
  CarModel car;
  CarDetailUi({this.car});

  @override
  _CarDetailUiiState createState() => _CarDetailUiiState();
}

class _CarDetailUiiState extends State<CarDetailUi> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              child: Text(
                widget.car.tenPhim,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ),
            Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.all(5.0),
                child: Text(
                  widget.car.maNhom,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )),
          ],
        ))
      ],
    );
  }
}
