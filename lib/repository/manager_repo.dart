import 'package:car_service/model/AssignOrderModel.dart';
import 'package:car_service/model/BookingModel.dart';
import 'package:car_service/model/StaffModel.dart';
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
          "https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/LayDanhSachNguoiDung?MaNhom=GP01"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data
            .map((booking) => bookingList.add(BookingModel.fromJson(booking)))
            .toList();
        print('lala');
        print(bookingList);
        return bookingList;
      } else {
        print('No data');
      }
    }
  }

  Future<List<AssignOrderModel>> getOrderList() async {
    List<AssignOrderModel> assignOrderList = [];
    var res = await http.get(
      Uri.parse(
          "https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/LayDanhSachNguoiDung?MaNhom=GP02"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data
            .map((booking) =>
                assignOrderList.add(AssignOrderModel.fromJson(booking)))
            .toList();
        print('lala');
        print(assignOrderList);
        return assignOrderList;
      } else {
        print('No data');
      }
    }
  }

  Future<List<StaffModel>> getStaffList() async {
    List<StaffModel> staffList = [];
    var res = await http.get(
      Uri.parse(
          "https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/LayDanhSachNguoiDung?MaNhom=GP03"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data.map((staff) => staffList.add(StaffModel.fromJson(staff))).toList();
        print('lala');
        print(staffList);
        return staffList;
      } else {
        print('No data');
      }
    }
  }

  Future<StaffModel> getStaffDetail(String email) async {
    var res = await http.get(
      Uri.parse(
          'https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/LayDanhSachNguoiDung?MaNhom=GP03&tuKhoa=' +
              email),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      try {
        if (data != null) {
          print(data);
          return data;
        } else {
          print('No data');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
