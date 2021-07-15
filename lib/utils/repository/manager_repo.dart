import 'package:car_service/utils/model/AssignOrderModel.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/ServiceModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/TestOrderModel.dart';
import 'package:flutter/cupertino.dart';
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

    var resStaff = await http.get(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/employees"),
      headers: headers,
    );
    if (resStaff.statusCode == 200) {
      var dataProcessing = json.decode(resStaff.body);

      if (dataProcessing != null) {
        dataProcessing
            .map((order) => staffList.add(StaffModel.fromJson(order)))
            .toList();
        var newList = [...staffList];
        print('????');
        print(newList);
        return newList;
      } else {
        return null;
      }
    } else {
      print('No test order data');
      return null;
    }
  }

  Future<List<StaffModel>> getStaffDetail(String username) async {
    List<StaffModel> listdata = [];
    List convertData = [];

    var res = await http.get(
      Uri.parse('https://carservicesystem.azurewebsites.net/api/employees/' +
          username),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      convertData.add(data); //thêm [] để dùng .map bêndưới

      try {
        if (data != null) {
          convertData
              .map((element) => listdata.add(StaffModel.fromJson(element)))
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
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/Orders?status=Accepted"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);

      if (data != null) {
        data
            .map((order) => bookingList.add(OrderDetailModel.fromJson(order)))
            .toList();
        return bookingList;
      } else {
        print('No test order data');
        return null;
      }
    }
  }

  Future<List<OrderDetailModel>> getAssingOrderList() async {
    List<OrderDetailModel> checkinList = [];
    List<OrderDetailModel> acceptedList = [];
    List<OrderDetailModel> checkingList = [];

    var resAccepted = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/Orders?status=Accepted"),
      headers: headers,
    );
    var resCheckin = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/Orders?status=Checkin"),
      headers: headers,
    );
    var resChecking = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/Orders?status=Checking"),
      headers: headers,
    );
    if (resAccepted.statusCode == 200 &&
        resCheckin.statusCode == 200 &&
        resChecking.statusCode == 200) {
      var dataAccepted = json.decode(resAccepted.body);
      var dataCheckin = json.decode(resCheckin.body);
      var dataChecking = json.decode(resChecking.body);

      if (dataAccepted != null && dataCheckin != null && dataChecking != null) {
        dataAccepted
            .map((order) => acceptedList.add(OrderDetailModel.fromJson(order)))
            .toList();
        dataCheckin
            .map((order) => checkinList.add(OrderDetailModel.fromJson(order)))
            .toList();
        dataChecking
            .map((order) => checkingList.add(OrderDetailModel.fromJson(order)))
            .toList();
        var newList = [...acceptedList, ...checkinList, ...checkingList];
        print('????');
        print(newList);
        return newList;
      } else {
        return null;
      }
    } else {
      print('No test order data');
      return null;
    }
  }

  Future<List<OrderDetailModel>> getProcessOrderList() async {
    List<OrderDetailModel> processList = [];

    var resProcessing = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/Orders?status=Processing"),
      headers: headers,
    );
    if (resProcessing.statusCode == 200) {
      var dataProcessing = json.decode(resProcessing.body);

      if (dataProcessing != null) {
        dataProcessing
            .map((order) => processList.add(OrderDetailModel.fromJson(order)))
            .toList();
        var newList = [...processList];
        print('????');
        print(newList);
        return newList;
      } else {
        return null;
      }
    } else {
      print('No test order data');
      return null;
    }
  }

  Future<List<OrderDetailModel>> getTestList() async {
    List<OrderDetailModel> orderLists = [];
    var res = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/Orders?status=Booked"),
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
    } else {
      return null;
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

  Future<List<OrderDetailModel>> getOrderHistoryList() async {
    List<OrderDetailModel> finishList = [];
    List<OrderDetailModel> cancelList = [];

    var resAccepted = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/Orders?status=Finish"),
      headers: headers,
    );
    var resCheckin = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/Orders?status=Cancel"),
      headers: headers,
    );

    if (resAccepted.statusCode == 200 && resCheckin.statusCode == 200) {
      var dataAccepted = json.decode(resAccepted.body);
      var dataCheckin = json.decode(resCheckin.body);

      if (dataAccepted != null && dataCheckin != null) {
        dataAccepted
            .map((order) => finishList.add(OrderDetailModel.fromJson(order)))
            .toList();
        dataCheckin
            .map((order) => cancelList.add(OrderDetailModel.fromJson(order)))
            .toList();

        var newList = [
          ...finishList,
          ...cancelList,
        ];
        print('????');
        print(newList);
        return newList;
      } else {
        return null;
      }
    } else {
      print('No test order data');
      return null;
    }
  }
}
