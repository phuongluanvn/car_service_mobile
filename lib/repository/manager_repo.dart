import 'package:car_service/model/BookingModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManagerRepository {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<List<BookingModel>> getBookingList() async {
    List<BookingModel> bookingList = [];
    var res = await http.get(
      Uri.parse(
          "https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/LayDanhSachNguoiDung?MaNhom=GP01&tuKhoa=Khoa"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data.map((booking) => bookingList.add(BookingModel.fromJson(booking)));
        print('lala');
        return bookingList;
      } else {
        print('No data');
      }
    }
  }
}
