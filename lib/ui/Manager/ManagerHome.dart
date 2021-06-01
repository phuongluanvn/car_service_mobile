import 'package:flutter/material.dart';

class ManagerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Hello Manager",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
