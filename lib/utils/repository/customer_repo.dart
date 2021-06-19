import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/model/ManufacturerModel.dart';
import 'package:car_service/utils/model/OrderModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerRepository {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  createCar(String manufacture, String model, String licensePlateNumber) async{
    return 'Thanh cong';
  }

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

// Future<List<ManufacturerModel>> getManufacturerList() async {
//     List<ManufacturerModel> manufacturerLists = [];
//     var res = await http.get(
//       Uri.parse(
//           "https://carservicesystem.azurewebsites.net/api/Manufacturers"),
//       headers: headers,
//     );
//     if (res.statusCode == 200) {
//       var data = json.decode(res.body);
//       print('duduasasas');
//       print(data);
//       print('dudu');
//       if (data != null) {
//         data.map((manufacturer) => manufacturerLists.add(ManufacturerModel.fromJson(manufacturer))).toList();
//         print(manufacturerLists);
        
//         return manufacturerLists;
//       } else {
//         print('No data');
//       }
//     }
//   }
}
