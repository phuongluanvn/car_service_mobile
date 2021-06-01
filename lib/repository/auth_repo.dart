import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  login(String email, String password) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };

    final body = jsonEncode({"taiKhoan": '${email}', "matKhau": '${password}'});

    var res = await http.post(
        Uri.parse(
            "https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/DangNhap"),
        headers: headers,
        body: body);
    final data = (res.body);
    print(data);
    if (data != null) {
      return data;
    } else {
      return null;
    }
    // if (data['message'] == "manager logged in" ||
    //     data['message' == "customer logged in"] ||
    //     data['message' == 'staff logged in']) {
    //   return data;
    // } else {
    //   return "auth problem";
    // }

    // var testt = await http.get(Uri.parse(
    //     "https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/LayDanhSachNguoiDung?MaNhom=GP01"),
    //     headers: {},
    //     );
    // print(testt.body);
  }
}
