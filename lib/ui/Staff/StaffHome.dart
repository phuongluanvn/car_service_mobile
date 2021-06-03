import 'package:flutter/material.dart';

class StaffHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text(
            "Hello Staff",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
