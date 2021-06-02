import 'package:car_service/ui/Customer/carCard.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CarCard()
        ],
      ),
    );
  }
}