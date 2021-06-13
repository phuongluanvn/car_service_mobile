import 'package:car_service/utils/model/CarModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerRepository {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<List<CarModel>> fetchCarList() async {
    List<CarModel> carsList = [];
    var response = await http.get(
        Uri.parse(
            "https://movie0706.cybersoft.edu.vn/api/QuanLyPhim/LayDanhSachPhim?maNhom=GP01"),
        headers: headers,
        );
        print(response);
    // final data = (response.body);
    // print(data);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      carsList = data.map((car) => CarModel.fromJson(car)).toList();
      print(data);
      return data;
    } 
  }

  Future<CarModel> getCarDetail(String name) async {
    var res = await http.get(
      Uri.parse(
          'https://movie0706.cybersoft.edu.vn/api/QuanLyPhim/LayDanhSachPhim?maNhom=GP01&tenPhim=' +
              name),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        return data;
      } else {
        print('No data');
      }
    }
  }
}
