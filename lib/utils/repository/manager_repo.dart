import 'package:car_service/utils/model/AssignOrderModel.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
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

  Future<List<OrderDetailModel>> getBookingOrderList() async {
    List<OrderDetailModel> bookingList = [];
    var res = await http.get(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/Orders"),
      headers: headers,
    );
    
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data
            .map((order) => bookingList.add(OrderDetailModel.fromJson(order)))
            .toList();
        print(bookingList);
        return bookingList;
        
      } else {
        print('No test order data');
        return null;
      }
    }
  }

    Future<List<OrderDetailModel>> getTestList() async {
    List<OrderDetailModel> orderLists = [];
    var res = await http.get(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/Orders"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data
            .map((order) => orderLists.add(OrderDetailModel.fromJson(order)))
            .toList();
        return orderLists;
      } else {
        print('No order data');
      }
    }
  }

  Future<List<OrderDetailModel>> getVerifyOrderDetail(String id) async {
    List<OrderDetailModel> listdata = [];
    List convertData = [];

    var res = await http.get(
      Uri.parse('https://carservicesystem.azurewebsites.net/api/Orders/' + id),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      convertData.add(data); //thêm [] để dùng .map bêndưới

      try {
        if (data != null) {
          convertData
              .map(
                  (element) => listdata.add(OrderDetailModel.fromJson(element)))
              .toList();
          return listdata;
        } else {
          print('No detail order data');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  updateStatusOrder(String id, String status) async {
    var body = {
      "id": '$id',
      "status": '$status',
    };
    var res = await http.put(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/Orders"),
      headers: headers,
      body: json.encode(body),
    );
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        return res.body;
      }
    } else {
      return null;
    }
  }
}
