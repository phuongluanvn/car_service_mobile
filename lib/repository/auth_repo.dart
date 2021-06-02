import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  login(String email, String password) async {
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
