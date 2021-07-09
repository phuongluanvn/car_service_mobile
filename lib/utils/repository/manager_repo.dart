import 'package:car_service/utils/model/AssignOrderModel.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/ServiceModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/TestOrderModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManagerRepository {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  createOrder(String manufacture, String licensePlateNumber) async {
    return 'Thanh cong';
  }

  Future<List<BookingModel>> getVerifyBookingDetail(String email) async {
    var res = await http.get(
      Uri.parse(
          'https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/LayDanhSachNguoiDung?MaNhom=GP01&tuKhoa=' +
              email),
      headers: headers,
    );
    if (res.statusCode == 200) {
      List<dynamic> data = json.decode(res.body);

      try {
        if (data != null) {
          List<BookingModel> listdata = [];
          data.forEach((element) {
            Map<String, dynamic> map = element;
            listdata.add(BookingModel.fromJson(map));
          });
          print(listdata);
          return listdata;
        } else {
          print('No data');
        }
      } catch (e) {
        print(e.toString());
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

  Future<List<AssignOrderModel>> getOrderDetail(String email) async {
    var res = await http.get(
      Uri.parse(
          'https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/LayDanhSachNguoiDung?MaNhom=GP02&tuKhoa=' +
              email),
      headers: headers,
    );
    if (res.statusCode == 200) {
      List<dynamic> data = json.decode(res.body);

      try {
        if (data != null) {
          List<AssignOrderModel> listdata = [];
          data.forEach((element) {
            Map<String, dynamic> map = element;
            listdata.add(AssignOrderModel.fromJson(map));
          });
          print(listdata);
          return listdata;
        } else {
          print('No data');
        }
      } catch (e) {
        print(e.toString());
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
      print("object");
      print(data);
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

  Future<List<StaffModel>> getStaffDetail(String email) async {
    var res = await http.get(
      Uri.parse(
          'https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/LayDanhSachNguoiDung?MaNhom=GP03&tuKhoa=' +
              email),
      headers: headers,
    );
    if (res.statusCode == 200) {
      List<dynamic> data = json.decode(res.body);

      try {
        if (data != null) {
          List<StaffModel> listdata = [];
          data.forEach((element) {
            Map<String, dynamic> map = element;
            listdata.add(StaffModel.fromJson(map));
          });
          print(listdata);
          return listdata;
        } else {
          print('No data');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<List<ServiceModel>> getServiceList() async {
    List<ServiceModel> serviceLists = [];
    var res = await http.get(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/Services"),
      headers: headers,
    );
    print(res);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data
            .map((order) => serviceLists.add(ServiceModel.fromJson(order)))
            .toList();
        return serviceLists;
      } else {
        print('No service data');
        return null;
      }
    }
  }

  Future<List<BookingModel>> getBookingOrderList() async {
    List<BookingModel> bookingList = [];
    var res = await http.get(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/Orders"),
      headers: headers,
    );
    print(res);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data
            .map((order) => bookingList.add(BookingModel.fromJson(order)))
            .toList();
        return bookingList;
      } else {
        print('No test order data');
        return null;
      }
    }
  }

  Future<List<BookingModel>> getVerifyOrderDetail(String id) async {
    var res = await http.get(
      Uri.parse('https://carservicesystem.azurewebsites.net/api/Orders/' + id),
      headers: headers,
    );
    if (res.statusCode == 200) {
      List<dynamic> data = json.decode(res.body);

      try {
        if (data != null) {
          List<BookingModel> listdata = [];
          data.forEach((element) {
            Map<String, dynamic> map = element;
            listdata.add(BookingModel.fromJson(map));
          });
          print('Has data');
          print(listdata);
          return listdata;
        } else {
          print('No data');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
