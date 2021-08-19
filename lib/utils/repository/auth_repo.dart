import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  String BASE_URL = "https://carservicesystem.azurewebsites.net/api/";

  login(String username, String password) async {
    FirebaseMessaging _message = FirebaseMessaging.instance;
    String token = await _message.getToken();
    final body = jsonEncode({
      "username": '${username}',
      "password": '${password}',
      "device_Token": '${token}'
      // "deviceToken": '${token}',
    });
    var res = await http.post(
        Uri.parse('https://carservicesystem.azurewebsites.net/api/Users'),
        headers: headers,
        body: body);
    print(res.statusCode);
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        return res.body;
      } else if (res.statusCode == 404) {
        return res;
      }
    } else {
      return res.body;
    }
  }

// {
//   "username": "chonwang",
//   "role": "customer",
//   "deviceToken": "",
//   "profile": {
//     "Fullname": "Chon Chin Wang",
//     "PhoneNumber": "0917381007",
//     "Address": "Ninh Kieu, Can Tho",
//     "Email": "chonwang@gmail.com",
//     "AccumulatedPoint": 0
//   },
//   "jwt": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImNob253YW5nIiwicm9sZSI6ImN1c3RvbWVyIiwibmJmIjoxNjI0ODQ4NDU4LCJleHAiOjE2MjQ4NTIwNTgsImlhdCI6MTYyNDg0ODQ1OH0.eTitfG3IZoOhtUikOUQisY76s5QzpW7G5jVEHu3exFk"
// }

  signUp(String username, String password, String email, String fullname,
      String phoneNumber, String address) async {
    final body = jsonEncode({
      "username": username,
      "password": password,
      "email": email,
      "fullname": fullname,
      "phoneNumber": phoneNumber,
      "address": address
    });

    var res = await http.post(Uri.parse(BASE_URL + "customers"),
        headers: headers, body: body);
    final data = (res.body);
    if (data != null) {
      return data;
    } else {
      return res.body;
    }
  }
}
