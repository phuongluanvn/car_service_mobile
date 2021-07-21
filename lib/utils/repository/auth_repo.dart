import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  login(String username, String password) async {
    FirebaseMessaging _message = FirebaseMessaging.instance;
    String token = await _message.getToken();
    print("token ne");
    print(token);
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
        print(body);
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        return res.body;
      } else if (res.statusCode == 404) {
        return res.body;
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

  signUp(String user, String name, String email, String phone,
      String password) async {
    final body = jsonEncode({
      "taiKhoan": '${user}',
      "hoTen": '${name}',
      "email": '${email}',
      "soDt": '${phone}',
      "matKhau": '${password}',
      "maLoaiNguoiDung": 'KhachHang',
      "maNhom": "GP01",
    });

    var res = await http.post(
        Uri.parse(
            "https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/DangKy"),
        headers: headers,
        body: body);
    final data = (res.body);
    print(data);
    if (data != null) {
      return data;
    } else {
      return null;
    }
  }
}
