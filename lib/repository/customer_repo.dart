import 'package:car_service/model/CarModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerRepository {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  getCarList() async {
    var res = await http.post(
        Uri.parse(
            "https://movie0706.cybersoft.edu.vn/api/QuanLyPhim/LayDanhSachPhim?maNhom=GP01"),
        headers: headers,
        body: {});
    final data = (res.body);
    print(data);
    if (data != null) {
      return data;
    } else {
      return null;
    }
  }

  Future<List<CarModel>> fetchCarList() async {
    List<CarModel> carsList = [];
    var response = await http.get(
        Uri.parse(
            "https://movie0706.cybersoft.edu.vn/api/QuanLyPhim/LayDanhSachPhim?maNhom=GP01"),
        headers: headers,
        );
    final data = (response.body);
    print(data);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data.map((car) => carsList.add(CarModel.fromJson(car))).toList();
      return carsList;
    } 
  }
}
