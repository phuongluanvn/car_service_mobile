import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/model/ManufacturerModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/OrderModel.dart';
import 'package:car_service/utils/model/ServiceModel.dart';
import 'package:car_service/utils/model/VehicleModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerRepository {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': ' */*'
  };

// '{
//   "vehicleId": "e42d42cf-af6b-4e15-89df-264a7bb9ffee",
//   "packageId": null,
//   "note": "Hông có",
//   "bookingTime": "2021-07-05T15:14:57.644Z"
// }'

  createNewBooking(String vehicleId, String packageId, String note,
      String bookingTime) async {
    var body = {
      "vehicleId": '$vehicleId',
      "packageId": null,
      "note": '$note',
      "bookingTime": '$bookingTime'
    };
    var res = await http.post(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/Orders"),
      headers: headers,
      body: json.encode(body),
    );
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        return res.body;
      } else if (res.statusCode == 404) {
        return res.body;
      }
    } else {
      return null;
    }
  }

  createNewVehicle(String username, String manufacturer, String model,
      String licensePlateNumber) async {
    var body = {
      "username": '$username',
      "manufacturer": '$manufacturer',
      "model": '$model',
      "licensePlate": '$licensePlateNumber'
    };
    var res = await http.post(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/Vehicles"),
      headers: headers,
      body: json.encode(body),
    );
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        return res.body;
      } else if (res.statusCode == 404) {
        return res.body;
      }
    } else {
      return null;
    }
  }

  Future<List<VehicleModel>> getCarListOfCustomer(String username) async {
    List<VehicleModel> vehicleLists = [];
    var res = await http.get(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/Customers/" +
          username),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var enc = json.encode(data);
      var dec = json.decode(enc);

      if (dec != null) {
        dec['vehicles']
            .map((vehicle) => vehicleLists.add(VehicleModel.fromJson(vehicle)))
            .toList();
        return vehicleLists;
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

  Future<List<OrderModel>> getOrderList(String username) async {
    List<OrderModel> orderLists = [];
    var res = await http.get(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/Customers/" +
          username +
          "/orders"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data
            .map((order) => orderLists.add(OrderModel.fromJson(order)))
            .toList();
        return orderLists;
      } else {
        print('No order data');
      }
    }
  }

  Future<List<OrderDetailModel>> getOrderDetail(String id) async {
    List<OrderDetailModel> orderDetails = [];
    List test = [];
    var res = await http.get(
      Uri.parse('https://carservicesystem.azurewebsites.net/api/Orders/' + id),
      headers: headers,
    );
    // print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      test.add(data);
      print('?????');
      print(test);
      // print(data);
      try {
      if (data != null) {
        test
            .map((orderDetail) =>
                orderDetails.add(OrderDetailModel.fromJson(orderDetail)))
            .toList();
        print('Order detail');
        print(orderDetails);
        return orderDetails;
      } else {
        print('No data');
      }
      }
      catch (e) {
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

  Future<List<ManufacturerModel>> getManufacturerList() async {
    List<ManufacturerModel> manufacturerLists = [];

    var res = await http.get(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/Manufacturers"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      print(data);
      if (data != null) {
        data
            .map((order) =>
                manufacturerLists.add(ManufacturerModel.fromJson(order)))
            .toList();
        return manufacturerLists;
      } else {
        print('No manufacturer data');
        return null;
      }
    }
  }

  Future<List<String>> getListModelOfManufacturer(String namuName) async {
    List<String> modelOfManufacturer = [];
    var res = await http.get(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/Manufacturers/" + namuName),
      headers: headers,
    );
    print('model Manufacturer in repo');
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      print(data);
      if (data != null) {
        data['vehicleModels']
            .map((order) =>
                modelOfManufacturer.add((order)))
            .toList();
        return modelOfManufacturer;
      } else {
        print('No manufacturer data');
        return null;
      }
    }
  }
}
