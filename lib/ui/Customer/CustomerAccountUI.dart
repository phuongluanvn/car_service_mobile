import 'package:flutter/material.dart';

class CustomerAccountUi extends StatefulWidget {
  // CustomerAccountUi() : super(key: key);

  @override
  _CustomerAccountUiState createState() => _CustomerAccountUiState();
}

class _CustomerAccountUiState extends State<CustomerAccountUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      backgroundColor: Colors.blue[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  overflow: Overflow.visible,
                  children: [
                    CircleAvatar(),
                    Positioned(
                      right: -16,
                      bottom: 0,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: OutlineButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.white),
                          ),
                          color: Color(0xFFF5F6F9),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Name:'),
                        Text('Luan Dang'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Email:'),
                        Text('abc@213.com'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Phone Number:'),
                        Text('123456789'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Address:'),
                        Text('aabc'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Expanded(child: Text('Logout')),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
