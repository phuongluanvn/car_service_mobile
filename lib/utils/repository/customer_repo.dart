import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/model/OrderModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerRepository {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<List<CarModel>> getCarList() async {
    List<CarModel> carLists = [];
    var res = await http.get(
      Uri.parse(
          "https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/LayDanhSachNguoiDung?MaNhom=GP01&tuKhoa=abc"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data.map((car) => carLists.add(CarModel.fromJson(car))).toList();
        print(carLists);
        print('dudu');
        return carLists;
      } else {
        print('No data');
      }
    }
  }

  Future<List<CarModel>> getCarDetail(String email) async {
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
          List<CarModel> listdata = [];
          data.forEach((element) {
            Map<String, dynamic> map = element;
            listdata.add(CarModel.fromJson(map));
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

    Future<List<OrderModel>> getOrderList() async {
    List<OrderModel> orderLists = [];
    var res = await http.get(
      Uri.parse(
          "https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/LayDanhSachNguoiDung?MaNhom=GP01"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data.map((order) => orderLists.add(OrderModel.fromJson(order))).toList();
        print(orderLists);
        print('dudu');
        return orderLists;
      } else {
        print('No data');
      }
    }
  }

  Future<List<OrderModel>> getOrderDetail(String email) async {
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
          List<OrderModel> listdata = [];
          data.forEach((element) {
            Map<String, dynamic> map = element;
            listdata.add(OrderModel.fromJson(map));
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
}
